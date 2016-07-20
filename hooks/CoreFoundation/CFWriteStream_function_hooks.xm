/*
 File Description:
  
    ***********************************
    ** Core Foundation Write Stream  **
    ***********************************

    Core Foundation (also called CF) is a C application programming interface (API) in Mac OS X & iOS, and is a mix of low-level routines 
    and wrapper functions. Apple releases most of it as an open source project called CFLite that can be used to write cross-platform 
    applications for Mac OS X, Linux, and Windows;[1] a third-party open-source implementation called OpenCFLite also exists.
    Most Core Foundation routines follow a certain naming convention that deal with opaque objects, for example CFDictionaryRef for 
    functions whose names begin with CFDictionary, and these objects are often reference counted (manually) through CFRetain and CFRelease. 
    Internally, Core Foundation forms the base of the types in the Objective-C runtime as well.

*/
#import "../../swizzler.common.h"


/*
 Creating a Write Stream

 CFWriteStreamCreateWithAllocatedBuffers
 CFWriteStreamCreateWithBuffer
 CFWriteStreamCreateWithFile
*/


/*
 Writing to a Stream

 CFWriteStreamWrite
*/
CFIndex (*orig_CFWriteStreamWrite)(CFWriteStreamRef stream, const UInt8 *buffer, CFIndex bufferLength);

CFIndex replaced_CFWriteStreamWrite(CFWriteStreamRef stream, const UInt8 *buffer, CFIndex bufferLength)
{
    
    CFIndex retval;

    NSData *data = [[NSData alloc] initWithBytes:buffer length: bufferLength]; 

    NSPropertyListFormat format;
    NSString * str = [NSString stringWithFormat:@"%@", [NSPropertyListSerialization
                                      propertyListFromData:data
                                      mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                      format:&format
                                      errorDescription:nil]];

    // NSLog(@"%@", str);

    // NSMutableString *hex = [NSMutableString string];
    // for (int i=0; i<bufferLength; i++)
    //     [hex appendFormat:@"%02x", buffer[i]];
    // NSLog(@"%@", hex);
    NSLog(@"CFWriteStreamWrite: %@", str);
    // ispy_log_info(LOG_TCPIP, [str UTF8String]);

    // call original
    retval = orig_CFWriteStreamWrite(stream, buffer, bufferLength);

    return retval;
}


/*
 Opening and Closing a Stream

 CFWriteStreamClose
 CFWriteStreamOpen
*/
// Boolean (*orig_CFWriteStreamOpen)(CFWriteStreamRef stream);

// Boolean replaced_CFWriteStreamOpen(CFWriteStreamRef stream) {
//     ispy_log_info(LOG_TCPIP, "CFWriteStreamOpen: %@", stream);
//     return orig_CFWriteStreamOpen(stream);
// }

/*
 Scheduling a Write Stream
 CFWriteStreamScheduleWithRunLoop
 CFWriteStreamUnscheduleFromRunLoop
*/
 
/*
 Examining Stream Properties
 CFWriteStreamCanAcceptBytes
 CFWriteStreamCopyProperty
 CFWriteStreamCopyError
 CFWriteStreamGetError
 CFWriteStreamGetStatus
*/
 
/*
 Setting Stream Properties
 CFWriteStreamSetClient
 CFWriteStreamSetProperty
*/
// Boolean (*orig_CFWriteStreamSetProperty)(CFWriteStreamRef stream, CFStringRef propertyName, CFTypeRef propertyValue);



/*
 Getting the CFWriteStream Type ID
 CFWriteStreamGetTypeID
*/
 






#define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookCoreFoundation_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic(funcname) MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname)

void CFWriteStream_function_hooks()
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

    InstallHook(CFWriteStreamWrite);


}// CFWriteStream_function_hooks()

