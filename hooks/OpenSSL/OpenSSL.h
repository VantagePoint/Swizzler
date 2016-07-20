/*
 File Description:
  
    **********************
    ** OpenSSL Includes **
    **********************

    #include <openssl/evp.h>
    #include <openssl/hmac.h>
    #import <openssl/ssl.h>
    https://www.openssl.org/docs/ssl/ssl.html
    https://www.openssl.org/docs/crypto/EVP_EncryptInit.html
    https://www.openssl.org/docs/crypto/hmac.html

*/
#import <openssl/evp.h>
#import <openssl/hmac.h>
#import <openssl/ssl.h>

/**********************************
    OpenSSL Crypto Functions
***********************************/
void OpenSSL_Crypto_function_hooks();

/**********************************
    OpenSSL SSL Functions
***********************************/
void OpenSSL_SSL_function_hooks();
