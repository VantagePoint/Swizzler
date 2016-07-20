/*
 File Description:
  
    *******************************
    ** OpenSSL Crypto Functions  **
    *******************************

    https://www.openssl.org/docs/ssl/ssl.html

    Last referenced: 24 June 2015
*/


#import "../../swizzler.common.h"
#import "OpenSSL.h"
// EVP_EncryptInit
// https://www.openssl.org/docs/crypto/EVP_EncryptInit.html

// void EVP_CIPHER_CTX_init(EVP_CIPHER_CTX *a);

// int EVP_EncryptInit_ex(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, ENGINE *impl, unsigned char *key, unsigned char *iv);
int (*orig_EVP_EncryptUpdate) (EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl, unsigned char *in, int inl);
int replaced_EVP_EncryptUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl, unsigned char *in, int inl)
{
    int ret = orig_EVP_EncryptUpdate(ctx, out, outl, in, inl);

    int outlength = *outl;

    NSMutableString *in1 = [NSMutableString string];
    for (int i=0; i<inl; i++)
        [in1 appendFormat:@"%02x", in[i]];

    NSMutableString *out1 = [NSMutableString string];
    for (int i=0; i<outlength; i++)
        [out1 appendFormat:@"%02x", out[i]];

    DDLogVerbose(@"EVP_EncryptUpdate out:%@, outl:%d, in:%@, inl:%d", out1, outlength, in1, inl);

    return ret;
}
// int EVP_EncryptFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl);

// int EVP_DecryptInit_ex(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, ENGINE *impl, unsigned char *key, unsigned char *iv);
int (*orig_EVP_DecryptUpdate) (EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl, unsigned char *in, int inl);
int replaced_EVP_DecryptUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl, unsigned char *in, int inl)
{
    int ret = orig_EVP_DecryptUpdate(ctx, out, outl, in, inl);

    int outlength = *outl;

    NSMutableString *in1 = [NSMutableString string];
    for (int i=0; i<inl; i++)
        [in1 appendFormat:@"%02x", in[i]];

    NSMutableString *out1 = [NSMutableString string];
    for (int i=0; i<outlength; i++)
        [out1 appendFormat:@"%02x", out[i]];

    DDLogVerbose(@"EVP_DecryptUpdate out: %@, outl: %d, in:%@, inl:%d", out1, outlength, in1, inl);

    return ret;
}
// int EVP_DecryptFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *outm, int *outl);

// int EVP_CipherInit_ex(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, ENGINE *impl, unsigned char *key, unsigned char *iv, int enc);
// int EVP_CipherUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl, unsigned char *in, int inl);
// int EVP_CipherFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *outm, int *outl);

int (*orig_EVP_EncryptInit) (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, unsigned char *key, unsigned char *iv);
int (*orig_EVP_EncryptFinal) (EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl);

int replaced_EVP_EncryptInit(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, unsigned char *key, unsigned char *iv)
{
    // type->nid
    // type->key_len
    // type->iv_len
    // type->block_size
    // char cipher[] = "";
    int nid = type->nid;
    // int block_size = type->block_size;
    int key_len = type->key_len;
    int iv_len = type->iv_len;

    NSMutableString *key1 = [NSMutableString string];
    for (int i=0; i<key_len; i++)
        [key1 appendFormat:@"%02x", key[i]];

    NSMutableString *iv1 = [NSMutableString string];
    for (int i=0; i<iv_len; i++)
        [iv1 appendFormat:@"%02x", iv[i]];

    NSString *cipher = [NSString string];

    switch (nid)
    {
        case 418:
            cipher = @"AES-128-ECB";
            break;
        case 419:
            cipher = @"AES-128-CBC";
            break;
        case 420:
            cipher = @"AES-128-OFB";
            break;
        case 421:
            cipher = @"AES-128-CFB";
            break;
        case 422:
            cipher = @"AES-192-ECB";
            break;
        case 423:
            cipher = @"AES-192-CBC";
            break;
        case 424:
            cipher = @"AES-192-OFB";
            break;
        case 425:
            cipher = @"AES-192-CFB";
            break;
        case 426:
            cipher = @"AES-256-ECB";
            break;
        case 427:
            cipher = @"AES-256-CBC";
            break;
        case 428:
            cipher = @"AES-256-OFB";
            break;
        case 429:
            cipher = @"AES-256-CFB";
            break;
        default:
            cipher = @"UNKNOWN";
            break;
    }

	DDLogVerbose(@"_EVP_EncryptInit %@ key: %@, iv: %@", cipher, key1, iv1);
	return orig_EVP_EncryptInit(ctx, type, key, iv);
}

int replaced_EVP_EncryptFinal(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl)
{
    int ret = orig_EVP_EncryptFinal(ctx, out, outl);

    int outlength = *outl;

    NSMutableString *out1 = [NSMutableString string];
    for (int i=0; i<outlength; i++)
        [out1 appendFormat:@"%02x", out[i]];    

    DDLogVerbose(@"_EVP_EncryptFinal out: %@, outlength: %d", out1, outlength);

    return ret;
}







int (*orig_EVP_DecryptInit) (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, unsigned char *key, unsigned char *iv);
int (*orig_EVP_DecryptFinal) (EVP_CIPHER_CTX *ctx, unsigned char *outm, int *outl);
int replaced_EVP_DecryptInit(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, unsigned char *key, unsigned char *iv)
{
    // type->nid
    // type->key_len
    // type->iv_len
    // type->block_size
    // char cipher[] = "";
    int nid = type->nid;
    // int block_size = type->block_size;
    int key_len = type->key_len;
    int iv_len = type->iv_len;

    NSMutableString *key1 = [NSMutableString string];
    for (int i=0; i<key_len; i++)
        [key1 appendFormat:@"%02x", key[i]];

    NSMutableString *iv1 = [NSMutableString string];
    for (int i=0; i<iv_len; i++)
        [iv1 appendFormat:@"%02x", iv[i]];

    NSString *cipher = [NSString string];


    switch (nid)
    {
        case 418:
            cipher = @"AES-128-ECB";
            // strcpy(cipher, "AES-128-ECB");
            break;
        case 419:
            cipher = @"AES-128-CBC";
            // strcpy(cipher, "AES-128-CBC");
            break;
        case 420:
            cipher = @"AES-128-OFB";
            // strcpy(cipher, "AES-128-OFB");
            break;
        case 421:
            cipher = @"AES-128-CFB";
            // strcpy(cipher, "AES-128-CFB");
            break;
        case 422:
            cipher = @"AES-192-ECB";
            // strcpy(cipher, "AES-192-ECB");
            break;
        case 423:
            cipher = @"AES-192-CBC";
            // strcpy(cipher, "AES-192-CBC");
            break;
        case 424:
            cipher = @"AES-192-OFB";
            // strcpy(cipher, "AES-192-OFB");
            break;
        case 425:
            cipher = @"AES-192-CFB";
            // strcpy(cipher, "AES-192-CFB");
            break;
        case 426:
            cipher = @"AES-256-ECB";
            // strcpy(cipher, "AES-256-ECB");
            break;
        case 427:
            cipher = @"AES-256-CBC";
            // strcpy(cipher, "AES-256-CBC");
            break;
        case 428:
            cipher = @"AES-256-OFB";
            // strcpy(cipher, "AES-256-OFB");
            break;
        case 429:
            cipher = @"AES-256-CFB";
            // strcpy(cipher, "AES-256-CFB");
            break;
        default:
            cipher = @"UNKNOWN";
            // strcpy(cipher, "UNKNOWN");
            break;
    }

    DDLogVerbose(@"_EVP_DecryptInit %@ key: %@, iv: %@", cipher, key1, iv1);
    return orig_EVP_DecryptInit(ctx, type, key, iv);
}

int replaced_EVP_DecryptFinal(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl)
{
    int ret = orig_EVP_DecryptFinal(ctx, out, outl);

    int outlength = *outl;

    NSMutableString *out1 = [NSMutableString string];
    for (int i=0; i<outlength; i++)
        [out1 appendFormat:@"%02x", out[i]];    

    DDLogVerbose(@"_EVP_DecryptFinal out: %@, outlength: %d", out1, outlength);

    return ret;
}



int (*orig_EVP_CipherInit) (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, unsigned char *key, unsigned char *iv, int enc);
int (*orig_EVP_CipherFinal) (EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl);

int replaced_EVP_CipherInit(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, unsigned char *key, unsigned char *iv, int enc)
{
    // type->nid
    // type->key_len
    // type->iv_len
    // type->block_size
    // char cipher[] = "";
    int nid = type->nid;
    // int block_size = type->block_size;
    int key_len = type->key_len;
    int iv_len = type->iv_len;

    NSMutableString *key1 = [NSMutableString string];
    for (int i=0; i<key_len; i++)
        [key1 appendFormat:@"%02x", key[i]];

    NSMutableString *iv1 = [NSMutableString string];
    for (int i=0; i<iv_len; i++)
        [iv1 appendFormat:@"%02x", iv[i]];

    NSString *cipher = [NSString string];

    switch (nid)
    {
        case 418:
            cipher = @"AES-128-ECB";
            break;
        case 419:
            cipher = @"AES-128-CBC";
            break;
        case 420:
            cipher = @"AES-128-OFB";
            break;
        case 421:
            cipher = @"AES-128-CFB";
            break;
        case 422:
            cipher = @"AES-192-ECB";
            break;
        case 423:
            cipher = @"AES-192-CBC";
            break;
        case 424:
            cipher = @"AES-192-OFB";
            break;
        case 425:
            cipher = @"AES-192-CFB";
            break;
        case 426:
            cipher = @"AES-256-ECB";
            break;
        case 427:
            cipher = @"AES-256-CBC";
            break;
        case 428:
            cipher = @"AES-256-OFB";
            break;
        case 429:
            cipher = @"AES-256-CFB";
            break;
        default:
            cipher = @"UNKNOWN";
            break;
    }

    DDLogVerbose(@"_EVP_CipherInit %@ key: %@, iv: %@, enc: %d", cipher, key1, iv1, enc);
    return orig_EVP_CipherInit(ctx, type, key, iv, enc);
}
int replaced_EVP_CipherFinal(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl)
{
    int ret = orig_EVP_CipherFinal(ctx, out, outl);

    int outlength = *outl;

    NSMutableString *out1 = [NSMutableString string];
    for (int i=0; i<outlength; i++)
        [out1 appendFormat:@"%02x", out[i]];    

    DDLogVerbose(@"_EVP_CipherFinal out: %@, outlength: %d", out1, outlength);

    return ret;
}

// int EVP_CIPHER_CTX_set_padding(EVP_CIPHER_CTX *x, int padding);
// int EVP_CIPHER_CTX_set_key_length(EVP_CIPHER_CTX *x, int keylen);
// int EVP_CIPHER_CTX_ctrl(EVP_CIPHER_CTX *ctx, int type, int arg, void *ptr);
// int EVP_CIPHER_CTX_cleanup(EVP_CIPHER_CTX *a);






int (*orig_PKCS5_PBKDF2_HMAC) (const char *pass, int passlen,
                       const unsigned char *salt, int saltlen, int iter,
                       const EVP_MD *digest,
                       int keylen, unsigned char *out);

int replaced_PKCS5_PBKDF2_HMAC(const char *pass, int passlen,
                       const unsigned char *salt, int saltlen, int iter,
                       const EVP_MD *digest,
                       int keylen, unsigned char *out)
{
    int ret = orig_PKCS5_PBKDF2_HMAC(pass, passlen, salt, saltlen, iter, digest, keylen, out);

	NSMutableString *salt_hex = [NSMutableString string];
	for (int i=0; i<saltlen; i++)
        [salt_hex appendFormat:@"%02x", salt[i]];

    NSMutableString *result_hex = [NSMutableString string];
    for (int i=0; i<keylen; i++)
        [result_hex appendFormat:@"%02x", out[i]];

	DDLogVerbose(@"PKCS5_PBKDF2_HMAC pass: %s, passlen: %d, salt: %@, saltlen: %d, iter: %d, keylen: %d", pass, passlen, salt_hex, saltlen, iter, keylen);
	DDLogVerbose(@"PKCS5_PBKDF2_HMAC result: %@", result_hex);

    return ret;
}












/*
    HMAC Stuff

    HMAC is a MAC (message authentication code), i.e. a keyed hash function used for message authentication, 
    which is based on a hash function.

    HMAC() computes the message authentication code of the n bytes at d using the hash function evp_md 
    and the key key which is key_len bytes long.

    It places the result in md (which must have space for the output of the hash function, 
    which is no more than EVP_MAX_MD_SIZE bytes). If md is NULL, the digest is placed in a static array. 
    The size of the output is placed in md_len, unless it is NULL.

    evp_md can be EVP_sha1(), EVP_ripemd160() etc.
*/
unsigned char (*orig_HMAC) (const EVP_MD *evp_md, const void *key, int key_len, const unsigned char *d, int n, unsigned char *md, unsigned int *md_len);
unsigned char replaced_HMAC (const EVP_MD *evp_md, const void *key, int key_len, const unsigned char *d, int n, unsigned char *md, unsigned int *md_len)
{
    NSLog(@"OpenSSL HMAC key: %@", NSData2Hex([NSData dataWithBytes:key length:key_len]));

    unsigned char ret = orig_HMAC(evp_md, key, key_len, d, n, md, md_len);

    // NSString *hmac_key = [[NSString alloc] initWithBytes:key length:key_len encoding:NSASCIIStringEncoding];

    // NSData *NSData_key = [NSData dataWithBytes:key length:key_len];
    
    // NSMutableString *key_hex = [NSMutableString stringWithCapacity:key_len*2];
    
    // const unsigned char *dataBytes = (const unsigned char *)[NSData_key bytes];
    // for (NSInteger idx = 0; idx < key_len; ++idx)
    // {
    //     [key_hex appendFormat:@"%02x", dataBytes[idx]];
    // }

    NSMutableString *data_hex = [NSMutableString string];
    for (int i=0; i<n; i++)
        [data_hex appendFormat:@"%02x", d[i]];

    NSMutableString *result_hex = [NSMutableString string];
    for(int i = 0; i < evp_md->md_size; i++)
        [result_hex appendFormat:@"%02x", md[i]];


    DDLogVerbose(@"OpenSSL HMAC dataIn: %@, result: %@", data_hex, result_hex);

    return ret;
}

// void HMAC_CTX_init(HMAC_CTX *ctx);

// int HMAC_Init(HMAC_CTX *ctx, const void *key, int key_len, const EVP_MD *md);
// int replaced_HMAC_Init(HMAC_CTX *ctx, const void *key, int key_len, const EVP_MD *md)
// {

// }

int (*orig_HMAC_Init_ex) (HMAC_CTX *ctx, const void *key, int key_len, const EVP_MD *md, ENGINE *impl);
int replaced_HMAC_Init_ex (HMAC_CTX *ctx, const void *key, int key_len, const EVP_MD *md, ENGINE *impl)
{
    int ret = orig_HMAC_Init_ex(ctx, key, key_len, md, impl);

    NSString *str = [[NSString alloc] initWithBytes:key length:key_len encoding:NSASCIIStringEncoding];

    DDLogVerbose(@"HMAC_Init_ex key: %@, Hash: %d", str, md->type);
    return ret;
}

int (*orig_HMAC_Update) (HMAC_CTX *ctx, const unsigned char *data, int len);
int replaced_HMAC_Update (HMAC_CTX *ctx, const unsigned char *data, int len)
{
    NSMutableString *data_hex = [NSMutableString string];
    for (int i=0; i<len; i++)
        [data_hex appendFormat:@"%02x", data[i]];

    DDLogVerbose(@"HMAC_Update data: %@", data_hex);
    return orig_HMAC_Update(ctx, data, len);
}
// int HMAC_Final(HMAC_CTX *ctx, unsigned char *md, unsigned int *len);

// void HMAC_CTX_cleanup(HMAC_CTX *ctx);
// void HMAC_cleanup(HMAC_CTX *ctx);








/*
    SHA Stuff

    SHA1() computes the SHA-1 message digest of the n bytes at d and places it in md 
    (which must have space for SHA_DIGEST_LENGTH == 20 bytes of output). 

    If md is NULL, the digest is placed in a static array.

    Note: setting md to NULL is not thread safe.

    Applications should use the higher level functions EVP_DigestInit etc. instead of calling the hash functions directly.
*/
// int SHA1_Init(SHA_CTX *c);
// int SHA1_Update(SHA_CTX *c, const void *data, size_t len);
// int SHA1_Final(unsigned char *md, SHA_CTX *c);
// unsigned char *SHA1(const unsigned char *d, size_t n, unsigned char *md);

// int SHA224_Init(SHA256_CTX *c);
// int SHA224_Update(SHA256_CTX *c, const void *data, size_t len);
// int SHA224_Final(unsigned char *md, SHA256_CTX *c);
// unsigned char *SHA224(const unsigned char *d, size_t n, unsigned char *md);

// int SHA256_Init(SHA256_CTX *c);
// int SHA256_Update(SHA256_CTX *c, const void *data, size_t len);
// int SHA256_Final(unsigned char *md, SHA256_CTX *c);
// unsigned char *SHA256(const unsigned char *d, size_t n, unsigned char *md);

// int SHA384_Init(SHA512_CTX *c);
// int SHA384_Update(SHA512_CTX *c, const void *data, size_t len);
// int SHA384_Final(unsigned char *md, SHA512_CTX *c);
// unsigned char *SHA384(const unsigned char *d, size_t n, unsigned char *md);

// int SHA512_Init(SHA512_CTX *c);
// int SHA512_Update(SHA512_CTX *c, const void *data, size_t len);
// int SHA512_Final(unsigned char *md, SHA512_CTX *c);
// unsigned char *SHA512(const unsigned char *d, size_t n, unsigned char *md);



/*
    X509_NAME lookup and enumeration functions
*/
// int X509_NAME_get_index_by_NID(X509_NAME *name,int nid,int lastpos);
// int X509_NAME_get_index_by_OBJ(X509_NAME *name,ASN1_OBJECT *obj, int lastpos);
// int X509_NAME_entry_count(X509_NAME *name);
// X509_NAME_ENTRY *X509_NAME_get_entry(X509_NAME *name, int loc);
int (*orig_X509_NAME_get_text_by_NID) (X509_NAME *name, int nid, char *buf, int len);
int replaced_X509_NAME_get_text_by_NID (X509_NAME *name, int nid, char *buf, int len)
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

    if ([[plist objectForKey:@"settings_HookOpenSSL_modify_x509"] boolValue])
    {
        NSLog(@"OpenSSL Modifying x509 Data");
        NSString *nsstring_commonName = [plist objectForKey:@"settings_HookOpenSSL_CommonName"];
        const char *commonName = [nsstring_commonName UTF8String];

        NSString *nsstring_orgName = [plist objectForKey:@"settings_HookOpenSSL_OrgName"];
        const char *orgName = [nsstring_orgName UTF8String];

        NSString *nsstring_orgUnitName = [plist objectForKey:@"settings_HookOpenSSL_OrgUnitName"];
        const char *orgUnitName = [nsstring_orgUnitName UTF8String];

        if ( (nid == NID_commonName) && (![[NSString stringWithCString:commonName encoding:NSASCIIStringEncoding] isEqual: @""])) {
            NSLog(@"Changing Common Name to %s", commonName);
            int ret = orig_X509_NAME_get_text_by_NID(name, NID_commonName, buf, len);
            strcpy(buf, commonName);
            return ret;
        }
        if ( (nid == NID_organizationName) && (![[NSString stringWithCString:orgName encoding:NSASCIIStringEncoding] isEqual: @""])) {
            NSLog(@"Changing Organization Name to %s", orgName);
            int ret = orig_X509_NAME_get_text_by_NID(name, NID_organizationName, buf, len);
            strcpy(buf, orgName);
            return ret;
        }
        if ( (nid == NID_organizationalUnitName) && (![[NSString stringWithCString:orgUnitName encoding:NSASCIIStringEncoding] isEqual: @""])) {
            NSLog(@"Changing Organization Unit Name to %s", orgUnitName);
            int ret = orig_X509_NAME_get_text_by_NID(name, NID_organizationalUnitName, buf, len);
            strcpy(buf, orgUnitName);
            return ret;
        }
    }

    return orig_X509_NAME_get_text_by_NID(name, nid, buf, len);
}
// int X509_NAME_get_text_by_OBJ(X509_NAME *name, ASN1_OBJECT *obj, char *buf,int len);






#define InstallHook_FindSymbol(funcname) if ([[plist objectForKey:@"settings_HookOpenSSL_Crypto_"#funcname] boolValue]) { MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic_FindSymbol(funcname) MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname)

void OpenSSL_Crypto_function_hooks()
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

    InstallHook_FindSymbol(EVP_EncryptInit);
    InstallHook_FindSymbol(EVP_EncryptUpdate);
    InstallHook_FindSymbol(EVP_EncryptFinal);

    InstallHook_FindSymbol(EVP_DecryptInit);
    InstallHook_FindSymbol(EVP_DecryptUpdate);
    InstallHook_FindSymbol(EVP_DecryptFinal);

    InstallHook_FindSymbol(HMAC);
    InstallHook_FindSymbol(HMAC_Init_ex);
    InstallHook_FindSymbol(HMAC_Update);

    InstallHook_FindSymbol(PKCS5_PBKDF2_HMAC);


    if (disableSSLPinning())
    {
        InstallHook_basic_FindSymbol(X509_NAME_get_text_by_NID);
    }
}
