/*
 File Description:
  
	**********************
	** Secure Transport **
	**********************

	https://developer.apple.com/library/ios/documentation/Security/Conceptual/cryptoservices/SecureNetworkCommunicationAPIs/SecureNetworkCommunicationAPIs.html

	Secure Transport is a low-level API for working with SSL and TLS. 
	With Secure Transport, your code must set up the network connection and provide callback functions 
	that Secure Transport calls to perform I/O operations over the network.

	Secure Transport is used in both OS X and iOS. 
	The CFNetwork and URL Loading System APIs are built on top of Secure Transport.

*/
#include "../../swizzler.common.h"
#import <Security/SecureTransport.h>

/*
	Configuring an SSL Session

	SSLSetConnection - Specifies an option for a specific session.
	SSLGetConnection
	SSLSetSessionOption
	SSLGetSessionOption
	SSLSetIOFuncs
	SSLSetClientSideAuthenticate
*/
OSStatus (*orig_SSLSetSessionOption) (SSLContextRef context, SSLSessionOption option, Boolean value);

OSStatus replaced_SSLSetSessionOption (SSLContextRef context, SSLSessionOption option, Boolean value)
{
    // Remove the ability to modify the value of the kSSLSessionOptionBreakOnServerAuth option
    if (option == kSSLSessionOptionBreakOnServerAuth)
        return noErr;
    else
        return orig_SSLSetSessionOption(context, option, value);
}



/*
	Managing an SSL Session

	SSLHandshake - Performs the SSL handshake. 
	SSLGetSessionState
	SSLGetNegotiatedProtocolVersion
	SSLSetPeerID
	SSLGetPeerID
	SSLGetBufferedReadSize
	SSLRead
	SSLWrite
	SSLClose
*/
OSStatus (*orig_SSLHandshake) (SSLContextRef context);

OSStatus replaced_SSLHandshake (SSLContextRef context)
{
    OSStatus result = orig_SSLHandshake(context);

    // Hijack the flow when breaking on server authentication
    if (result == errSSLServerAuthCompleted)
    {
        // Do not check the cert and call SSLHandshake() again
        return orig_SSLHandshake(context);
    }
    else
        return result;
}



/*
	iOS-Specific SSL Context Functions

    SSLContextGetTypeID
    SSLCreateContext - Allocates and returns a new SSLContextRef object.
    SSLGetDatagramWriteSize
    SSLGetMaxDatagramRecordSize
    SSLGetProtocolVersionMax
    SSLGetProtocolVersionMin
    SSLSetDatagramHelloCookie
    SSLSetMaxDatagramRecordSize
    SSLSetProtocolVersionMax
    SSLSetProtocolVersionMin
*/
SSLContextRef (*orig_SSLCreateContext) (CFAllocatorRef alloc, SSLProtocolSide protocolSide, SSLConnectionType connectionType);

SSLContextRef replaced_SSLCreateContext (CFAllocatorRef alloc, SSLProtocolSide protocolSide, SSLConnectionType connectionType)
{
    SSLContextRef sslContext = orig_SSLCreateContext(alloc, protocolSide, connectionType);
    
    // Immediately set the kSSLSessionOptionBreakOnServerAuth option in order to disable cert validation
    orig_SSLSetSessionOption(sslContext, kSSLSessionOptionBreakOnServerAuth, true);
    return sslContext;
}

















// #define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookCFunctions2_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic(funcname) MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname)
// #define InstallHook_FindSymbol(funcname) if ([[plist objectForKey:@"settings_HookCFunctions2_"#funcname] boolValue]) { MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname); }

void SecureTransport_hooks()
{
	// NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

	if (disableSSLPinning())
    {
    	InstallHook_basic(SSLHandshake);
    	InstallHook_basic(SSLSetSessionOption);
    	InstallHook_basic(SSLCreateContext);
    }
}


















