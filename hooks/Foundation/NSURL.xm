/*
 File Description:
  
	***********************
	** Foundation NSURL  **
	***********************

	An NSURL object represents a URL that can potentially contain the location of a resource on a remote server, 
	the path of a local file on disk, or even an arbitrary piece of encoded data.

*/
#import "../../swizzler.common.h"
%group NSURL
%hook NSURL

/*
 Creating an NSURL Object

 - initWithScheme:host:path:
 + URLWithString:
 - initWithString:
 + URLWithString:relativeToURL:
 - initWithString:relativeToURL:
 + fileURLWithPath:isDirectory:
 - initFileURLWithPath:isDirectory:
 + fileURLWithPath:
 - initFileURLWithPath:
 + fileURLWithPathComponents:
 + URLByResolvingAliasFileAtURL:options:error:
 + URLByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:
 - initByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:
 + fileURLWithFileSystemRepresentation:isDirectory:relativeToURL:
 - getFileSystemRepresentation:maxLength:
 - initFileURLWithFileSystemRepresentation:isDirectory:relativeToURL:
*/
+ (id)URLWithString:(NSString *)URLString
{
	NSRange range = [URLString rangeOfString:@"cydia" options:NSRegularExpressionSearch|NSCaseInsensitiveSearch];
	if (range.location != NSNotFound)
	{
		NSLog(@"Jailbreak detection NSURL URLWithString: %@", URLString);
		return nil;
	}
	NSLog(@"NSURL URLWithString: %@", URLString);
	id ret = %orig;
	return ret;
}

%end
%end



// @class NSURL; 



// static id (*_logos_meta_orig$NSURL$NSURL$URLWithString$)(Class, SEL, NSString *);


// static id _logos_meta_method$NSURL$NSURL$URLWithString$(Class self, SEL _cmd, NSString * URLString) {
// 	NSRange range = [URLString rangeOfString:@"cydia" options:NSRegularExpressionSearch|NSCaseInsensitiveSearch];
// 	if (range.location != NSNotFound)
// 	{
// 		NSLog(@"Jailbreak detection NSURL URLWithString: %@", URLString);
// 		return nil;
// 	}
// 	NSLog(@"NSURL URLWithString: %@", URLString);
// 	id ret = _logos_meta_orig$NSURL$NSURL$URLWithString$(self, _cmd, URLString);
// 	return ret;
// }

