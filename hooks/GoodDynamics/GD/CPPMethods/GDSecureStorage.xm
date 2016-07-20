
#include <string>
#include <typeinfo>

// int GD::GDSecureStorage::handleWrongPwd()()
int (*orig__ZN2GD15GDSecureStorage14handleWrongPwdEv) ();
int replaced__ZN2GD15GDSecureStorage14handleWrongPwdEv ()
{
	DDLogVerbose(@"[Good Dynamics - CPP] GD::GDSecureStorage::handleWrongPwd() and returning 0");
	// return orig__ZN2GD15GDSecureStorage14handleWrongPwdEv();
	return 0;
}

// int GD::GDSecureStorage::wipeDevice(GD::WIPE_REASON)(void arg0)
int (*orig__ZN2GD15GDSecureStorage10wipeDeviceENS_11WIPE_REASONE) (void *arg1);
int replaced__ZN2GD15GDSecureStorage10wipeDeviceENS_11WIPE_REASONE (void *arg1)
{
	DDLogVerbose(@"[Good Dynamics - CPP] GD::GDSecureStorage::wipeDevice and returning 0");
	return 0;
}




// // int GD::GDSecureStorage::setIsRemoteLocked(bool)(bool arg0)
// int (*orig__ZN2GD15GDSecureStorage17getIsRemoteLockedEv) ();
// int replaced__ZN2GD15GDSecureStorage17getIsRemoteLockedEv ()
// {
	
// 	int ret = orig__ZN2GD15GDSecureStorage17getIsRemoteLockedEv();
// 	NSLog(@"getisremotelocked %d", ret);
// 	return 0;
// }


// int (*orig__ZN2GD15GDSecureStorage17executeRemoteLockEb) (bool arg1);
// int replaced__ZN2GD15GDSecureStorage17executeRemoteLockEb (bool arg1)
// {
// 	// if (arg1 == true) NSLog(@"bool true");
// 	bool test = false;
// 	int ret = orig__ZN2GD15GDSecureStorage17executeRemoteLockEb(test);
// 	NSLog(@"===----====== %d", ret);
// 	return ret;
// }


