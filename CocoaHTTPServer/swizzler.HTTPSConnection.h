/*
 Credits:
 	Thanks to Robbie Hanson for coming up with such a fantastic piece of software!
 	https://github.com/robbiehanson/CocoaHTTPServer

 File Description:
  
	****************************
	** Swizzler HTTP Connection **
	****************************
	
	This class overrides/extends the methods as defined in the original HTTPConnection class to give us our HTTP Server.
	Much of the original code is lifted from the basic PostHTTPServer sample (https://github.com/robbiehanson/CocoaHTTPServer/tree/master/Samples/PostHTTPServer)
*/

// #import <Cocoa/Cocoa.h>
#import "HTTPConnection.h"


@interface swizzlerHTTPSConnection : HTTPConnection

@end