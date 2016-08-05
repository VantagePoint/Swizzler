#!/usr/bin/python

'''
Library dependencies:
	pycrypto - sudo easy_install pycrypto
	pbkdf2 - https://github.com/mitsuhiko/python-pbkdf2
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
	# print filepath
	if os.path.isdir(filepath):
		raise Exception("Path is a directory")

	filesize = os.path.getsize(filepath)
	data_size = filesize - 125

	f = open(filepath, 'r')

	f.seek(0)
	file_version = f.read(2)
	if (file_version.encode('hex') == "0303") or (file_version.encode('hex') == "0302"):

		loop = 0
		decrypted = ""

		while data_size > 0:
			if loop == 0:
				f.seek(109)
				initial_seed = f.read(16)
				if initial_seed == "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00":
					return "still need to figure out"
				iv = getIVforPage(initial_seed, key, loop)
				# print iv.encode('hex')
				f.seek(125)
				to_decrypt = f.read(1024)
				decrypted += aes_cbc_decrypt(to_decrypt, iv, key)
				# print decrypted.encode('hex')
			else:
				f.seek(125+(loop*1024))
				to_decrypt = f.read(1024)
				iv = getIVforPage(initial_seed, key, loop)
				decrypted += aes_cbc_decrypt(to_decrypt, iv, key)

			loop += 1
			data_size = data_size - 1024

		# decrypted = filter(lambda x: x in string.printable, decrypted)

		return decrypted
	else:
		return "still need to figure out"



def encrypt_file(initial_seed, filepath, key):
	filesize = os.path.getsize(filepath)

	f = open(filepath, 'r')

	loop = 0
	encrypted = ""

	while filesize > 0:
		iv = getIVforPage(initial_seed, key, loop)
		f.seek(0+(1024*loop))
		data_to_encrypt = f.read(1024)
		encrypted += aes_cbc_encrypt(data_to_encrypt, iv, key)
	
		filesize = filesize - 1024
		loop += 1

	return encrypted
# ======================================================================================================================== #
# Program Start
# ======================================================================================================================== #

# Program args
encrypted_file = sys.argv[1]
file_to_encrypt = sys.argv[2]
encryption_key = sys.argv[3]

# print decrypt_file("result", unhexlify(encryption_key))


# Get initial seed from original file
f = open(encrypted_file, 'r')
f.seek(109)
initial_seed = f.read(16)
f.close()

# Get the header from the original file
f = open(encrypted_file, 'r')
head = f.read(125)
f.close()

# Pass initial seed, file to encrypt and enc key.
result = encrypt_file(initial_seed, file_to_encrypt, unhexlify(encryption_key))

# Write encrypted data to file. Starting with the file header.
f = open("result", 'w')
f.write(head)
f.write(result)
f.close()





# ./encrypt_GDFS.py 608f451bf3593931c3880ff5e2b7bf41/.MContainer/AoKrwm4f8yX9zFzqwrvZWQDy4YACJYvixxNTRfxOwfCX 608f451bf3593931c3880ff5e2b7bf41_decrypted/MContainer/ProvisionData.cfg 2418296e7c46e789815811f820356542bee3a624d912e2ee0e46ea884cd73cc2
