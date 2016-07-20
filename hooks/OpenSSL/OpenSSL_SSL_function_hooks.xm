/*
 File Description:
  
    ****************************
    ** OpenSSL SSL Functions  **
    ****************************

    https://www.openssl.org/docs/ssl/ssl.html

    Last referenced: 24 June 2015
*/
#import "../../swizzler.common.h"
#import "OpenSSL.h"
/*
    DEALING WITH SESSIONS

    Here we document the various API functions which deal with the SSL/TLS sessions 
    defined in the SSL_SESSION structures.
*/
// int SSL_SESSION_cmp(const SSL_SESSION *a, const SSL_SESSION *b);
// void SSL_SESSION_free(SSL_SESSION *ss);
// char *SSL_SESSION_get_app_data(SSL_SESSION *s);
// char *SSL_SESSION_get_ex_data(const SSL_SESSION *s, int idx);
// int SSL_SESSION_get_ex_new_index(long argl, char *argp, int (*new_func);(void), int (*dup_func)(void), void (*free_func)(void))
// long SSL_SESSION_get_time(const SSL_SESSION *s);
// long SSL_SESSION_get_timeout(const SSL_SESSION *s);
// unsigned long SSL_SESSION_hash(const SSL_SESSION *a);
// SSL_SESSION *SSL_SESSION_new(void);
// int SSL_SESSION_print(BIO *bp, const SSL_SESSION *x);
// int SSL_SESSION_print_fp(FILE *fp, const SSL_SESSION *x);
// void SSL_SESSION_set_app_data(SSL_SESSION *s, char *a);
// int SSL_SESSION_set_ex_data(SSL_SESSION *s, int idx, char *arg);
// long SSL_SESSION_set_time(SSL_SESSION *s, long t);
// long SSL_SESSION_set_timeout(SSL_SESSION *s, long t);


/*
    DEALING WITH CONNECTIONS
    
    Here we document the various API functions which deal with the SSL/TLS connection 
    defined in the SSL structure.
*/
// int SSL_accept(SSL *ssl);
// int SSL_add_dir_cert_subjects_to_stack(STACK *stack, const char *dir);
// int SSL_add_file_cert_subjects_to_stack(STACK *stack, const char *file);
// int SSL_add_client_CA(SSL *ssl, X509 *x);
// char *SSL_alert_desc_string(int value);
// char *SSL_alert_desc_string_long(int value);
// char *SSL_alert_type_string(int value);
// char *SSL_alert_type_string_long(int value);
// int SSL_check_private_key(const SSL *ssl);
// void SSL_clear(SSL *ssl);
// long SSL_clear_num_renegotiations(SSL *ssl);
// int SSL_connect(SSL *ssl);
// int SSL_copy_session_id(SSL *t, const SSL *f); //Sets the session details for t to be the same as in f. Returns 1 on success or 0 on failure.
// long SSL_ctrl(SSL *ssl, int cmd, long larg, char *parg);
// int SSL_do_handshake(SSL *ssl);
// SSL *SSL_dup(SSL *ssl);
// STACK *SSL_dup_CA_list(STACK *sk);
// void SSL_free(SSL *ssl);
// SSL_CTX *SSL_get_SSL_CTX(const SSL *ssl);
// char *SSL_get_app_data(SSL *ssl);
// X509 *SSL_get_certificate(const SSL *ssl);
// const char *SSL_get_cipher(const SSL *ssl);
// int SSL_get_cipher_bits(const SSL *ssl, int *alg_bits);
// char *SSL_get_cipher_list(const SSL *ssl, int n);
// char *SSL_get_cipher_name(const SSL *ssl);
// char *SSL_get_cipher_version(const SSL *ssl);
// STACK *SSL_get_ciphers(const SSL *ssl);
// STACK *SSL_get_client_CA_list(const SSL *ssl);
// SSL_CIPHER *SSL_get_current_cipher(SSL *ssl);
// long SSL_get_default_timeout(const SSL *ssl);
// int SSL_get_error(const SSL *ssl, int i);
// char *SSL_get_ex_data(const SSL *ssl, int idx);
// int SSL_get_ex_data_X509_STORE_CTX_idx(void);
// int SSL_get_ex_new_index(long argl, char *argp, int (*new_func);(void), int (*dup_func)(void), void (*free_func)(void))
// int SSL_get_fd(const SSL *ssl);
// void (*SSL_get_info_callback(const SSL *ssl);)()
// STACK *SSL_get_peer_cert_chain(const SSL *ssl);
// X509 *SSL_get_peer_certificate(const SSL *ssl);
// EVP_PKEY *SSL_get_privatekey(const SSL *ssl);
// int SSL_get_quiet_shutdown(const SSL *ssl);
// BIO *SSL_get_rbio(const SSL *ssl);
// int SSL_get_read_ahead(const SSL *ssl);
// SSL_SESSION *SSL_get_session(const SSL *ssl);
// char *SSL_get_shared_ciphers(const SSL *ssl, char *buf, int len);
// int SSL_get_shutdown(const SSL *ssl);
// const SSL_METHOD *SSL_get_ssl_method(SSL *ssl);
// int SSL_get_state(const SSL *ssl);
// long SSL_get_time(const SSL *ssl);
// long SSL_get_timeout(const SSL *ssl);
// int (*SSL_get_verify_callback(const SSL *ssl))(int,X509_STORE_CTX *)
// int SSL_get_verify_mode(const SSL *ssl);
long (*orig_SSL_get_verify_result) (const SSL *ssl);
long replaced_SSL_get_verify_result (const SSL *ssl)
{
    return X509_V_OK;
}
// char *SSL_get_version(const SSL *ssl);
// BIO *SSL_get_wbio(const SSL *ssl);
// int SSL_in_accept_init(SSL *ssl);
// int SSL_in_before(SSL *ssl);
// int SSL_in_connect_init(SSL *ssl);
// int SSL_in_init(SSL *ssl);
// int SSL_is_init_finished(SSL *ssl);
// STACK *SSL_load_client_CA_file(char *file);
// void SSL_load_error_strings(void);
// SSL *SSL_new(SSL_CTX *ctx);
// long SSL_num_renegotiations(SSL *ssl);
// int SSL_peek(SSL *ssl, void *buf, int num);
// int SSL_pending(const SSL *ssl);
int (*orig_SSL_read) (SSL *ssl, void *buf, int num);
int replaced_SSL_read (SSL *ssl, void *buf, int num)
{
    int ret = orig_SSL_read(ssl, buf, num);

    NSString *str = [[NSString alloc] initWithBytes:buf length:num encoding:NSASCIIStringEncoding];
    NSLog(@"SSL_read: %@", str);

    // DDLogVerbose(@"OpenSSL SSL_read buf:%@, num:%d", data, num);

    return ret;
}
// int SSL_renegotiate(SSL *ssl);
// char *SSL_rstate_string(SSL *ssl);
// char *SSL_rstate_string_long(SSL *ssl);
// long SSL_session_reused(SSL *ssl);
// void SSL_set_accept_state(SSL *ssl);
// void SSL_set_app_data(SSL *ssl, char *arg);
// void SSL_set_bio(SSL *ssl, BIO *rbio, BIO *wbio);
// int SSL_set_cipher_list(SSL *ssl, char *str);
// void SSL_set_client_CA_list(SSL *ssl, STACK *list);
// void SSL_set_connect_state(SSL *ssl);
// int SSL_set_ex_data(SSL *ssl, int idx, char *arg);
// int SSL_set_fd(SSL *ssl, int fd);
// void SSL_set_info_callback(SSL *ssl, void (*cb);(void))
// void SSL_set_msg_callback(SSL *ctx, void (*cb)(int write_p, int version, int content_type, const void *buf, size_t len, SSL *ssl, void *arg));
// void SSL_set_msg_callback_arg(SSL *ctx, void *arg);
// void SSL_set_options(SSL *ssl, unsigned long op);
// void SSL_set_quiet_shutdown(SSL *ssl, int mode);
// void SSL_set_read_ahead(SSL *ssl, int yes);
// int SSL_set_rfd(SSL *ssl, int fd);
// int SSL_set_session(SSL *ssl, SSL_SESSION *session);
// void SSL_set_shutdown(SSL *ssl, int mode);
// int SSL_set_ssl_method(SSL *ssl, const SSL_METHOD *meth);
// void SSL_set_time(SSL *ssl, long t);
// void SSL_set_timeout(SSL *ssl, long t);
void (*orig_SSL_set_verify) (SSL *ssl, int mode, int (*callback));
void replaced_SSL_set_verify(SSL *ssl, int mode, int (*callback))
{
    orig_SSL_set_verify(ssl, SSL_VERIFY_NONE, callback); 
}
// void SSL_set_verify_result(SSL *ssl, long arg);
// int SSL_set_wfd(SSL *ssl, int fd);
// int SSL_shutdown(SSL *ssl);
// int SSL_state(const SSL *ssl);
// char *SSL_state_string(const SSL *ssl);
// char *SSL_state_string_long(const SSL *ssl);
// long SSL_total_renegotiations(SSL *ssl);
// int SSL_use_PrivateKey(SSL *ssl, EVP_PKEY *pkey);
// int SSL_use_PrivateKey_ASN1(int type, SSL *ssl, unsigned char *d, long len);
// int SSL_use_PrivateKey_file(SSL *ssl, char *file, int type);
// int SSL_use_RSAPrivateKey(SSL *ssl, RSA *rsa);
// int SSL_use_RSAPrivateKey_ASN1(SSL *ssl, unsigned char *d, long len);
// int SSL_use_RSAPrivateKey_file(SSL *ssl, char *file, int type);
// int SSL_use_certificate(SSL *ssl, X509 *x);
// int SSL_use_certificate_ASN1(SSL *ssl, int len, unsigned char *d);
// int SSL_use_certificate_file(SSL *ssl, char *file, int type);
// int SSL_version(const SSL *ssl);
// int SSL_want(const SSL *ssl);
// int SSL_want_nothing(const SSL *ssl);
// int SSL_want_read(const SSL *ssl);
// int SSL_want_write(const SSL *ssl);
// int SSL_want_x509_lookup(const SSL *ssl);
// int SSL_write(SSL *ssl, const void *buf, int num);
// void SSL_set_psk_client_callback(SSL *ssl, unsigned int (*callback)(SSL *ssl, const char *hint, char *identity, unsigned int max_identity_len, unsigned char *psk, unsigned int max_psk_len));
// int SSL_use_psk_identity_hint(SSL *ssl, const char *hint);
// void SSL_set_psk_server_callback(SSL *ssl, unsigned int (*callback)(SSL *ssl, const char *identity, unsigned char *psk, int max_psk_len));
// const char *SSL_get_psk_identity_hint(SSL *ssl);
// const char *SSL_get_psk_identity(SSL *ssl);








/*
DEALING WITH PROTOCOL CONTEXTS

Here we document the various API functions which deal with the SSL/TLS protocol context defined in the SSL_CTX structure.
*/
// int SSL_CTX_add_client_CA(SSL_CTX *ctx, X509 *x);
// long SSL_CTX_add_extra_chain_cert(SSL_CTX *ctx, X509 *x509);
// int SSL_CTX_add_session(SSL_CTX *ctx, SSL_SESSION *c);
// int SSL_CTX_check_private_key(const SSL_CTX *ctx);
// long SSL_CTX_ctrl(SSL_CTX *ctx, int cmd, long larg, char *parg);
// void SSL_CTX_flush_sessions(SSL_CTX *s, long t);
// void SSL_CTX_free(SSL_CTX *a);
// char *SSL_CTX_get_app_data(SSL_CTX *ctx);
// X509_STORE *SSL_CTX_get_cert_store(SSL_CTX *ctx);
// STACK *SSL_CTX_get_client_CA_list(const SSL_CTX *ctx);
// int (*SSL_CTX_get_client_cert_cb(SSL_CTX *ctx))(SSL *ssl, X509 **x509, EVP_PKEY **pkey);
// void SSL_CTX_get_default_read_ahead(SSL_CTX *ctx);
// char *SSL_CTX_get_ex_data(const SSL_CTX *s, int idx);
// int SSL_CTX_get_ex_new_index(long argl, char *argp, int (*new_func);(void), int (*dup_func)(void), void (*free_func)(void))
// void (*SSL_CTX_get_info_callback(SSL_CTX *ctx))(SSL *ssl, int cb, int ret);
// int SSL_CTX_get_quiet_shutdown(const SSL_CTX *ctx);
// void SSL_CTX_get_read_ahead(SSL_CTX *ctx);
// int SSL_CTX_get_session_cache_mode(SSL_CTX *ctx);
// long SSL_CTX_get_timeout(const SSL_CTX *ctx);
// int (*SSL_CTX_get_verify_callback(const SSL_CTX *ctx))(int ok, X509_STORE_CTX *ctx);
// int SSL_CTX_get_verify_mode(SSL_CTX *ctx);
// int SSL_CTX_load_verify_locations(SSL_CTX *ctx, char *CAfile, char *CApath);
// long SSL_CTX_need_tmp_RSA(SSL_CTX *ctx);
// SSL_CTX *SSL_CTX_new(const SSL_METHOD *meth);
// int SSL_CTX_remove_session(SSL_CTX *ctx, SSL_SESSION *c);
// int SSL_CTX_sess_accept(SSL_CTX *ctx);
// int SSL_CTX_sess_accept_good(SSL_CTX *ctx);
// int SSL_CTX_sess_accept_renegotiate(SSL_CTX *ctx);
// int SSL_CTX_sess_cache_full(SSL_CTX *ctx);
// int SSL_CTX_sess_cb_hits(SSL_CTX *ctx);
// int SSL_CTX_sess_connect(SSL_CTX *ctx);
// int SSL_CTX_sess_connect_good(SSL_CTX *ctx);
// int SSL_CTX_sess_connect_renegotiate(SSL_CTX *ctx);
// int SSL_CTX_sess_get_cache_size(SSL_CTX *ctx);
// SSL_SESSION *(*SSL_CTX_sess_get_get_cb(SSL_CTX *ctx))(SSL *ssl, unsigned char *data, int len, int *copy);
// int (*SSL_CTX_sess_get_new_cb(SSL_CTX *ctx)(SSL *ssl, SSL_SESSION *sess);
// void (*SSL_CTX_sess_get_remove_cb(SSL_CTX *ctx)(SSL_CTX *ctx, SSL_SESSION *sess);
// int SSL_CTX_sess_hits(SSL_CTX *ctx);
// int SSL_CTX_sess_misses(SSL_CTX *ctx);
// int SSL_CTX_sess_number(SSL_CTX *ctx);
// void SSL_CTX_sess_set_cache_size(SSL_CTX *ctx,t);
// void SSL_CTX_sess_set_get_cb(SSL_CTX *ctx, SSL_SESSION *(*cb)(SSL *ssl, unsigned char *data, int len, int *copy));
// void SSL_CTX_sess_set_new_cb(SSL_CTX *ctx, int (*cb)(SSL *ssl, SSL_SESSION *sess));
// void SSL_CTX_sess_set_remove_cb(SSL_CTX *ctx, void (*cb)(SSL_CTX *ctx, SSL_SESSION *sess));
// int SSL_CTX_sess_timeouts(SSL_CTX *ctx);
// LHASH *SSL_CTX_sessions(SSL_CTX *ctx);
// void SSL_CTX_set_app_data(SSL_CTX *ctx, void *arg);
// void SSL_CTX_set_cert_store(SSL_CTX *ctx, X509_STORE *cs);
// void SSL_CTX_set_cert_verify_cb(SSL_CTX *ctx, int (*cb)(), char *arg)
// int SSL_CTX_set_cipher_list(SSL_CTX *ctx, char *str);
// void SSL_CTX_set_client_CA_list(SSL_CTX *ctx, STACK *list);
// void SSL_CTX_set_client_cert_cb(SSL_CTX *ctx, int (*cb)(SSL *ssl, X509 **x509, EVP_PKEY **pkey));
// void SSL_CTX_set_default_passwd_cb(SSL_CTX *ctx, int (*cb);(void))
// void SSL_CTX_set_default_read_ahead(SSL_CTX *ctx, int m);
// int SSL_CTX_set_default_verify_paths(SSL_CTX *ctx);
// int SSL_CTX_set_default_verify_dir(SSL_CTX *ctx)
// int SSL_CTX_set_default_verify_file(SSL_CTX *ctx)
// int SSL_CTX_set_ex_data(SSL_CTX *s, int idx, char *arg);
// void SSL_CTX_set_info_callback(SSL_CTX *ctx, void (*cb)(SSL *ssl, int cb, int ret));
// void SSL_CTX_set_msg_callback(SSL_CTX *ctx, void (*cb)(int write_p, int version, int content_type, const void *buf, size_t len, SSL *ssl, void *arg));
// void SSL_CTX_set_msg_callback_arg(SSL_CTX *ctx, void *arg);
// void SSL_CTX_set_options(SSL_CTX *ctx, unsigned long op);
// void SSL_CTX_set_quiet_shutdown(SSL_CTX *ctx, int mode);
// void SSL_CTX_set_read_ahead(SSL_CTX *ctx, int m);
// void SSL_CTX_set_session_cache_mode(SSL_CTX *ctx, int mode);
// int SSL_CTX_set_ssl_version(SSL_CTX *ctx, const SSL_METHOD *meth);
// void SSL_CTX_set_timeout(SSL_CTX *ctx, long t);
// long SSL_CTX_set_tmp_dh(SSL_CTX* ctx, DH *dh);
// long SSL_CTX_set_tmp_dh_callback(SSL_CTX *ctx, DH *(*cb)(void));
// long SSL_CTX_set_tmp_rsa(SSL_CTX *ctx, RSA *rsa);
// long SSL_CTX_set_tmp_rsa_callback(SSL_CTX *ctx, RSA *(*cb)(SSL *ssl, int export, int keylength));
// long SSL_set_tmp_rsa_callback(SSL *ssl, RSA *(*cb)(SSL *ssl, int export, int keylength));
void (*orig_SSL_CTX_set_verify) (SSL_CTX *ctx, int mode, int (*cb));
void replaced_SSL_CTX_set_verify (SSL_CTX *ctx, int mode, int (*cb))
{
    NSLog(@"OpenSSL SSL_CTX_set_verify");
    orig_SSL_CTX_set_verify(ctx, SSL_VERIFY_NONE, cb);
}
// int SSL_CTX_use_PrivateKey(SSL_CTX *ctx, EVP_PKEY *pkey);
// int SSL_CTX_use_PrivateKey_ASN1(int type, SSL_CTX *ctx, unsigned char *d, long len);
// int SSL_CTX_use_PrivateKey_file(SSL_CTX *ctx, char *file, int type);
// int SSL_CTX_use_RSAPrivateKey(SSL_CTX *ctx, RSA *rsa);
// int SSL_CTX_use_RSAPrivateKey_ASN1(SSL_CTX *ctx, unsigned char *d, long len);
// int SSL_CTX_use_RSAPrivateKey_file(SSL_CTX *ctx, char *file, int type);
// int SSL_CTX_use_certificate(SSL_CTX *ctx, X509 *x);
// int SSL_CTX_use_certificate_ASN1(SSL_CTX *ctx, int len, unsigned char *d);
// int SSL_CTX_use_certificate_file(SSL_CTX *ctx, char *file, int type);
// X509 *SSL_CTX_get0_certificate(const SSL_CTX *ctx);
// EVP_PKEY *SSL_CTX_get0_privatekey(const SSL_CTX *ctx);
// void SSL_CTX_set_psk_client_callback(SSL_CTX *ctx, unsigned int (*callback)(SSL *ssl, const char *hint, char *identity, unsigned int max_identity_len, unsigned char *psk, unsigned int max_psk_len));
// int SSL_CTX_use_psk_identity_hint(SSL_CTX *ctx, const char *hint);
// void SSL_CTX_set_psk_server_callback(SSL_CTX *ctx, unsigned int (*callback)(SSL *ssl, const char *identity, unsigned char *psk, int max_psk_len));






#define InstallHook_FindSymbol(funcname) if ([[plist objectForKey:@"settings_HookOpenSSL_SSL_"#funcname] boolValue]) { MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic_FindSymbol(funcname) MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname)
void OpenSSL_SSL_function_hooks()
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

    InstallHook_FindSymbol(SSL_read);

    // OpenSSL Pinning functions found from:
    // https://www.owasp.org/index.php/Pinning_Cheat_Sheet#OpenSSL
    if (disableSSLPinning())
    {
        InstallHook_basic_FindSymbol(SSL_get_verify_result);
        InstallHook_basic_FindSymbol(SSL_set_verify);
        InstallHook_basic_FindSymbol(SSL_CTX_set_verify);
    }
}





