/*
 File Description:
  
    **************************
    ** Core Foundation URL  **
    **************************

    Core Foundation (also called CF) is a C application programming interface (API) in Mac OS X & iOS, and is a mix of low-level routines 
    and wrapper functions. Apple releases most of it as an open source project called CFLite that can be used to write cross-platform 
    applications for Mac OS X, Linux, and Windows;[1] a third-party open-source implementation called OpenCFLite also exists.
    Most Core Foundation routines follow a certain naming convention that deal with opaque objects, for example CFDictionaryRef for 
    functions whose names begin with CFDictionary, and these objects are often reference counted (manually) through CFRetain and CFRelease. 
    Internally, Core Foundation forms the base of the types in the Objective-C runtime as well.

*/

// #include <arpa/inet.h>





// Boolean (*orig_CFWriteStreamSetProperty)(CFWriteStreamRef stream, CFStringRef propertyName, CFTypeRef propertyValue);


// CFURLRef (*orig_CFURLCreateWithString)(CFAllocatorRef allocator, CFStringRef URLString, CFURLRef baseURL);



// CFHTTPMessageRef (*orig_CFHTTPMessageCreateRequest)(CFAllocatorRef alloc, CFStringRef requestMethod, CFURLRef url, CFStringRef httpVersion);
// void (*orig_CFStreamCreatePairWithSocketToHost)(CFAllocatorRef alloc, CFStringRef host, UInt32 port, CFReadStreamRef *readStream, CFWriteStreamRef *writeStream);
// void (*orig_CFStreamCreatePairWithPeerSocketSignature)(CFAllocatorRef alloc, const CFSocketSignature *signature, CFReadStreamRef *readStream, CFWriteStreamRef *writeStream);
// void (*orig_CFStreamCreatePairWithSocket)(CFAllocatorRef alloc, CFSocketNativeHandle sock, CFReadStreamRef *readStream, CFWriteStreamRef *writeStream);

// CFReadStreamRef (*orig_CFReadStreamCreateForHTTPRequest)(CFAllocatorRef alloc, CFHTTPMessageRef request);
// CFDictionaryRef (*orig_CFNetworkCopySystemProxySettings)(void);
// SecCertificateRef (*orig_SecCertificateCreateWithData)(CFAllocatorRef allocator, CFDataRef data);








// CFURLRef bf_CFURLCreateWithString(CFAllocatorRef allocator,
//         CFStringRef URLString, CFURLRef baseURL) {
//     const char * myCString =  [(__bridge NSString *)URLString UTF8String];
//     ispy_log_info(LOG_TCPIP, "CFURLCreateWithString: %s", myCString);
//     //NSLog(@"CFURLCreateWithString: %@", URLString);
//     return orig_CFURLCreateWithString(allocator, URLString, baseURL);
// }





// CFHTTPMessageRef bf_CFHTTPMessageCreateRequest(CFAllocatorRef alloc,
//         CFStringRef requestMethod, CFURLRef url, CFStringRef httpVersion) {
//     ispy_log_info(LOG_TCPIP, "CFHTTPMessageCreateRequest: %@ %@ %@", requestMethod,
//             url, httpVersion);
//     return orig_CFHTTPMessageCreateRequest(alloc, requestMethod, url,
//             httpVersion);
// }

// CFReadStreamRef CFReadStreamCreateForHTTPRequest(CFAllocatorRef alloc,
//         CFHTTPMessageRef request) {
//     ispy_log_info(LOG_TCPIP, "CFReadStreamCreateForHTTPRequest: %@",
//             (CFHTTPMessageRef) request);
//     return orig_CFReadStreamCreateForHTTPRequest(alloc, request);
// }

// void bf_CFStreamCreatePairWithSocketToHost( CFAllocatorRef alloc,
//                                             CFStringRef host, UInt32 port, CFReadStreamRef *readStream,
//                                             CFWriteStreamRef *writeStream) {
//     ispy_log_info(LOG_TCPIP, "CFStreamCreatePairWithSocketToHost: %s:%d", (char *)host, (unsigned int)port);
//     orig_CFStreamCreatePairWithSocketToHost(alloc, host, port, readStream, writeStream);
// }

// CFReadStreamRef bf_CFReadStreamCreateForHTTPRequest(CFAllocatorRef alloc, CFHTTPMessageRef request) {
//     ispy_log_info(LOG_TCPIP, "CFReadStreamCreateForHTTPRequest(%@)", request);
//     return orig_CFReadStreamCreateForHTTPRequest(alloc, request);
// }

// void bf_CFStreamCreatePairWithPeerSocketSignature(  CFAllocatorRef alloc,
//                                                     const CFSocketSignature *signature, CFReadStreamRef *readStream,
//                                                     CFWriteStreamRef *writeStream) {
//     ispy_log_info(LOG_TCPIP, "CFStreamCreatePairWithPeerSocketSignature");
//     orig_CFStreamCreatePairWithPeerSocketSignature(alloc, signature, readStream, writeStream);
// }

// void bf_CFStreamCreatePairWithSocket(   CFAllocatorRef alloc,
//                                         CFSocketNativeHandle sock, CFReadStreamRef *readStream,
//                                         CFWriteStreamRef *writeStream) {
//     ispy_log_info(LOG_TCPIP, "CFStreamCreatePairWithSocket: %d", (int) sock);
//     orig_CFStreamCreatePairWithSocket(alloc, sock, readStream, writeStream);
// }



// SecCertificateRef bf_SecCertificateCreateWithData(CFAllocatorRef allocator, CFDataRef data) {
//     ispy_log_info(LOG_TCPIP, "SecCertificateCreateWithData: called!");
//     return orig_SecCertificateCreateWithData(allocator, data);
// }

// CFDictionaryRef bf_CFNetworkCopySystemProxySettings(void) {
//     static CFMutableDictionaryRef proxySettings = (CFMutableDictionaryRef) orig_CFNetworkCopySystemProxySettings();
//     ispy_log_info(LOG_TCPIP, "CFNetworkCopySystemProxySettings: Got dict: %@", proxySettings);
//     return proxySettings;
// }




#define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookCoreFoundation_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic(funcname) MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname)

void startCFHooks()
{



}// startCFHooks()

