/*
 File Description:
  
  ************************************
  ** C function hooks (Man (3 SSL)) **
  ************************************
    
  Section 3ssl of the manual contains documentation on OpenSSL library routines. 
  These functions are described in headers that reside in /usr/include/openssl, 
  and are split between the libssl and libcrypto libraries.
*/
#import "../../swizzler.common.h"



#import "C_function_hooks_section3ssl.h"



// #define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookCFunctions2_hookall"] boolValue] || [[plist objectForKey:@"settings_HookCFunctions2_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook(funcname) MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname)



/*
 OpenSSL
*/

/*
 DEALING WITH CONNECTIONS
*/

// int replaced_SSL_accept(SSL *ssl);
// int replaced_SSL_add_dir_cert_subjects_to_stack(STACK *stack, const char *dir);
// int replaced_SSL_add_file_cert_subjects_to_stack(STACK *stack, const char *file);
// int replaced_SSL_add_client_CA(SSL *ssl, X509 *x);
// char *replaced_SSL_alert_desc_string(int value);
// char *replaced_SSL_alert_desc_string_long(int value);
// char *replaced_SSL_alert_type_string(int value);
// char *replaced_SSL_alert_type_string_long(int value);
// int replaced_SSL_check_private_key(const SSL *ssl);
// void replaced_SSL_clear(SSL *ssl);
// long replaced_SSL_clear_num_renegotiations(SSL *ssl);
// int replaced_SSL_connect(SSL *ssl);
// void replaced_SSL_copy_session_id(SSL *t, const SSL *f);
// long replaced_SSL_ctrl(SSL *ssl, int cmd, long larg, char *parg);
// int replaced_SSL_do_handshake(SSL *ssl);
// SSL *replaced_SSL_dup(SSL *ssl);
// STACK *replaced_SSL_dup_CA_list(STACK *sk);
// void replaced_SSL_free(SSL *ssl);
// SSL_CTX *replaced_SSL_get_SSL_CTX(const SSL *ssl);
// char *replaced_SSL_get_app_data(SSL *ssl);
// X509 *replaced_SSL_get_certificate(const SSL *ssl);
// const char *SSL_get_cipher(const SSL *ssl);
// int replaced_SSL_get_cipher_bits(const SSL *ssl, int *alg_bits);
// char *replaced_SSL_get_cipher_list(const SSL *ssl, int n);
// char *replaced_SSL_get_cipher_name(const SSL *ssl);
// char *replaced_SSL_get_cipher_version(const SSL *ssl);
// STACK *replaced_SSL_get_ciphers(const SSL *ssl);
// STACK *replaced_SSL_get_client_CA_list(const SSL *ssl);
// SSL_CIPHER *replaced_SSL_get_current_cipher(SSL *ssl);
// long replaced_SSL_get_default_timeout(const SSL *ssl);
// int replaced_SSL_get_error(const SSL *ssl, int i);
// char *replaced_SSL_get_ex_data(const SSL *ssl, int idx);
// int replaced_SSL_get_ex_data_X509_STORE_CTX_idx(void);
// int replaced_SSL_get_ex_new_index(long argl, char *argp, int (*new_func);(void), int (*dup_func)(void), void (*free_func)(void))
// int replaced_SSL_get_fd(const SSL *ssl);
// void (*replaced_SSL_get_info_callback(const SSL *ssl);)()
// STACK *replaced_SSL_get_peer_cert_chain(const SSL *ssl);
// X509 *replaced_SSL_get_peer_certificate(const SSL *ssl);
// EVP_PKEY *replaced_SSL_get_privatekey(SSL *ssl);
// int replaced_SSL_get_quiet_shutdown(const SSL *ssl);
// BIO *replaced_SSL_get_rbio(const SSL *ssl);
// int replaced_SSL_get_read_ahead(const SSL *ssl);
// SSL_SESSION *replaced_SSL_get_session(const SSL *ssl);
// char *replaced_SSL_get_shared_ciphers(const SSL *ssl, char *buf, int len);
// int replaced_SSL_get_shutdown(const SSL *ssl);
// SSL_METHOD *replaced_SSL_get_ssl_method(SSL *ssl);
// int SSL_get_state(const SSL *ssl);
// long SSL_get_time(const SSL *ssl);
// long SSL_get_timeout(const SSL *ssl);
// int (*replaced_SSL_get_verify_callback(const SSL *ssl))(int,X509_STORE_CTX *)
// int SSL_get_verify_mode(const SSL *ssl);
// long replaced_SSL_get_verify_result(const SSL *ssl);
// char *replaced_SSL_get_version(const SSL *ssl);
// BIO *replaced_SSL_get_wbio(const SSL *ssl);
// int replaced_SSL_in_accept_init(SSL *ssl);
// int replaced_SSL_in_before(SSL *ssl);
// int replaced_SSL_in_connect_init(SSL *ssl);
// int replaced_SSL_in_init(SSL *ssl);
// int replaced_SSL_is_init_finished(SSL *ssl);
// STACK *replaced_SSL_load_client_CA_file(char *file);
// void replaced_SSL_load_error_strings(void);
// SSL *replaced_SSL_new(SSL_CTX *ctx);
// long replaced_SSL_num_renegotiations(SSL *ssl);
// int replaced_SSL_peek(SSL *ssl, void *buf, int num);
// int replaced_SSL_pending(const SSL *ssl);
int (*orig_SSL_read) (SSL *ssl, void *buf, int num);
int replaced_SSL_read(SSL *ssl, void *buf, int num)
{
    int ret = orig_SSL_read(ssl, buf, num);

    NSString *str = [[NSString alloc] initWithBytes:buf length:num encoding:NSASCIIStringEncoding];
    NSLog(@"SSL_read: %@", str);
 
    return ret;
};
// int replaced_SSL_renegotiate(SSL *ssl);
// char *replaced_SSL_rstate_string(SSL *ssl);
// char *replaced_SSL_rstate_string_long(SSL *ssl);
// long replaced_SSL_session_reused(SSL *ssl);
// void replaced_SSL_set_accept_state(SSL *ssl);
// void replaced_SSL_set_app_data(SSL *ssl, char *arg);
// void replaced_SSL_set_bio(SSL *ssl, BIO *rbio, BIO *wbio);
// int replaced_SSL_set_cipher_list(SSL *ssl, char *str);
// void replaced_SSL_set_client_CA_list(SSL *ssl, STACK *list);
// void replaced_SSL_set_connect_state(SSL *ssl);
// int replaced_SSL_set_ex_data(SSL *ssl, int idx, char *arg);
// int replaced_SSL_set_fd(SSL *ssl, int fd);
// void replaced_SSL_set_info_callback(SSL *ssl, void (*cb);(void))
// void replaced_SSL_set_msg_callback(SSL *ctx, void (*cb)(int write_p, int version, int content_type, const void *buf, size_t len, SSL *ssl, void *arg));
// void replaced_SSL_set_msg_callback_arg(SSL *ctx, void *arg);
// void replaced_SSL_set_options(SSL *ssl, unsigned long op);
// void replaced_SSL_set_quiet_shutdown(SSL *ssl, int mode);
// void replaced_SSL_set_read_ahead(SSL *ssl, int yes);
// int replaced_SSL_set_rfd(SSL *ssl, int fd);
// int replaced_SSL_set_session(SSL *ssl, SSL_SESSION *session);
// void replaced_SSL_set_shutdown(SSL *ssl, int mode);
// int replaced_SSL_set_ssl_method(SSL *ssl, SSL_METHOD *meth);
// void replaced_SSL_set_time(SSL *ssl, long t);
// void replaced_SSL_set_timeout(SSL *ssl, long t);
// void replaced_SSL_set_verify(SSL *ssl, int mode, int (*callback);(void))
// void replaced_SSL_set_verify_result(SSL *ssl, long arg);
// int replaced_SSL_set_wfd(SSL *ssl, int fd);
// int replaced_SSL_shutdown(SSL *ssl);
// int replaced_SSL_state(const SSL *ssl);
// char *replaced_SSL_state_string(const SSL *ssl);
// char *replaced_SSL_state_string_long(const SSL *ssl);
// long replaced_SSL_total_renegotiations(SSL *ssl);
// int replaced_SSL_use_PrivateKey(SSL *ssl, EVP_PKEY *pkey);
// int replaced_SSL_use_PrivateKey_ASN1(int type, SSL *ssl, unsigned char *d, long len);
// int replaced_SSL_use_PrivateKey_file(SSL *ssl, char *file, int type);
// int replaced_SSL_use_RSAPrivateKey(SSL *ssl, RSA *rsa);
// int replaced_SSL_use_RSAPrivateKey_ASN1(SSL *ssl, unsigned char *d, long len);
// int replaced_SSL_use_RSAPrivateKey_file(SSL *ssl, char *file, int type);
// int replaced_SSL_use_certificate(SSL *ssl, X509 *x);
// int replaced_SSL_use_certificate_ASN1(SSL *ssl, int len, unsigned char *d);
// int replaced_SSL_use_certificate_file(SSL *ssl, char *file, int type);
// int replaced_SSL_version(const SSL *ssl);
// int replaced_SSL_want(const SSL *ssl);
// int replaced_SSL_want_nothing(const SSL *ssl);
// int replaced_SSL_want_read(const SSL *ssl);
// int replaced_SSL_want_write(const SSL *ssl);
// int replaced_SSL_want_x509_lookup(const SSL *ssl);
// int replaced_SSL_write(SSL *ssl, const void *buf, int num);









void C_function_hooks_section3ssl()
{
    // NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

    // InstallHook(SSL_read);
    void *sslread_sub = MSFindSymbol(NULL, "_SSL_read");
    MSHookFunction(sslread_sub, (void *)replaced_SSL_read, (void**)&orig_SSL_read);
}// C_function_hooks_section3ssl()














