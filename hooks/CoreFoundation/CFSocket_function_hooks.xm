/*
 File Description:
  
    *****************************
    ** Core Foundation Socket  **
    *****************************

    Core Foundation (also called CF) is a C application programming interface (API) in Mac OS X & iOS, and is a mix of low-level routines 
    and wrapper functions. Apple releases most of it as an open source project called CFLite that can be used to write cross-platform 
    applications for Mac OS X, Linux, and Windows;[1] a third-party open-source implementation called OpenCFLite also exists.
    Most Core Foundation routines follow a certain naming convention that deal with opaque objects, for example CFDictionaryRef for 
    functions whose names begin with CFDictionary, and these objects are often reference counted (manually) through CFRetain and CFRelease. 
    Internally, Core Foundation forms the base of the types in the Objective-C runtime as well.

*/

// #include <arpa/inet.h>
#import "../../swizzler.common.h"

#include <sys/socket.h>
#include <netinet/in.h>    



/*
 Creating Sockets

 CFSocketCreate - Creates a CFSocket object of a specified protocol and type.
 CFSocketCreateConnectedToSocketSignature - Creates a CFSocket object and opens a connection to a remote socket.
 CFSocketCreateWithNative - Creates a CFSocket object for a pre-existing native socket.
 CFSocketCreateWithSocketSignature -  Creates a CFSocket object using information from a CFSocketSignature structure.
*/
CFSocketRef (*orig_CFSocketCreate) (CFAllocatorRef alloc, SInt32 protocolFamily, SInt32 socketType, SInt32 protocol, CFOptionFlags callBackTypes, CFSocketCallBack callout, const CFSocketContext *context);
CFSocketRef (*orig_CFSocketCreateConnectedToSocketSignature) ( CFAllocatorRef allocator, const CFSocketSignature *signature, CFOptionFlags callBackTypes, CFSocketCallBack callout, const CFSocketContext *context, CFTimeInterval timeout );
CFSocketRef (*orig_CFSocketCreateWithNative) ( CFAllocatorRef allocator, CFSocketNativeHandle sock, CFOptionFlags callBackTypes, CFSocketCallBack callout, const CFSocketContext *context );
CFSocketRef (*orig_CFSocketCreateWithSocketSignature) ( CFAllocatorRef allocator, const CFSocketSignature *signature, CFOptionFlags callBackTypes, CFSocketCallBack callout, const CFSocketContext *context );

CFSocketRef replaced_CFSocketCreate(CFAllocatorRef alloc, 
                            SInt32 protocolFamily, 
                            SInt32 socketType, 
                            SInt32 protocol, 
                            CFOptionFlags callBackTypes, 
                            CFSocketCallBack callout, 
                            const CFSocketContext *context)
{
    
    const char *strprotocolFamily = "UNKNOWN";
    const char *strsocketType = "UNKNOWN";
    const char *strprotocol = "UNKNOWN";

    // From <sys/socket.h>
    if (protocolFamily == 0)
    {
        strprotocolFamily = "AF_UNSPEC";
    } else if (protocolFamily == 1) {
        strprotocolFamily = "AF_UNIX";
    } else if (protocolFamily == 2) {
        strprotocolFamily = "AF_INET";
    } else if (protocolFamily == 30) {
        strprotocolFamily = "AF_INET6";
    } else if (protocolFamily == 32) {
        strprotocolFamily = "AF_SYSTEM";
    }

    // From <sys/socket.h>
    if (socketType == 1)
    {
        strsocketType = "SOCK_STREAM";
    } else if (socketType == 2) {
        strsocketType = "SOCK_DGRAM";
    } else if (socketType == 3) {
        strsocketType = "SOCK_RAW";
    } else if (socketType == 4) {
        strsocketType = "SOCK_RDM";
    } else if (socketType == 5) {
        strsocketType = "SOCK_SEQPACKET";
    }

    // From <netinet/in.h>
    if (protocol == 0)
    {
        strprotocol = "IPPROTO_IP";
    } else if (protocol == 6) {
        strprotocol = "IPPROTO_TCP";
    } else if (protocol == 17) {
        strprotocol = "IPPROTO_UDP";
    }

    DDLogVerbose(@"CFSocketCreate: %d(%s), %d(%s), %d(%s), %lu", (int)protocolFamily, strprotocolFamily, (int)socketType, strsocketType, (int)protocol, strprotocol, callBackTypes);
    return orig_CFSocketCreate(alloc, protocolFamily, socketType, protocol, callBackTypes, callout, context);
}


CFSocketRef replaced_CFSocketCreateConnectedToSocketSignature ( CFAllocatorRef allocator, 
                                                            const CFSocketSignature *signature, 
                                                            CFOptionFlags callBackTypes, 
                                                            CFSocketCallBack callout, 
                                                            const CFSocketContext *context, 
                                                            CFTimeInterval timeout ) {

    DDLogVerbose(@"CFSocketCreateConnectedToSocketSignature: callBackTypes:%lu", callBackTypes);

    return orig_CFSocketCreateConnectedToSocketSignature(allocator, signature, callBackTypes, callout, context, timeout);
};

CFSocketRef replaced_CFSocketCreateWithNative ( CFAllocatorRef allocator, 
                                            CFSocketNativeHandle sock, 
                                            CFOptionFlags callBackTypes, 
                                            CFSocketCallBack callout, 
                                            const CFSocketContext *context ) {
    DDLogVerbose(@"CFSocketCreateWithNative: callBackTypes:%lu", callBackTypes);

    return orig_CFSocketCreateWithNative(allocator, sock, callBackTypes, callout, context);
};

CFSocketRef replaced_CFSocketCreateWithSocketSignature ( CFAllocatorRef allocator, 
                                                    const CFSocketSignature *signature, 
                                                    CFOptionFlags callBackTypes, 
                                                    CFSocketCallBack callout, 
                                                    const CFSocketContext *context ) {

    DDLogVerbose(@"CFSocketCreateWithSocketSignature: callBackTypes:%lu", callBackTypes);

    return orig_CFSocketCreateWithSocketSignature(allocator, signature, callBackTypes, callout, context);
};


/*
 Configuring Sockets

 CFSocketCopyAddress - Returns the local address of a CFSocket object.
 CFSocketCopyPeerAddress
 CFSocketDisableCallBacks
 CFSocketEnableCallBacks
 CFSocketGetContext
 CFSocketGetNative
 CFSocketGetSocketFlags
 CFSocketSetAddress
 CFSocketSetSocketFlags
*/
CFDataRef (*orig_CFSocketCopyAddress) ( CFSocketRef s );
CFDataRef (*orig_CFSocketCopyPeerAddress) ( CFSocketRef s );
void (*orig_CFSocketDisableCallBacks) ( CFSocketRef s, CFOptionFlags callBackTypes );
void (*orig_CFSocketEnableCallBacks) ( CFSocketRef s, CFOptionFlags callBackTypes );
void (*orig_CFSocketGetContext) ( CFSocketRef s, CFSocketContext *context );
CFSocketNativeHandle (*orig_CFSocketGetNative) ( CFSocketRef s );
CFOptionFlags (*orig_CFSocketGetSocketFlags) ( CFSocketRef s );
CFSocketError (*orig_CFSocketSetAddress) ( CFSocketRef s, CFDataRef address );
void (*orig_CFSocketSetSocketFlags) ( CFSocketRef s, CFOptionFlags flags );

CFDataRef replaced_CFSocketCopyAddress ( CFSocketRef s )
{
    // DDLogVerbose(@"CFSocketCopyAddress called");
    return orig_CFSocketCopyAddress(s);
};

CFDataRef replaced_CFSocketCopyPeerAddress ( CFSocketRef s )
{
    // DDLogVerbose(@"CFSocketCopyPeerAddress called");
    return orig_CFSocketCopyPeerAddress(s);
};

void replaced_CFSocketDisableCallBacks ( CFSocketRef s, CFOptionFlags callBackTypes )
{
    // DDLogVerbose(@"CFSocketDisableCallBacks - callBackTypes:%d", callBackTypes);
};

void replaced_CFSocketEnableCallBacks ( CFSocketRef s, CFOptionFlags callBackTypes )
{
    // DDLogVerbose(@"CFSocketEnableCallBacks - callBackTypes:%d", callBackTypes);
};

void replaced_CFSocketGetContext ( CFSocketRef s, CFSocketContext *context )
{
    // DDLogVerbose(@"CFSocketGetContext called");
};

CFSocketNativeHandle replaced_CFSocketGetNative ( CFSocketRef s )
{
    // DDLogVerbose(@"CFSocketGetNative called");
    return orig_CFSocketGetNative(s);
};

CFOptionFlags replaced_CFSocketGetSocketFlags ( CFSocketRef s )
{
    // DDLogVerbose(@"CFSocketGetSocketFlags called");
    return orig_CFSocketGetSocketFlags(s);
};

CFSocketError replaced_CFSocketSetAddress ( CFSocketRef s, CFDataRef address )
{
    // DDLogVerbose(@"CFSocketSetAddress called");
    return orig_CFSocketSetAddress(s, address);
};

void replaced_CFSocketSetSocketFlags ( CFSocketRef s, CFOptionFlags flags )
{
    // DDLogVerbose(@"CFSocketSetSocketFlags - flags:%@", flags);
};




/*
 Using Sockets

 CFSocketConnectToAddress
 CFSocketCreateRunLoopSource
 CFSocketGetTypeID
 CFSocketInvalidate
 CFSocketIsValid
 CFSocketSendData
*/

CFSocketError (*orig_CFSocketConnectToAddress) (CFSocketRef s, CFDataRef address, CFTimeInterval timeout);
CFSocketError (*orig_CFSocketSendData) (CFSocketRef s, CFDataRef address, CFDataRef data, CFTimeInterval timeout);

CFSocketError replaced_CFSocketConnectToAddress(CFSocketRef s, CFDataRef address, CFTimeInterval timeout) {
    // NSString *addressString;
    // int port=0;
    // struct sockaddr *addressGeneric;

    // NSData *myData = (__bridge NSData *)address;
    // addressGeneric = (struct sockaddr *) [myData bytes];

    // switch( addressGeneric->sa_family ) {
    //     case AF_INET: {
    //       struct sockaddr_in *ip4;
    //       char dest[INET_ADDRSTRLEN];
    //       ip4 = (struct sockaddr_in *) [myData bytes];
    //       port = ntohs(ip4->sin_port);
    //       addressString = [NSString stringWithFormat: @"[BFG] CFSocketConnectToAddress IP4: %s Port: %d", inet_ntop(AF_INET, &ip4->sin_addr, dest, sizeof dest),port];
    //      }
    //      break;

    //     case AF_INET6: {
    //         struct sockaddr_in6 *ip6;
    //         char dest[INET6_ADDRSTRLEN];
    //         ip6 = (struct sockaddr_in6 *) [myData bytes];
    //         port = ntohs(ip6->sin6_port);
    //         addressString = [NSString stringWithFormat: @"[BFG] CFSocketConnectToAddress IP6: %s Port: %d",  inet_ntop(AF_INET6, &ip6->sin6_addr, dest, sizeof dest),port];
    //      }
    //      break;
    //    default:
    //      addressString=@"Error on get family type.";
    //      break;
    // }

    // ispy_log_info(LOG_TCPIP, [addressString UTF8String]);

    return orig_CFSocketConnectToAddress(s, address, timeout);
}



CFSocketError replaced_CFSocketSendData(CFSocketRef s, CFDataRef address, CFDataRef data, CFTimeInterval timeout) {


    NSLog(@"[BFG] CFSocketSendData: %@", data);
    // DDLogVerbose(@"bf_CFSocketSendData: %s", data);
    return orig_CFSocketSendData(s, address, data, timeout);
}









#define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookCoreFoundation_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic(funcname) MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname)


void CFSocket_function_hooks()
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

    InstallHook(CFSocketCreate);
    InstallHook(CFSocketCreateConnectedToSocketSignature);
    InstallHook(CFSocketCreateWithNative);
    InstallHook(CFSocketCreateWithSocketSignature);

    InstallHook(CFSocketCopyAddress);
    InstallHook(CFSocketCopyPeerAddress);
    InstallHook(CFSocketDisableCallBacks);
    InstallHook(CFSocketEnableCallBacks);
    InstallHook(CFSocketGetContext);
    InstallHook(CFSocketGetNative);
    InstallHook(CFSocketGetSocketFlags);
    InstallHook(CFSocketSetAddress);
    InstallHook(CFSocketSetSocketFlags);

    InstallHook(CFSocketConnectToAddress);
    InstallHook(CFSocketSendData);
}// CFSocket_function_hooks()

