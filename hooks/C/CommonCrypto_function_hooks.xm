/*
 File Description:
  
  ******************
  ** CommonCrypto **
  ******************

 The libSystem Common Crypto library implements a wide range of cryptographic
 algorithms used in various Internet standards. The services provided
 by this library are used by the CDSA implementations of SSL, TLS and S/MIME.

*/
#import "../../swizzler.common.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>


#define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookCCommonCrypto_hookall"] boolValue] || [[plist objectForKey:@"settings_HookCCommonCrypto_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }

/*
 CCCrypt - Common Cryptographic Algorithm Interfaces

 CCCryptorRef objects created with CCCryptorCreate() or
 CCCryptorCreateFromData() *may* be disposed of via CCCRyptorRelease() ;
 that call is not strictly necessary, but if it's not performed, good
 security practice dictates that the caller should zero the memory provided
 to create the CCCryptorRef when the caller is finished using the
 CCCryptorRef.

 CCCryptorUpdate() is used to encrypt or decrypt data.  This routine can
 be called multiple times. The caller does not need to align input data
 lengths to block sizes; input is bufferred as necessary for block
 ciphers.

 When performing symmetric encryption with block ciphers, and padding is
 enabled via kCCOptionPKCS7Padding, the total number of bytes provided by
 all the calls to this function when encrypting can be arbitrary (i.e.,
 the total number of bytes does not have to be block aligned). However if
 padding is disabled, or when decrypting, the total number of bytes does
 have to be aligned to the block size; otherwise CCCryptFinal() will
 return kCCAlignmentError.

 A general rule for the size of the output buffer which must be provided
 by the caller is that for block ciphers, the output length is never
 larger than the input length plus the block size.  For stream ciphers,
 the output length is always exactly the same as the input length. See the
 discussion for CCCryptorGetOutputLength() for more information on this
 topic.

 CCCryptFinal() finishes encryption and decryption operations and obtains
 the final data output.  Except when kCCBufferTooSmall is returned, the
 CCCryptorRef can no longer be used for subsequent operations unless
 CCCryptorReset() is called on it.

 It is not necessary to call CCCryptorFinal() when performing symmetric
 encryption or decryption if padding is disabled, or when using a stream
 cipher.

 It is not necessary to call CCCryptorFinal() prior to CCCryptorRelease()
 when aborting an operation.

 Use CCCryptorGetOutputLength() to determine output buffer size required
 to process a given input size.  Some general rules apply that allow
 clients of this module to know a priori how much output buffer space will
 be required in a given situation. For stream ciphers, the output size is
 always equal to the input size, and CCCryptorFinal() never produces any
 data. For block ciphers, the output size will always be less than or
 equal to the input size plus the size of one block. For block ciphers, if
 the input size provided to each call to CCCryptorUpdate() is is an integral
 multiple of the block size, then the output size for each call to
 CCCryptorUpdate() is less than or equal to the input size for that call
 to CCCryptorUpdate().  CCCryptorFinal() only produces output when using a
 block cipher with padding enabled.

 CCCryptorReset() reinitializes an existing CCCryptorRef with a (possibly)
 new initialization vector. The key contained in the CCCryptorRef is
 unchanged. This function is not implemented for stream ciphers.  This can
 be called on a CCCryptorRef with data pending (i.e.  in a padded mode
 operation before CCCryptFinal() is called); however any pending data will
 be lost in that case.

 CCCrypt() is a stateless, one-shot encrypt or decrypt operation.  This
 basically performs a sequence of CCCrytorCreate(), CCCryptorUpdate(),
 CCCryptorFinal(), and CCCryptorRelease().
*/

/*
 CCCryptorStatus CCCryptorCreate(CCOperation op, CCAlgorithm alg, CCOptions options, 
                                const void *key, size_t keyLength, const void *iv, 
                                CCCryptorRef *cryptorRef);

    enum {
        kCCAlgorithmAES128 = 0,
        kCCAlgorithmAES = 0,
        kCCAlgorithmDES,
        kCCAlgorithm3DES,       
        kCCAlgorithmCAST,       
        kCCAlgorithmRC4,
        kCCAlgorithmRC2,   
        kCCAlgorithmBlowfish    
    };                              
*/

static size_t getIVLength(CCAlgorithm alg) {

    switch(alg) {
        case kCCAlgorithmAES128:
            return kCCBlockSizeAES128;
        case kCCAlgorithmDES:
            return kCCBlockSizeDES;
        case kCCAlgorithm3DES:
            return kCCBlockSize3DES;
        case kCCAlgorithmCAST:
            return kCCBlockSizeCAST;
        case kCCAlgorithmRC2:
            return kCCBlockSizeRC2;
        default:
            return 0;
    }
}

const char *getAlgorithmName(CCAlgorithm alg)
{
    switch(alg)
    {
        case kCCAlgorithmAES128:
            return "kCCAlgorithmAES128";
            break;
        // This one returns 0 as well
        // case kCCAlgorithmAES:
        //     return "kCCAlgorithmAES";
        //     break;
        case kCCAlgorithmDES:
            return "kCCAlgorithmDES";
            break;
        case kCCAlgorithm3DES:
            return "kCCAlgorithm3DES";
            break;
        case kCCAlgorithmCAST:
            return "kCCAlgorithmCAST";
            break;
        case kCCAlgorithmRC2:
            return "kCCAlgorithmRC2";
            break;
        case kCCAlgorithmBlowfish:
            return "kCCAlgorithmBlowfish";
            break;
        default:
            return 0;
    }
}

const char *getHMACAlgorithmName(CCHmacAlgorithm alg)
{
    switch(alg)
    {
        case kCCHmacAlgSHA1:
            return "kCCHmacAlgSHA1";
            break;
        case kCCHmacAlgMD5:
            return "kCCHmacAlgMD5";
            break;
        case kCCHmacAlgSHA256:
            return "kCCHmacAlgSHA256";
            break;
        case kCCHmacAlgSHA384:
            return "kCCHmacAlgSHA384";
            break;
        case kCCHmacAlgSHA512:
            return "kCCHmacAlgSHA512";
            break;
        case kCCHmacAlgSHA224:
            return "kCCHmacAlgSHA224";
            break;
        default:
            return 0;
    }
}



CCCryptorStatus (*orig_CCCryptorCreate) (CCOperation op, CCAlgorithm alg, CCOptions options, 
                                const void *key, size_t keyLength, const void *iv, CCCryptorRef *cryptorRef);

CCCryptorStatus replaced_CCCryptorCreate (CCOperation op, CCAlgorithm alg, CCOptions options, 
                                const void *key, size_t keyLength, const void *iv, CCCryptorRef *cryptorRef)
{

    // DDLogVerbose(@"CCCryptorCreate alg: %s", getAlgorithmName(alg));
    // DDLogVerbose(@"CCCryptorCreate key: %@", NSData2Hex([NSData dataWithBytes:key length:keyLength]));
    // DDLogVerbose(@"CCCryptorCreate keyLength: %lu bits", keyLength*8);
    // DDLogVerbose(@"CCCryptorCreate iv: %@", NSData2Hex([NSData dataWithBytes:iv length:getIVLength(alg)]));
    // DDLogVerbose(@"CCCryptorCreate ivLength: %lu bits", getIVLength(alg)*8);
    
    // NSLog(@"[NSData dataWithBytes:%p length:%zu];", iv, getIVLength(alg));
    // Thanks to @saurik for figuring out my noob mistake of not checking if the IV is null.
    if (iv != NULL)
    {
        DDLogVerbose(@"CCCryptorCreate alg: %s, key: %@, keyLength: %lu bits, iv: %@, ivLength: %lu bits", getAlgorithmName(alg), NSData2Hex([NSData dataWithBytes:key length:keyLength]), keyLength*8, NSData2Hex([NSData dataWithBytes:iv length:getIVLength(alg)]), getIVLength(alg)*8);
    } else {
        DDLogVerbose(@"CCCryptorCreate alg: %s, key: %@, keyLength: %lu bits, iv: NULL, ivLength: %lu bits", getAlgorithmName(alg), NSData2Hex([NSData dataWithBytes:key length:keyLength]), keyLength*8, getIVLength(alg)*8);
    }
    CCCryptorStatus ret = orig_CCCryptorCreate(op, alg, options, key, keyLength, iv, cryptorRef);
    
    // NSString *ns_key = [[NSString alloc] initWithBytes:iv length:getIVLength(alg) encoding:NSASCIIStringEncoding];
    // NSLog(@"%@", ns_key);

    return ret;
}

/*
 CCCryptorStatus CCCryptorCreateFromData(CCOperation op, CCAlgorithm alg, CCOptions options, 
                                        const void *key, size_t keyLength, const void *iv, 
                                        const void *data, size_t dataLength, CCCryptorRef *cryptorRef, 
                                        size_t *dataUsed);
*/
CCCryptorStatus (*orig_CCCryptorCreateFromData) (CCOperation op, CCAlgorithm alg, CCOptions options, 
                                        const void *key, size_t keyLength, const void *iv, 
                                        const void *data, size_t dataLength, CCCryptorRef *cryptorRef, 
                                        size_t *dataUsed);

CCCryptorStatus replaced_CCCryptorCreateFromData (CCOperation op, CCAlgorithm alg, CCOptions options, 
                                        const void *key, size_t keyLength, const void *iv, 
                                        const void *data, size_t dataLength, CCCryptorRef *cryptorRef, 
                                        size_t *dataUsed)
{
    DDLogVerbose(@"CCCryptorCreateFromData");

    const char *cdata = (const char *)data;
    NSMutableString *in1 = [NSMutableString string];
    for (int i=0; i<dataLength; i++)
        [in1 appendFormat:@"%02x", (unsigned)cdata[i]];

    DDLogVerbose(@"data: %@", in1);

    CCCryptorStatus ret = orig_CCCryptorCreateFromData(op, alg, options, key, keyLength, iv, data, dataLength, cryptorRef, dataUsed);
    return ret;
}

/*
 CCCryptorStatus CCCryptorRelease(CCCryptorRef cryptorRef);
*/
// CCCryptorStatus (*orig_CCCryptorRelease) (CCCryptorRef cryptorRef);

// CCCryptorStatus replaced_CCCryptorRelease (CCCryptorRef cryptorRef)
// {
//     DDLogVerbose(@"CCCryptorRelease");
//     CCCryptorStatus ret = orig_CCCryptorRelease(cryptorRef);
//     return ret;
// }

/*
 CCCryptorStatus CCCryptorUpdate(CCCryptorRef cryptorRef, const void *dataIn, size_t dataInLength, 
                                void *dataOut, size_t dataOutAvailable, size_t *dataOutMoved);
*/
CCCryptorStatus (*orig_CCCryptorUpdate) (CCCryptorRef cryptorRef, const void *dataIn, size_t dataInLength, 
                                void *dataOut, size_t dataOutAvailable, size_t *dataOutMoved);

CCCryptorStatus replaced_CCCryptorUpdate (CCCryptorRef cryptorRef, const void *dataIn, size_t dataInLength, 
                                void *dataOut, size_t dataOutAvailable, size_t *dataOutMoved)
{
    const char *cdata = (const char *)dataIn;
    NSMutableString *in1 = [NSMutableString string];
    for (int i=0; i<dataInLength; i++)
        [in1 appendFormat:@"%02x", (unsigned)cdata[i]];

    DDLogVerbose(@"CCCryptorUpdate dataIn: %@", in1);

    CCCryptorStatus ret = orig_CCCryptorUpdate(cryptorRef, dataIn, dataInLength, dataOut, dataOutAvailable, dataOutMoved);
    return ret;
}

/*
 CCCryptorStatus CCCryptorFinal(CCCryptorRef cryptorRef, void *dataOut, size_t dataOutAvailable, size_t *dataOutMoved);
*/
// CCCryptorStatus (*orig_CCCryptorFinal) (CCCryptorRef cryptorRef, void *dataOut, size_t dataOutAvailable, size_t *dataOutMoved);

// CCCryptorStatus replaced_CCCryptorFinal (CCCryptorRef cryptorRef, void *dataOut, size_t dataOutAvailable, size_t *dataOutMoved)
// {
//     DDLogVerbose(@"CCCryptorFinal");
//     CCCryptorStatus ret = orig_CCCryptorFinal(cryptorRef, dataOut, dataOutAvailable, dataOutMoved);
//     return ret;
// }


// @@@@@@@@@@ Compile error, why? @@@@@@@@@@@@
/*
 size_t CCCryptorGetOutputLength(CCCryptorRef cryptorRef, size_t inputLength, bool final);
*/
// size_t (orig_CCCryptorGetOutputLength) (CCCryptorRef cryptorRef, size_t inputLength, bool final);

// size_t replaced_CCCryptorGetOutputLength (CCCryptorRef cryptorRef, size_t inputLength, bool final)
// {
//     size_t ret = orig_CCCryptorGetOutputLength(cryptorRef, inputLength, final);
//     return ret;
// }

/*
 CCCryptorStatus CCCryptorReset(CCCryptorRef cryptorRef, const void *iv);
*/
// CCCryptorStatus (*orig_CCCryptorReset) (CCCryptorRef cryptorRef, const void *iv);

// CCCryptorStatus replaced_CCCryptorReset (CCCryptorRef cryptorRef, const void *iv)
// {
//     DDLogVerbose(@"CCCryptorReset");
//     CCCryptorStatus ret = orig_CCCryptorReset(cryptorRef, iv);
//     return ret;
// }

/*
 CCCryptorStatus CCCrypt(CCOperation op, CCAlgorithm alg, CCOptions options, const void *key, 
                        size_t keyLength, const void *iv, const void *dataIn, size_t dataInLength, 
                        void *dataOut, size_t dataOutAvailable, size_t *dataOutMoved);
*/
CCCryptorStatus (*orig_CCCrypt) (CCOperation op, CCAlgorithm alg, CCOptions options, const void *key, 
                        size_t keyLength, const void *iv, const void *dataIn, size_t dataInLength, 
                        void *dataOut, size_t dataOutAvailable, size_t *dataOutMoved);

CCCryptorStatus replaced_CCCrypt (CCOperation op, CCAlgorithm alg, CCOptions options, const void *key, 
                        size_t keyLength, const void *iv, const char *dataIn, size_t dataInLength, 
                        void *dataOut, size_t dataOutAvailable, size_t *dataOutMoved)
{

    const char *cdata = (const char *)dataIn;
    NSMutableString *in1 = [NSMutableString string];
    for (int i=0; i<dataInLength; i++)
        [in1 appendFormat:@"%02x", (unsigned)cdata[i]];

    if (iv != NULL)
    {
        DDLogVerbose(@"CCCrypt alg: %s, key: %@, keyLength: %lu bits, iv: %@, ivLength: %lu bits", getAlgorithmName(alg), NSData2Hex([NSData dataWithBytes:key length:keyLength]), keyLength*8, NSData2Hex([NSData dataWithBytes:iv length:getIVLength(alg)]), getIVLength(alg)*8);
    } else {
        DDLogVerbose(@"CCCrypt alg: %s, key: %@, keyLength: %lu bits, iv: NULL, ivLength: %lu bits", getAlgorithmName(alg), NSData2Hex([NSData dataWithBytes:key length:keyLength]), keyLength*8, getIVLength(alg)*8);
    }
    DDLogVerbose(@"dataIn: %@", in1);
    CCCryptorStatus ret = orig_CCCrypt(op, alg, options, key, keyLength, iv, dataIn, dataInLength, dataOut, dataOutAvailable, dataOutMoved);
    return ret;
}










/*
 Common HMAC Algorithm Interfaces
 This interface provides access to a number of HMAC algorithms. The following algorithms are available:

     kCCHmacAlgSHA1    - HMAC with SHA1 digest

     kCCHmacAlgMD5     - HMAC with MD5 digest

     kCCHmacAlgSHA256  - HMAC with SHA256 digest

     kCCHmacAlgSHA384  - HMAC with SHA384 digest

     kCCHmacAlgSHA224  - HMAC with SHA224 digest

     kCCHmacAlgSHA512  - HMAC with SHA512 digest

 The object declared in this interface, CCHmacContext, provides a handle
 for use with the CCHmacInit() CCHmacUpdate() and CCHmacFinal() calls to
 complete the HMAC operation.  In addition there is a one shot function,
 CCHmac() that performs a complete HMAC on a single piece of data.

 void CCHmacInit(CCHmacContext *ctx, CCHmacAlgorithm algorithm, const void *key, size_t keyLength);
 void CCHmacUpdate(CCHmacContext *ctx, const void *data, size_t dataLength);
 void CCHmacFinal(CCHmacContext *ctx, void *macOut);
 void CCHmac(CCHmacAlgorithm algorithm, const void *key, size_t keyLength, const void *data, size_t dataLength, void *macOut);
*/
void (*orig_CCHmacInit) (CCHmacContext *ctx, CCHmacAlgorithm algorithm, const void *key, size_t keyLength);
void (*orig_CCHmacUpdate) (CCHmacContext *ctx, const void *data, size_t dataLength);
void (*orig_CCHmacFinal) (CCHmacContext *ctx, void *macOut);
void (*orig_CCHmac) (CCHmacAlgorithm algorithm, const void *key, size_t keyLength, const void *data, size_t dataLength, void *macOut);

void replaced_CCHmacInit (CCHmacContext *ctx, CCHmacAlgorithm algorithm, const void *key, size_t keyLength)
{
    DDLogVerbose(@"CCHmacInit alg: %s, key: %@, keyLength: %lu bits", getHMACAlgorithmName(algorithm), NSData2Hex([NSData dataWithBytes:key length:keyLength]), keyLength*8);
    orig_CCHmacInit(ctx, algorithm, key, keyLength);
}
void replaced_CCHmacUpdate (CCHmacContext *ctx, const void *data, size_t dataLength)
{
    DDLogVerbose(@"CCHmacUpdate");
    orig_CCHmacUpdate(ctx, data, dataLength);
}
void replaced_CCHmacFinal (CCHmacContext *ctx, void *macOut)
{
    DDLogVerbose(@"CCHmacFinal");
    orig_CCHmacFinal(ctx, macOut);
}
void replaced_CCHmac (CCHmacAlgorithm algorithm, const void *key, size_t keyLength, const void *data, size_t dataLength, void *macOut)
{
    NSString *nsstring_data = NSData2Hex([NSData dataWithBytes:data length:dataLength]);
    DDLogVerbose(@"CCHmac data: %@", nsstring_data);
    DDLogVerbose(@"CCHmac alg: %s, key: %@, keyLength: %lu bits", getHMACAlgorithmName(algorithm), NSData2Hex([NSData dataWithBytes:key length:keyLength]), keyLength*8);
    orig_CCHmac(algorithm, key, keyLength, data, dataLength, macOut);
}







// extern int CC_SHA1_Init(CC_SHA1_CTX *c);

// extern int CC_SHA1_Update(CC_SHA1_CTX *c, const void *data, CC_LONG len);

// extern int CC_SHA1_Final(unsigned char *md, CC_SHA1_CTX *c);

unsigned char (*orig_CC_SHA1) (const void *data, CC_LONG len, unsigned char *md);
unsigned char replaced_CC_SHA1 (const void *data, CC_LONG len, unsigned char *md)
{
    DDLogVerbose(@"CC_SHA1");
    NSString *nsstring_data = NSData2Hex([NSData dataWithBytes:data length:len]);
    DDLogVerbose(@"CC_SHA1 data: %@", nsstring_data);
    return orig_CC_SHA1(data, len, md);
}

// extern int CC_SHA224_Init(CC_SHA224_CTX *c);

// extern int CC_SHA224_Update(CC_SHA224_CTX *c, const void *data, CC_LONG len);

// extern int CC_SHA224_Final(unsigned char *md, CC_SHA224_CTX *c);

// extern unsigned char *CC_SHA224(const void *data, CC_LONG len, unsigned char *md);

// extern int CC_SHA256_Init(CC_SHA256_CTX *c);

// extern int CC_SHA256_Update(CC_SHA256_CTX *c, const void *data, CC_LONG len);

// extern int CC_SHA256_Final(unsigned char *md, CC_SHA256_CTX *c);

unsigned char (*orig_CC_SHA256) (const void *data, CC_LONG len, unsigned char *md);
unsigned char replaced_CC_SHA256 (const void *data, CC_LONG len, unsigned char *md)
{
    DDLogVerbose(@"CC_SHA256");
    NSString *nsstring_data = NSData2Hex([NSData dataWithBytes:data length:len]);
    DDLogVerbose(@"CC_SHA256 data: %@", nsstring_data);
    return orig_CC_SHA256(data, len, md);
}

// extern int CC_SHA384_Init(CC_SHA384_CTX *c);

// extern int CC_SHA384_Update(CC_SHA384_CTX *c, const void *data, CC_LONG len);

// extern int CC_SHA384_Final(unsigned char *md, CC_SHA384_CTX *c);

// extern unsigned char *CC_SHA384(const void *data, CC_LONG len, unsigned char *md);

// extern int CC_SHA512_Init(CC_SHA512_CTX *c);

// extern int CC_SHA512_Update(CC_SHA512_CTX *c, const void *data, CC_LONG len);

// extern int CC_SHA512_Final(unsigned char *md, CC_SHA512_CTX *c);

unsigned char (*orig_CC_SHA512) (const void *data, CC_LONG len, unsigned char *md);
unsigned char replaced_CC_SHA512 (const void *data, CC_LONG len, unsigned char *md)
{
    DDLogVerbose(@"CC_SHA512");
    NSString *nsstring_data = NSData2Hex([NSData dataWithBytes:data length:len]);
    DDLogVerbose(@"CC_SHA512 data: %@", nsstring_data);
    return orig_CC_SHA512(data, len, md);
}















// extern bool MSDebug;
void CommonCrypto_function_hooks()
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

    // Common Cryptographic Algorithm Interfaces
    // MSDebug = true;
    InstallHook(CCCryptorCreate);
    // MSDebug = false;
    InstallHook(CCCryptorCreateFromData);
    // InstallHook(CCCryptorRelease);
    InstallHook(CCCryptorUpdate);
    // InstallHook(CCCryptorFinal);
    // CCCryptorGetOutputLength
    // InstallHook(CCCryptorReset);
    InstallHook(CCCrypt);


    // Common HMAC Algorithm Interfaces
    InstallHook(CCHmacInit);
    InstallHook(CCHmacUpdate);
    InstallHook(CCHmacFinal);
    InstallHook(CCHmac);


    // Common Crypto SHA
    InstallHook(CC_SHA1);
    InstallHook(CC_SHA256);
    InstallHook(CC_SHA512);
}

















