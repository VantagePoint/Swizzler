/*
 File Description:
  
	************************
	** Foundation NSData  **
	************************

	NSData and its mutable subclass NSMutableData provide data objects, object-oriented wrappers for byte buffers. 
	Data objects let simple allocated buffers (that is, data with no embedded pointers) take on the behavior of 
	Foundation objects.

	NSData creates static data objects, and NSMutableData creates dynamic data objects. NSData and NSMutableData 
	are typically used for data storage and are also useful in Distributed Objects applications, where data 
	contained in data objects can be copied or moved between applications.

	The size of the data is subject to a theoretical limit of about 8 ExaBytes (in practice, the limit should 
	not be a factor).

	NSData is “toll-free bridged” with its Core Foundation counterpart, CFDataRef. See Toll-Free Bridging for 
	more information on toll-free bridging.
*/
#import "../../swizzler.common.h"
%group NSData
%hook NSData

/*
Creating Data Objects

 + data
 + dataWithBytes:length:
 + dataWithBytesNoCopy:length:
 + dataWithBytesNoCopy:length:freeWhenDone:
 + dataWithContentsOfFile:
 + dataWithContentsOfFile:options:error:
 + dataWithContentsOfURL:
 + dataWithContentsOfURL:options:error:
 + dataWithData:
 - initWithBase64EncodedData:options:
 - initWithBase64EncodedString:options:
 - initWithBytes:length:
 - initWithBytesNoCopy:length:
 - initWithBytesNoCopy:length:deallocator:
 - initWithBytesNoCopy:length:freeWhenDone:
 - initWithContentsOfFile:
 - initWithContentsOfFile:options:error:
 - initWithContentsOfURL:
 - initWithContentsOfURL:options:error:
 - initWithData:

*/
// + (id)dataWithBytes:(const void *)bytes
+ (id)dataWithBytes:(unsigned char *)bytes
             length:(NSUInteger)length
{
	NSMutableString *data = [NSMutableString string];
	for (int i=0; i<length; i++)
		[data appendFormat:@"%02x", bytes[i]];

	DDLogVerbose(@"NSData dataWithBytes: %@, length: %lu", data, (unsigned long)length);
	return %orig;
}

// + (id)dataWithBytesNoCopy:(void *)bytes
+ (id)dataWithBytesNoCopy:(unsigned char *)bytes
                   length:(NSUInteger)length
{
	NSMutableString *data = [NSMutableString string];
	for (int i=0; i<length; i++)
		[data appendFormat:@"%02x", bytes[i]];

	DDLogVerbose(@"NSData dataWithBytesNoCopy: %@, length: %lu", data, (unsigned long)length);
	return %orig;
}

// + (id)dataWithBytesNoCopy:(void *)bytes
+ (id)dataWithBytesNoCopy:(unsigned char *)bytes
                   length:(NSUInteger)length
             freeWhenDone:(BOOL)freeWhenDone
{
	NSMutableString *data = [NSMutableString string];
	for (int i=0; i<length; i++)
		[data appendFormat:@"%02x", bytes[i]];

	DDLogVerbose(@"NSData dataWithBytesNoCopy: %@, length: %lu, freeWhenDone: %d", data, (unsigned long)length, freeWhenDone);
	return %orig;
}

+ (id)dataWithContentsOfFile:(NSString *)path
{
	DDLogVerbose(@"NSData dataWithContentsOfFile: %@", path);
	return %orig;
}

+ (id)dataWithContentsOfFile:(NSString *)path
                     options:(NSDataReadingOptions)mask
                       error:(NSError *)errorPtr
{
	DDLogVerbose(@"NSData dataWithContentsOfFile: %@", path);
	return %orig;
}

+ (id)dataWithContentsOfURL:(NSURL *)aURL
{
	DDLogVerbose(@"NSData dataWithContentsOfURL: %@", aURL);
	return %orig;
}

// + (id)dataWithContentsOfURL:(NSURL *)aURL
//                     options:(NSDataReadingOptions)mask
//                       error:(NSError * nullable * nullable)errorPtr
// {

// }
/*
Accessing Data

 - enumerateByteRangesUsingBlock:
 - getBytes:length:
 - getBytes:range:
 - subdataWithRange:
 - rangeOfData:options:range:
*/



/*
Base-64 Encoding

 - base64EncodedDataWithOptions:
 - base64EncodedStringWithOptions:
*/

/*
Testing Data

 - isEqualToData:
*/

/*
Storing Data

 - writeToFile:atomically:
 - writeToFile:options:error:
 - writeToURL:atomically:
 - writeToURL:options:error:
*/
- (BOOL)writeToFile:(NSString *)path
         atomically:(BOOL)atomically
{
	DDLogVerbose(@"NSData writeToFile: %@, atomically: %d", path, atomically);
	BOOL ret = %orig;
	return ret;
}








%end
%end
