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
#import "../swizzler.common.h"

#import "swizzler.HTTPConnection.h"
#import "HTTPMessage.h"
#import "Responses/HTTPDataResponse.h"
#import "Categories/DDNumber.h"
// #import "CocoaHTTPServer/HTTPLogging.h"
#import "../hooks/GoodDynamics/GD.framework/Headers/GDNETiOS.h"

/**
 * All we have to do is override appropriate methods in HTTPConnection.
**/

@implementation swizzlerHTTPConnection

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{	
	// Add support for POST
	
	if ([method isEqualToString:@"POST"])
	{
		// if ([path isEqualToString:@"/post.html"])
		// {
			// Let's be extra cautious, and make sure the upload isn't 5 gigs
			
			return requestContentLength < 5000;
		// }
	}
	
	return [super supportsMethod:method atPath:path];
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path
{	
	// Inform HTTP server that we expect a body to accompany a POST request
	if([method isEqualToString:@"POST"])
	{
		return YES;
	}
	
	return [super expectsRequestBodyFromMethod:method atPath:path];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{	
	if ([method isEqualToString:@"POST"])
	{
		NSString *url = [[request url] absoluteString];
		DDLogVerbose(@"CocoaHTTPServer received POST request to: %@", url);

		NSMutableURLRequest *newReq = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
		[newReq setHTTPMethod:@"POST"];

		NSDictionary *allHeaders = [request allHeaderFields];

		for (NSString *header in allHeaders)
		{
			[newReq setValue:allHeaders[header] forHTTPHeaderField:header];
			// NSLog(@"CocoaHTTPServer setting headers to: %@ %@", allHeaders[header], header);
		 }

		// Get X-Good-GD-AuthToken
		// NSString *gdAuthToken = [request headerField:@"X-Good-GD-AuthToken"];

		// Get X-Good-GD-UserID
		// NSString *gdUserID = [request headerField:@"X-Good-GD-UserID"];

		// Get SOAPAction
		// NSString *SOAPAction = [request headerField:@"SOAPAction"];

		// Get Content-Type
		// NSString *contentType = [request headerField:@"Content-Type"];
		
		NSData *postData = [request body];

		
		// NSMutableURLRequest *newReq = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
		// [newReq setHTTPMethod:@"POST"];
		// [newReq setValue:gdAuthToken forHTTPHeaderField:@"X-Good-GD-AuthToken"];
		// [newReq setValue:gdUserID forHTTPHeaderField:@"X-Good-GD-UserID"];
		// [newReq setValue:SOAPAction forHTTPHeaderField:@"SOAPAction"];
		// [newReq setValue:contentType forHTTPHeaderField:@"Content-Type"];
		
		NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
		[newReq setValue:postLength forHTTPHeaderField:@"Content-Length"];

		[newReq setHTTPBody:postData];

		NSURLResponse *resp = nil;
		NSError *error = nil;

		NSData *conn = [NSURLConnection sendSynchronousRequest:newReq
		                                     returningResponse:&resp
		                                                 error:&error];

		return [[HTTPDataResponse alloc] initWithData:conn];

	} else if ([method isEqualToString:@"GET"]) {

		NSString *url = [[request url] absoluteString];
		DDLogVerbose(@"CocoaHTTPServer received GET request to: %@", url);

		NSMutableURLRequest *newReq = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
		[newReq setHTTPMethod:@"GET"];

		NSDictionary *allHeaders = [request allHeaderFields];

		for (NSString *header in allHeaders)
		{
			[newReq setValue:allHeaders[header] forHTTPHeaderField:header];
			// NSLog(@"CocoaHTTPServer setting headers to: %@ %@", allHeaders[header], header);
		}

		NSURLResponse *resp = nil;
		NSError *error = nil;

		NSData *conn = [NSURLConnection sendSynchronousRequest:newReq
		                                     returningResponse:&resp
		                                                 error:&error];

		return [[HTTPDataResponse alloc] initWithData:conn];
	}
	
	return [super httpResponseForMethod:method URI:path];
}

- (void)prepareForBodyWithSize:(UInt64)contentLength
{
	// If we supported large uploads,
	// we might use this method to create/open files, allocate memory, etc.
}

- (void)processBodyData:(NSData *)postDataChunk
{
	// Remember: In order to support LARGE POST uploads, the data is read in chunks.
	// This prevents a 50 MB upload from being stored in RAM.
	// The size of the chunks are limited by the POST_CHUNKSIZE definition.
	// Therefore, this method may be called multiple times for the same POST request.
	
	[request appendData:postDataChunk];
	// if (!result)
	// {
	// 	HTTPLogError(@"%@[%p]: %@ - Couldn't append bytes!", THIS_FILE, self, THIS_METHOD);
	// }
}





@end