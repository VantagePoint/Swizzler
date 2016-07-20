/*
 File Description:
  
	***************************
	** Core Foundation Data  **
	***************************

	Core Foundation (also called CF) is a C application programming interface (API) in Mac OS X & iOS, and is a mix of low-level routines 
	and wrapper functions. Apple releases most of it as an open source project called CFLite that can be used to write cross-platform 
	applications for Mac OS X, Linux, and Windows;[1] a third-party open-source implementation called OpenCFLite also exists.
	Most Core Foundation routines follow a certain naming convention that deal with opaque objects, for example CFDictionaryRef for 
	functions whose names begin with CFDictionary, and these objects are often reference counted (manually) through CFRetain and CFRelease. 
	Internally, Core Foundation forms the base of the types in the Objective-C runtime as well.

*/
#import "../../swizzler.common.h"



/*
 Creating a CFData Object

 CFDataCreate - Creates an immutable CFData object using data copied from a specified byte buffer.
 CFDataCreateCopy -  Creates an immutable copy of a CFData object.
 CFDataCreateWithBytesNoCopy - Creates an immutable CFData object from an external (client-owned) byte buffer.
*/
CFDataRef (*orig_CFDataCreate) ( CFAllocatorRef allocator, const UInt8 *bytes, CFIndex length );

CFDataRef replaced_CFDataCreate ( CFAllocatorRef allocator, const UInt8 *bytes, CFIndex length )
{
	DDLogVerbose(@"CFDataCreate");
	CFDataRef ret = orig_CFDataCreate(allocator, bytes, length);
	return ret;
}

// CFDataRef CFDataCreateCopy ( CFAllocatorRef allocator, CFDataRef theData ); 
// CFDataRef CFDataCreateWithBytesNoCopy ( CFAllocatorRef allocator, const UInt8 *bytes, CFIndex length, CFAllocatorRef bytesDeallocator ); 


/*
 Examining a CFData Object

 CFDataGetBytePtr - Returns a read-only pointer to the bytes of a CFData object.
 CFDataGetBytes - Copies the byte contents of a CFData object to an external buffer.
 CFDataGetLength - Returns the number of bytes contained by a CFData object.
 CFDataFind - Finds and returns the range within a data object of the first occurrence of the given data, within a given range, subject to any given options.
*/
// const UInt8 * CFDataGetBytePtr ( CFDataRef theData ); 
// void CFDataGetBytes ( CFDataRef theData, CFRange range, UInt8 *buffer ); 
// CFIndex CFDataGetLength ( CFDataRef theData ); 
// CFRange CFDataFind ( CFDataRef theData, CFDataRef dataToFind, CFRange searchRange, CFDataSearchFlags compareOptions ); 




/*
 Getting the CFData Type ID

 CFDataGetTypeID - Returns the type identifier for the CFData opaque type. 
*/
// CFTypeID CFDataGetTypeID ( void ); 





#define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookCoreFoundation_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic(funcname) MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname)

void CFData_function_hooks()
{
	NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];
	
	InstallHook(CFDataCreate);

}