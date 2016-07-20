/*
 File Description:
  
	**********************************************************************************
	** Security Framework Reference Certificate, Key, and Trust Services Reference  **
	**********************************************************************************

	https://developer.apple.com/library/ios/documentation/Security/Reference/certifkeytrustservices/index.html#//apple_ref/doc/uid/TP30000157


    SSL Pinning Bypass:
        Thanks to Alban Diquet - https://github.com/nabla-c0d3 and iSECPartners for the iOS Killswitch Project https://github.com/iSECPartners/ios-ssl-kill-switch

*/
#include "../../swizzler.common.h"
#import <Security/Security.h>


/*
Cryptography and Digital Signatures

SecKeyGeneratePair
SecKeyEncrypt
SecKeyDecrypt
SecKeyRawSign
SecKeyRawVerify
SecKeyGetBlockSize
*/

// typedef uint32_t SecPadding;
// enum
// {
//    kSecPaddingNone      = 0,
//    kSecPaddingPKCS1     = 1,
//    kSecPaddingPKCS1MD2  = 0x8000,
//    kSecPaddingPKCS1MD5  = 0x8001,
//    kSecPaddingPKCS1SHA1 = 0x8002,
// };
// OSStatus SecKeyGeneratePair ( CFDictionaryRef parameters, SecKeyRef _Nullable *publicKey, SecKeyRef _Nullable *privateKey ); 


OSStatus (*orig_SecKeyEncrypt) ( SecKeyRef key, SecPadding padding, const uint8_t *plainText, size_t plainTextLen, uint8_t *cipherText, size_t *cipherTextLen ); 
OSStatus replaced_SecKeyEncrypt ( SecKeyRef key, SecPadding padding, const uint8_t *plainText, size_t plainTextLen, uint8_t *cipherText, size_t *cipherTextLen ) {
    
    OSStatus ret = orig_SecKeyEncrypt(key, padding, plainText, plainTextLen, cipherText, cipherTextLen);

    NSLog(@"SecKeyEncrypt   Key: %@", key);
    NSLog(@"                Padding: %u", padding);
    NSLog(@"                plainText: %s", plainText);
    NSLog(@"                plainTextLen: %lu", plainTextLen);
    NSLog(@"                cipherText: %s", cipherText);
    // NSLog(@"                cipherTextLen: %@", cipherTextLen);

    return ret;
}

OSStatus (*orig_SecKeyDecrypt) ( SecKeyRef key, SecPadding padding, const uint8_t *cipherText, size_t cipherTextLen, uint8_t *plainText, size_t *plainTextLen );
OSStatus replaced_SecKeyDecrypt ( SecKeyRef key, SecPadding padding, const uint8_t *cipherText, size_t cipherTextLen, uint8_t *plainText, size_t *plainTextLen ) {
    
    OSStatus ret = orig_SecKeyDecrypt(key, padding, cipherText, cipherTextLen, plainText, plainTextLen);

    NSLog(@"SecKeyDecrypt   Key: %@", key);
    NSLog(@"                Padding: %u", padding);
    NSLog(@"                cipherText: %s", cipherText);
    NSLog(@"                cipherTextLen: %lu", cipherTextLen);
    NSLog(@"                plainText: %s", plainText);

    return ret;
}

OSStatus (*orig_SecKeyRawSign) ( SecKeyRef key, SecPadding padding, const uint8_t *dataToSign, size_t dataToSignLen, uint8_t *sig, size_t *sigLen );
OSStatus replaced_SecKeyRawSign ( SecKeyRef key, SecPadding padding, const uint8_t *dataToSign, size_t dataToSignLen, uint8_t *sig, size_t *sigLen ) {
    
    OSStatus ret = orig_SecKeyRawSign(key, padding, dataToSign, dataToSignLen, sig, sigLen);

    NSLog(@"SecKeyRawSign   Key: %@", key);
    NSLog(@"                Padding: %u", padding);
    NSLog(@"                dataToSign: %s", dataToSign);
    NSLog(@"                dataToSignLen: %lu", dataToSignLen);
    NSLog(@"                sig: %s", sig);

    return ret;
}

OSStatus (*orig_SecKeyRawVerify) ( SecKeyRef key, SecPadding padding, const uint8_t *signedData, size_t signedDataLen, const uint8_t *sig, size_t sigLen );
OSStatus replaced_SecKeyRawVerify ( SecKeyRef key, SecPadding padding, const uint8_t *signedData, size_t signedDataLen, const uint8_t *sig, size_t sigLen ) {
    
    OSStatus ret = orig_SecKeyRawVerify(key, padding, signedData, signedDataLen, sig, sigLen);

    NSLog(@"SecKeyRawVerify   Key: %@", key);
    NSLog(@"                Padding: %u", padding);
    NSLog(@"                signedData: %s", signedData);
    NSLog(@"                signedDataLen: %lu", signedDataLen);
    NSLog(@"                sig: %s", sig);

    return ret;
}


/*
Managing Trust

SecTrustCopyCustomAnchorCertificates
SecTrustCopyExceptions
SecTrustCopyProperties
SecTrustCopyPolicies
SecTrustCopyPublicKey
SecTrustCreateWithCertificates
SecTrustEvaluate
SecTrustEvaluateAsync
SecTrustGetCertificateCount
SecTrustGetCertificateAtIndex
SecTrustGetTrustResult
SecTrustGetVerifyTime
SecTrustSetAnchorCertificates
SecTrustSetAnchorCertificatesOnly
SecTrustSetExceptions
SecTrustSetPolicies
SecTrustSetVerifyDate
*/
OSStatus (*orig_SecTrustEvaluate)(SecTrustRef trust, SecTrustResultType *result);
OSStatus replaced_SecTrustEvaluate(SecTrustRef trust, SecTrustResultType *result) {
    
    OSStatus ret = orig_SecTrustEvaluate(trust, result);
    // Actually, this certificate chain is trusted
    *result = kSecTrustResultUnspecified;

    NSLog(@"SecTrustEvaluate SSL Pinning Bypass");

    return ret;
}




#define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookSecurity_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic(funcname) MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname)
// #define InstallHook_FindSymbol(funcname) if ([[plist objectForKey:@"settings_HookCFunctions2_"#funcname] boolValue]) { MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname); }

void Security_hooks()
{
	NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

    InstallHook(SecKeyEncrypt);
    InstallHook(SecKeyDecrypt);
    InstallHook(SecKeyRawSign);
    InstallHook(SecKeyRawVerify);

	if (disableSSLPinning())
    {
    	InstallHook_basic(SecTrustEvaluate);
    }
}

