/*
 File Description:
  
    *****************************
    ** Core Foundation String  **
    *****************************

    Core Foundation (also called CF) is a C application programming interface (API) in Mac OS X & iOS, and is a mix of low-level routines 
    and wrapper functions. Apple releases most of it as an open source project called CFLite that can be used to write cross-platform 
    applications for Mac OS X, Linux, and Windows;[1] a third-party open-source implementation called OpenCFLite also exists.
    Most Core Foundation routines follow a certain naming convention that deal with opaque objects, for example CFDictionaryRef for 
    functions whose names begin with CFDictionary, and these objects are often reference counted (manually) through CFRetain and CFRelease. 
    Internally, Core Foundation forms the base of the types in the Objective-C runtime as well.

*/
#import "../../swizzler.common.h"




/*
 Creating a CFString

 CFSTR
 CFStringCreateArrayBySeparatingStrings
 CFStringCreateByCombiningStrings
 CFStringCreateCopy
 CFStringCreateFromExternalRepresentation
 CFStringCreateWithBytes
 CFStringCreateWithBytesNoCopy
 CFStringCreateWithCharacters
 CFStringCreateWithCharactersNoCopy
 CFStringCreateWithCString
 CFStringCreateWithCStringNoCopy
 CFStringCreateWithFormat
 CFStringCreateWithFormatAndArguments
 CFStringCreateWithPascalString
 CFStringCreateWithPascalStringNoCopy
 CFStringCreateWithSubstring
*/
// CFStringRef CFSTR ( const char *cStr );
CFArrayRef CFStringCreateArrayBySeparatingStrings ( CFAllocatorRef alloc, CFStringRef theString, CFStringRef separatorString );
CFStringRef CFStringCreateByCombiningStrings ( CFAllocatorRef alloc, CFArrayRef theArray, CFStringRef separatorString );
CFStringRef CFStringCreateCopy ( CFAllocatorRef alloc, CFStringRef theString );
CFStringRef CFStringCreateFromExternalRepresentation ( CFAllocatorRef alloc, CFDataRef data, CFStringEncoding encoding );
CFStringRef CFStringCreateWithBytes ( CFAllocatorRef alloc, const UInt8 *bytes, CFIndex numBytes, CFStringEncoding encoding, Boolean isExternalRepresentation );
CFStringRef CFStringCreateWithBytesNoCopy ( CFAllocatorRef alloc, const UInt8 *bytes, CFIndex numBytes, CFStringEncoding encoding, Boolean isExternalRepresentation, CFAllocatorRef contentsDeallocator );
CFStringRef CFStringCreateWithCharacters ( CFAllocatorRef alloc, const UniChar *chars, CFIndex numChars );
CFStringRef CFStringCreateWithCharactersNoCopy ( CFAllocatorRef alloc, const UniChar *chars, CFIndex numChars, CFAllocatorRef contentsDeallocator );
CFStringRef CFStringCreateWithCString ( CFAllocatorRef alloc, const char *cStr, CFStringEncoding encoding );
CFStringRef CFStringCreateWithCStringNoCopy ( CFAllocatorRef alloc, const char *cStr, CFStringEncoding encoding, CFAllocatorRef contentsDeallocator );
CFStringRef CFStringCreateWithFormat ( CFAllocatorRef alloc, CFDictionaryRef formatOptions, CFStringRef format, ... );
CFStringRef CFStringCreateWithFormatAndArguments ( CFAllocatorRef alloc, CFDictionaryRef formatOptions, CFStringRef format, va_list arguments );
CFStringRef CFStringCreateWithPascalString ( CFAllocatorRef alloc, ConstStr255Param pStr, CFStringEncoding encoding );
CFStringRef CFStringCreateWithPascalStringNoCopy ( CFAllocatorRef alloc, ConstStr255Param pStr, CFStringEncoding encoding, CFAllocatorRef contentsDeallocator );
CFStringRef CFStringCreateWithSubstring ( CFAllocatorRef alloc, CFStringRef str, CFRange range );











/*
 Searching Strings

 CFStringCreateArrayWithFindResults
 CFStringFind
 CFStringFindCharacterFromSet
 CFStringFindWithOptions
 CFStringFindWithOptionsAndLocale
 CFStringGetLineBounds
*/
CFArrayRef (*orig_CFStringCreateArrayWithFindResults) ( CFAllocatorRef alloc, CFStringRef theString, CFStringRef stringToFind, CFRange rangeToSearch, CFStringCompareFlags compareOptions );
CFRange (*orig_CFStringFind) ( CFStringRef theString, CFStringRef stringToFind, CFStringCompareFlags compareOptions );
Boolean (*orig_CFStringFindCharacterFromSet) ( CFStringRef theString, CFCharacterSetRef theSet, CFRange rangeToSearch, CFStringCompareFlags searchOptions, CFRange *result );
Boolean (*orig_CFStringFindWithOptions) ( CFStringRef theString, CFStringRef stringToFind, CFRange rangeToSearch, CFStringCompareFlags searchOptions, CFRange *result );
Boolean (*orig_CFStringFindWithOptionsAndLocale) ( CFStringRef theString, CFStringRef stringToFind, CFRange rangeToSearch, CFStringCompareFlags searchOptions, CFLocaleRef locale, CFRange *result );
void (*orig_CFStringGetLineBounds) ( CFStringRef theString, CFRange range, CFIndex *lineBeginIndex, CFIndex *lineEndIndex, CFIndex *contentsEndIndex );

CFArrayRef replaced_CFStringCreateArrayWithFindResults ( CFAllocatorRef alloc, CFStringRef theString, CFStringRef stringToFind, CFRange rangeToSearch, CFStringCompareFlags compareOptions )
{
	NSLog(@"CFStringCreateArrayWithFindResults");
	CFArrayRef ret = orig_CFStringCreateArrayWithFindResults(alloc, theString, stringToFind, rangeToSearch, compareOptions);
	return ret;
}
CFRange replaced_CFStringFind ( CFStringRef theString, CFStringRef stringToFind, CFStringCompareFlags compareOptions )
{
	NSLog(@"CFStringFind");
	NSLog(@"CFStringFind: %@, %@, %lu", theString, stringToFind, compareOptions);
	CFRange ret = orig_CFStringFind(theString, stringToFind, compareOptions);
	return ret;
}
Boolean replaced_CFStringFindCharacterFromSet ( CFStringRef theString, CFCharacterSetRef theSet, CFRange rangeToSearch, CFStringCompareFlags searchOptions, CFRange *result )
{
	NSLog(@"CFStringFindCharacterFromSet");
	Boolean ret = orig_CFStringFindCharacterFromSet(theString, theSet, rangeToSearch, searchOptions, result);
	return ret;
}
Boolean replaced_CFStringFindWithOptions ( CFStringRef theString, CFStringRef stringToFind, CFRange rangeToSearch, CFStringCompareFlags searchOptions, CFRange *result )
{
	NSLog(@"CFStringFindWithOptions");
	Boolean ret = orig_CFStringFindWithOptions(theString, stringToFind, rangeToSearch, searchOptions, result);
	return ret;
}
Boolean replaced_CFStringFindWithOptionsAndLocale ( CFStringRef theString, CFStringRef stringToFind, CFRange rangeToSearch, CFStringCompareFlags searchOptions, CFLocaleRef locale, CFRange *result )
{
	NSLog(@"CFStringFindWithOptionsAndLocale");
	Boolean ret = orig_CFStringFindWithOptionsAndLocale(theString, stringToFind, rangeToSearch, searchOptions, locale, result);
	return ret;
}
void replaced_CFStringGetLineBounds ( CFStringRef theString, CFRange range, CFIndex *lineBeginIndex, CFIndex *lineEndIndex, CFIndex *contentsEndIndex )
{
	CFStringGetLineBounds(theString, range, lineBeginIndex, lineEndIndex, contentsEndIndex);
}





/*
 Comparing Strings

 CFStringCompare
 CFStringCompareWithOptions
 CFStringCompareWithOptionsAndLocale
 CFStringHasPrefix
 CFStringHasSuffix
*/
CFComparisonResult CFStringCompare ( CFStringRef theString1, CFStringRef theString2, CFStringCompareFlags compareOptions );
CFComparisonResult CFStringCompareWithOptions ( CFStringRef theString1, CFStringRef theString2, CFRange rangeToCompare, CFStringCompareFlags compareOptions );
CFComparisonResult CFStringCompareWithOptionsAndLocale ( CFStringRef theString1, CFStringRef theString2, CFRange rangeToCompare, CFStringCompareFlags compareOptions, CFLocaleRef locale );
Boolean CFStringHasPrefix ( CFStringRef theString, CFStringRef prefix );
Boolean CFStringHasSuffix ( CFStringRef theString, CFStringRef suffix );






/*
 Accessing Characters

 CFStringCreateExternalRepresentation
 CFStringGetBytes
 CFStringGetCharacterAtIndex
 CFStringGetCharacters
 CFStringGetCharactersPtr
 CFStringGetCharacterFromInlineBuffer
 CFStringGetCString
 CFStringGetCStringPtr
 CFStringGetLength
 CFStringGetPascalString
 CFStringGetPascalStringPtr
 CFStringGetRangeOfComposedCharactersAtIndex
 CFStringInitInlineBuffer
*/


/*
 Working With Hyphenation

 CFStringGetHyphenationLocationBeforeIndex
 CFStringIsHyphenationAvailableForLocale
*/





/*
 Working With Encodings

 CFStringConvertEncodingToIANACharSetName
 CFStringConvertEncodingToNSStringEncoding
 CFStringConvertEncodingToWindowsCodepage
 CFStringConvertIANACharSetNameToEncoding
 CFStringConvertNSStringEncodingToEncoding
 CFStringConvertWindowsCodepageToEncoding
 CFStringGetFastestEncoding
 CFStringGetListOfAvailableEncodings
 CFStringGetMaximumSizeForEncoding
 CFStringGetMostCompatibleMacStringEncoding
 CFStringGetNameOfEncoding
 CFStringGetSmallestEncoding
 CFStringGetSystemEncoding
 CFStringIsEncodingAvailable
*/





/*
 Getting Numeric Values

 CFStringGetDoubleValue
 CFStringGetIntValue
*/



/*
 Getting String Properties

 CFShowStr
 CFStringGetTypeID
*/
void CFShowStr ( CFStringRef str );
CFTypeID CFStringGetTypeID ( void );


/*
 String File System Representations

 CFStringCreateWithFileSystemRepresentation
 CFStringGetFileSystemRepresentation
 CFStringGetMaximumSizeOfFileSystemRepresentation
*/



/*
 Getting Paragraph Bounds

 CFStringGetParagraphBounds
*/



/*
 Managing Surrogates

 CFStringGetLongCharacterForSurrogatePair
 CFStringGetSurrogatePairForLongCharacter
 CFStringIsSurrogateHighCharacter
 CFStringIsSurrogateLowCharacter
*/



#define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookCoreFoundation_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic(funcname) MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname)


void CFString_function_hooks()
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

	InstallHook(CFStringCreateArrayWithFindResults);
	InstallHook(CFStringFind);
	InstallHook(CFStringFindCharacterFromSet);
	InstallHook(CFStringFindWithOptions);
	InstallHook(CFStringFindWithOptionsAndLocale);
	InstallHook(CFStringGetLineBounds);
}






