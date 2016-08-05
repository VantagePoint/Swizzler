#!/usr/bin/python

'''
Library dependencies:
	pycrypto - sudo easy_install pycrypto
	pbkdf2 - https://github.com/mitsuhiko/python-pbkdf2

	paramiko - ssh
	pip install paramiko
'''
import sys
from pbkdf2 import pbkdf2_bin
import hashlib
from base64 import b64encode, b64decode
import hmac
from Crypto.Cipher import AES
from binascii import unhexlify
import json
import os
import string
import shutil
import paramiko
import plistlib
import time
import subprocess
import getpass
from optparse import OptionParser


def aes_ecb_encrypt(plaintext, iv, key):
	aes = AES.new(key, AES.MODE_ECB, iv)
	return aes.encrypt(plaintext)


def aes_cbc_decrypt(encrypted, iv, key):
	# key (byte string) - The secret key to use in the symmetric cipher. It must be 16 (AES-128), 24 (AES-192), or 32 (AES-256) bytes long.
	aes = AES.new(key, AES.MODE_CBC, iv)
	return aes.decrypt(encrypted)

def aes_cbc_encrypt(plaintext, iv, key):
	# key (byte string) - The secret key to use in the symmetric cipher. It must be 16 (AES-128), 24 (AES-192), or 32 (AES-256) bytes long.
	aes = AES.new(key, AES.MODE_CBC, iv)
	return aes.encrypt(plaintext)


def HMAC_SHA512_encrypt(plaintext, key):
	hashed = hmac.new(key, plaintext, hashlib.sha512).digest()
	return hashed


def getIVforPage(initial_seed, key, page):
	initial_key = HMAC_SHA512_encrypt(initial_seed, key).encode("hex")[:64]
	# return aes_ecb_encrypt(unhexlify("000000"+str(page).zfill(2)+"000000000000000000000000"), "", unhexlify(initial_key))
	return aes_ecb_encrypt(unhexlify("000000" + str(hex(int(page))[2:]).zfill(2)+"000000000000000000000000"), "", unhexlify(initial_key))


'''
If need to manually debug file decryption function
# f = open("608f451bf3593931c3880ff5e2b7bf41/.MContainer/Agf3dE_2d5hnMNpJ55gK7GtWqchHgYaC5yElJbDVjflM", 'r')

# f.seek(109)
# initial_seed = f.read(16)

# iv = getIVforPage(initial_seed, dek, 0)

# f.seek(125)
# to_decrypt = f.read(1024)

# decrypted = aes_cbc_decrypt(to_decrypt, iv, dek)
# print decrypted.encode('hex')

# print ""

# f.seek(125+1024)
# to_decrypt = f.read(1024)
# iv = getIVforPage(initial_seed, dek, 1)
# decrypted = aes_cbc_decrypt(to_decrypt, iv, dek)

# print decrypted.encode('hex')
'''
def decrypt_file(filepath, key):
	if os.path.isdir(filepath):
		raise Exception("Path is a directory")

	filesize = os.path.getsize(filepath)
	data_size = filesize - 125

	f = open(filepath, 'r')

	f.seek(0)
	file_version = f.read(2)

	if file_version.encode('hex') == "0302":
		loop = 0
		decrypted = ""
		initial_seed = ""
		while data_size > 0:
			if loop == 0:
				f.seek(109)
				initial_seed = f.read(16)
				if initial_seed == "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00":
					return "still need to figure out"
				iv = getIVforPage(initial_seed, key, loop)

				f.seek(125)
				to_decrypt = f.read(1024)
				decrypted += aes_cbc_decrypt(to_decrypt, iv, key)
			else:
				f.seek(125+(loop*1024))
				to_decrypt = f.read(1024)
				iv = getIVforPage(initial_seed, key, loop)
				decrypted += aes_cbc_decrypt(to_decrypt, iv, key)

			loop += 1
			data_size = data_size - 1024

		return decrypted

	elif file_version.encode('hex') == "0303":
		loop = 0
		decrypted = ""
		initial_seed = ""
		file_start = 145
		while data_size > 0:
			if loop == 0:
				f.seek(file_start)
				initial_seed = f.read(16)
				iv = getIVforPage(initial_seed, key, loop)
				f.seek(file_start+16)
				to_decrypt = f.read(1024)
				decrypted += aes_cbc_decrypt(to_decrypt, iv, key)
			else:
				f.seek(file_start+16+(loop*1024))
				to_decrypt = f.read(1024)
				iv = getIVforPage(initial_seed, key, loop)
				decrypted += aes_cbc_decrypt(to_decrypt, iv, key)
			loop += 1
			data_size = data_size - 1024
		return decrypted.strip()
	else:
		return "still need to figure out"



def decrypt_restore_data(filepath):
	file_start = 145
	data_start = file_start + 16

	if os.path.isdir(filepath):
		raise Exception("Path is a directory")

	filesize = os.path.getsize(filepath)
	data_size = filesize - data_start

	f = open(filepath, 'r')

	f.seek(0)
	file_version = f.read(2)

	if (file_version.encode('hex') == "0302") or (file_version.encode('hex') == "0303"):
		loop = 0
		decrypted = ''
		initial_seed = ''
		key = ''
		while data_size > 0:
			if loop == 0:
				f.seek(file_start)
				initial_seed = f.read(16)
				key = initial_seed + initial_seed
				iv = getIVforPage(initial_seed, key, loop)
				f.seek(file_start+16)
				to_decrypt = f.read(1024)
				decrypted += aes_cbc_decrypt(to_decrypt, iv, key)
			else:
				f.seek(file_start+16+(loop*1024))
				to_decrypt = f.read(1024)
				iv = getIVforPage(initial_seed, key, loop)
				decrypted += aes_cbc_decrypt(to_decrypt, iv, key)
			loop += 1
			data_size = data_size - 1024
		return decrypted.strip()



def decode_base64(data):
	"""Decode base64, padding being optional.
	:param data: Base64 data as an ASCII byte string
	:returns: The decoded byte string.
	"""
	missing_padding = 4 - len(data) % 4

	if missing_padding:
		data += b'='* missing_padding
	return b64decode(data)


def b64_filename(f):
	if '_' in f:
		f = f.replace('_', '/')
	return f



class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def get_app_id():
	# =================================================
	# Log in to iOS device and refresh UICache
	# =================================================
	print '[+] Logging in to refresh UICache'
	ssh = paramiko.SSHClient()
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	ssh.connect('127.0.0.1', port=2222, username='root', password='alpine')
	outdata, errdata = '', ''
	chan = ssh.get_transport().open_session()
	chan.setblocking(0)
	chan.exec_command('/bin/su mobile -c /usr/bin/uicache')
	while True:  # monitoring process
	    # Reading from output streams
	    while chan.recv_ready():
	        outdata += chan.recv(1000)
	    while chan.recv_stderr_ready():
	        errdata += chan.recv_stderr(1000)
	    if chan.exit_status_ready():  # If completed
	        break
	    time.sleep(0.1)
	chan.close()

	# =================================================
	# Download plist 
	# =================================================
	print '[+] Downloading plist of installed apps'
	trans = paramiko.Transport(('127.0.0.1', 2222))
	trans.connect(username='root', password='alpine')
	sftp = paramiko.SFTPClient.from_transport(trans)
	sftp.get('/var/mobile/Library/MobileInstallation/LastLaunchServicesMap.plist', 'LastLaunchServicesMap.plist')
	trans.close()

	# =================================================
	# Read plist and show list of apps to user
	# =================================================
	print bcolors.OKGREEN + '\n[+] Here is the list of apps installed on the iOS device' + bcolors.ENDC
	apps = plistlib.readPlist('LastLaunchServicesMap.plist')
	app_list = []
	i = 0
	for key, value in apps['User'].iteritems():
		i = i+1
		app_list.append(key)
		print "{0:<4}{1:20}".format(i, key)

	# =================================================
	# Get user input, which app does user want to download
	# =================================================
	app_id = raw_input('Which app to decrypt: ')
	app_id = app_list[int(app_id)-1]
	app_gd_dir = apps['User'][app_id]['EnvironmentVariables']['HOME']

	print '\n[+] Application Dir is at: ' + app_gd_dir

	ret = {}
	ret['app_id'] = app_id
	ret['app_gd_dir'] = app_gd_dir
	
	return ret


def download_app_data(app_id, app_gd_dir):

	# =================================================
	# Zip up the app directory
	# =================================================
	print '[+] Zipping GD app directory'
	ssh = paramiko.SSHClient()
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	ssh.connect('127.0.0.1', port=2222, username='root', password='alpine')
	chan = ssh.get_transport().open_session()
	chan.setblocking(0)
	chan.exec_command('cd ' + app_gd_dir + '/Library/;' + 'zip -qr /tmp/gd.zip ' + '608f451bf3593931c3880ff5e2b7bf41')
	while True:  # monitoring process
	    # Reading from output streams
	    while chan.recv_ready():
	        outdata += chan.recv(1000)
	    while chan.recv_stderr_ready():
	        errdata += chan.recv_stderr(1000)
	    if chan.exit_status_ready():  # If completed
	        break
	    time.sleep(0.1)
	chan.close()

	# =================================================
	# Make a directory on local
	# =================================================
	if not os.path.exists(app_id):
		os.makedirs(app_id)
	p = subprocess.Popen('mkdir ' + app_id, stdout=subprocess.PIPE, shell=True)
	(output, err) = p.communicate()

	# =================================================
	# Download the zip file
	# =================================================
	print '[+] Downloading ' + app_id + ' GD directory'
	trans = paramiko.Transport(('127.0.0.1', 2222))
	trans.connect(username='root', password='alpine')
	sftp = paramiko.SFTPClient.from_transport(trans)
	sftp.get('/tmp/gd.zip', app_id + '/gd.zip')
	trans.close()

	# =================================================
	# Unzip the zip file into the created directory
	# =================================================
	print '[+] Unzipping ...'
	p = subprocess.Popen('unzip ' + app_id + '/gd.zip -d ' + app_id, stdout=subprocess.PIPE, shell=True)
	(output, err) = p.communicate()



def decrypt_app_data(app_id):
	# =================================================
	# Get the _xkp value
	# =================================================
	print '[+] Getting _xkp value from Keychain'
	ssh = paramiko.SSHClient()
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	ssh.connect('127.0.0.1', port=2222, username='root', password='alpine')
	outdata, errdata = '', ''
	chan = ssh.get_transport().open_session()
	chan.setblocking(0)
	chan.exec_command('/var/root/keychain_dumper | grep _xkp -B1 -A4 | grep ' + app_id + ' -B1 -A4 | grep "Keychain"')
	while True:  # monitoring process
	    # Reading from output streams
	    while chan.recv_ready():
	        outdata += chan.recv(1000)
	    while chan.recv_stderr_ready():
	        errdata += chan.recv_stderr(1000)
	    if chan.exit_status_ready():  # If completed
	        break
	    time.sleep(0.1)
	chan.close()

	# print outdata
	xkp = outdata.split(':')[1].strip()

	print bcolors.OKGREEN + "[+]" + bcolors.ENDC + " xkp Value: " + xkp

	# ******************************************************************************** #
	# ***** Now the decryption starts ******#
	encrypted_acontainer = app_id + '/608f451bf3593931c3880ff5e2b7bf41/.AContainer'
	decrypted_acontainer = app_id + '/608f451bf3593931c3880ff5e2b7bf41/AContainer'

	encrypted_ccontainer = app_id + '/608f451bf3593931c3880ff5e2b7bf41/.CContainer'
	decrypted_ccontainer = app_id + '/608f451bf3593931c3880ff5e2b7bf41/CContainer'

	encrypted_dcontainer = app_id + '/608f451bf3593931c3880ff5e2b7bf41/.DContainer'
	decrypted_dcontainer = app_id + '/608f451bf3593931c3880ff5e2b7bf41/DContainer'

	encrypted_mcontainer = app_id + '/608f451bf3593931c3880ff5e2b7bf41/.MContainer'
	decrypted_mcontainer = app_id + '/608f451bf3593931c3880ff5e2b7bf41/MContainer'


	# Decryption of the .DComtainer files start with a HMAC calculation
	hmac_key = xkp[:32]

	# Decrypt .gdrestoredata file
	gdrestoredata = decrypt_restore_data(encrypted_dcontainer + '/.gdrestoredata')
	gdrestoredata = filter(lambda x: x in string.printable, gdrestoredata)
	gdrestoredata = json.loads(gdrestoredata.strip())
	# print gdrestoredata

	# Decrypt .gdstartupdata
	gdstartupdata = decrypt_file(encrypted_dcontainer + '/.gdstartupdata', hmac_key)
	gdstartupdata = filter(lambda x: x in string.printable, gdstartupdata)
	gdstartupdata = json.loads(gdstartupdata.strip())

	if not os.path.exists(decrypted_dcontainer):
		os.makedirs(decrypted_dcontainer)

	f = open(decrypted_dcontainer + '/gdstartupdata', 'w')
	f.write(json.dumps(gdstartupdata, indent=4))
	f.close()

	f = open(decrypted_dcontainer + '/gdrestoredata', 'w')
	f.write(json.dumps(gdrestoredata, indent=4))
	f.close()


	# =================================================
	# Calculate the UserKeyHash to see if it matches, else quit
	# =================================================
	# Get the salt
	RandomHashSalt = b64decode(gdstartupdata['RandomHashSalt'])

	# pbkdf2 values
	SALT_LENGTH = 8
	KEY_LENGTH = 32
	HASH_FUNCTION = 'sha512'
	ITER = 12345

	# Ask user for user pass
	user_password = getpass.getpass('Please enter your user pass:')

	# Generate the UserKeyHash
	generated_UserKeyHash = pbkdf2_bin(user_password, RandomHashSalt, ITER, KEY_LENGTH, getattr(hashlib, HASH_FUNCTION))

	print '\n' + bcolors.WARNING + '[+]' + bcolors.ENDC + ' .gdstartupdata UserKeyHash: ' + gdstartupdata['UserKeyHash']
	print bcolors.WARNING + '[+]' + bcolors.ENDC + ' Calculate UserKeyHash: ' + b64encode(hashlib.sha512(generated_UserKeyHash).digest())

	if (gdstartupdata['UserKeyHash'] == b64encode(hashlib.sha512(generated_UserKeyHash).digest())):
		print bcolors.OKGREEN + 'Keys Match!' + bcolors.ENDC + '\n'
	else:
		print bcolors.FAIL + 'Keys DO NOT Match!' + bcolors.ENDC + '\n'
		print '[-] .DContainer decrypted.'
		print '[-] However, without the correct user key, the other containers cannot be decrypted.'
		quit()

	# =================================================
	# Get keys to decrypt FS
	# =================================================
	startupiv = b64decode(gdstartupdata['StartupIV'])

	# Encrypted Data Encryption Key, needs to be decrypted
	edek = b64decode(gdstartupdata['EncryptedMCKey'])
	dek = aes_cbc_decrypt(edek, startupiv, generated_UserKeyHash)[:32]
	print "[+] Data Encryption Key: " + dek.encode('hex')

	print '[+] Decrypting MContainer ...'
	shutil.copytree(encrypted_mcontainer, decrypted_mcontainer)

	for root, dirs, files in os.walk(decrypted_mcontainer):
		for d in dirs:
			orig_d = d
			d = b64_filename(d)

			if decode_base64(d)[0] == '\x02':
				folder_name = aes_cbc_decrypt(decode_base64(d)[1:], startupiv, dek).strip()
			else:
				folder_name = aes_cbc_decrypt(decode_base64(d), startupiv, dek).strip()

			folder_name = filter(lambda x: x in string.printable, folder_name)
			os.rename(decrypted_mcontainer + '/' + orig_d, decrypted_mcontainer + '/' + folder_name)

	for root, dirs, files in os.walk(decrypted_mcontainer):
		for f in files:
			orig_f = f
			f = b64_filename(f)

			try:
				if decode_base64(f)[0] == '\x02':
					file_name = aes_cbc_decrypt(decode_base64(f)[1:], startupiv, dek).strip()
				else:
					file_name = aes_cbc_decrypt(decode_base64(f), startupiv, dek).strip()
			except:
				e = sys.exc_info()[0]

			try:
				file_name = filter(lambda x: x in string.printable, file_name)
				os.rename(os.path.join(root, orig_f), os.path.join(root, file_name))

				new_file_path = os.path.join(root, file_name)
			
				data = decrypt_file(new_file_path, dek)
				data = filter(lambda x: x in string.printable, data)

				if (os.path.splitext(new_file_path)[1] == '.cfg') or (os.path.splitext(new_file_path)[1] == '.data'):
					try:
						data = json.loads(data.strip())
						data = json.dumps(data, indent=4)
					except:
						e = sys.exc_info()[0]

				f = open(new_file_path, 'w')
				f.write(data)
				f.close()
			except:
				e = sys.exc_info()[0]


	print '[+] Decrypting CContainer ...'
	shutil.copytree(encrypted_ccontainer, decrypted_ccontainer)

	for root, dirs, files in os.walk(decrypted_ccontainer):
		for d in dirs:
			orig_d = d
			d = b64_filename(d)

			if decode_base64(d)[0] == '\x02':
				folder_name = aes_cbc_decrypt(decode_base64(d)[1:], startupiv, dek).strip()
			else:
				folder_name = aes_cbc_decrypt(decode_base64(d), startupiv, dek).strip()

			folder_name = filter(lambda x: x in string.printable, folder_name)
			os.rename(decrypted_ccontainer + '/' + orig_d, decrypted_ccontainer + '/' + folder_name)

	for root, dirs, files in os.walk(decrypted_ccontainer):
		for f in files:
			orig_f = f
			f = b64_filename(f)

			try:
				if decode_base64(f)[0] == '\x02':
					file_name = aes_cbc_decrypt(decode_base64(f)[1:], startupiv, dek).strip()
				else:
					file_name = aes_cbc_decrypt(decode_base64(f), startupiv, dek).strip()
			except:
				e = sys.exc_info()[0]

			file_name = filter(lambda x: x in string.printable, file_name)
			os.rename(os.path.join(root, orig_f), os.path.join(root, file_name))

			new_file_path = os.path.join(root, file_name)
			
			data = decrypt_file(new_file_path, dek)
			data = filter(lambda x: x in string.printable, data)

			if (os.path.splitext(new_file_path)[1] == '.cfg') or (os.path.splitext(new_file_path)[1] == '.data'):
				try:
					data = json.loads(data.strip())
					data = json.dumps(data, indent=4)
				except:
					e = sys.exc_info()[0]

			f = open(new_file_path, 'w')
			f.write(data)
			f.close()



# ======================================================================================================================== #
# Program Start
# ======================================================================================================================== #

if __name__ == '__main__':

	parser = OptionParser(usage="usage: %prog [options]",version="%prog 1.0")
	parser.add_option("-a", "--all", action="store_true", default=False,help="Download and Decrypt App Data")
	parser.add_option("-d", "--decrypt", action="store_true", default=False,help="Decrypt App Data Only")

	(options, args) = parser.parse_args()
	if (options.all):
		print ("[*] Downloading and Decrypting")
		app_id = get_app_id()
		download_app_data(app_id['app_id'], app_id['app_gd_dir'])
		decrypt_app_data(app_id['app_id'])
	elif (options.decrypt):
		print ("[*] Only Decrypting")
		app_id = get_app_id()
		decrypt_app_data(app_id['app_id'])
	else:
		parser.print_help()



