/*
 File Description:
  
	******************************
	** Foundation NSURLRequest  **
	******************************


*/
%group NSURLRequest
%hook NSURLRequest

/*
 Creating Requests

 + requestWithURL:
 - initWithURL:
 + requestWithURL:cachePolicy:timeoutInterval:
 - initWithURL:cachePolicy:timeoutInterval:
*/
- (id)initWithURL:(NSURL *)theURL
{
	NSLog(@"NSURLRequest initWithURL: %@", theURL);
	id ret = %orig;
	return ret;
};

+ (id)requestWithURL:(NSURL *)theURL
{
	NSLog(@"NSURLRequest requestWithURL: %@", theURL);
	id ret = %orig;
	return ret;
};

+ (id)requestWithURL:(NSURL *)theURL
         cachePolicy:(NSURLRequestCachePolicy)cachePolicy
     timeoutInterval:(NSTimeInterval)timeoutInterval
{
	NSLog(@"NSURLRequest requestWithURL:%@\n", theURL);
	NSLog(@"                cachePolicy:%lu\n", (unsigned long)cachePolicy);
	NSLog(@"            timeoutInterval:%f", timeoutInterval);
	id ret = %orig;
	return ret;
}

- (id)initWithURL:(NSURL *)theURL
      cachePolicy:(NSURLRequestCachePolicy)cachePolicy
  timeoutInterval:(NSTimeInterval)timeoutInterval               
{
	NSLog(@"NSURLRequest initWithURL:%@\n", theURL);
	NSLog(@"             cachePolicy:%lu\n", (unsigned long)cachePolicy);
	NSLog(@"         timeoutInterval:%f", timeoutInterval);
	id ret = %orig;
	return ret;
}


/*
 Getting Request Properties

 cachePolicy Property
 HTTPShouldUsePipelining Property
 mainDocumentURL Property
 timeoutInterval Property
 networkServiceType Property
 URL Property
*/
/*
 Getting HTTP Request Properties

 allHTTPHeaderFields Property
 HTTPBody Property
 HTTPBodyStream Property
 HTTPMethod Property
 HTTPShouldHandleCookies Property
 - valueForHTTPHeaderField:
*/
- (NSString *)valueForHTTPHeaderField:(NSString *)field
{
	NSLog(@"NSURLRequest valueForHTTPHeaderField: %@", field);
	NSString *ret = %orig;
	return ret;
}
/*
 Allowing Cellular Access
 
 allowsCellularAccess Property
*/
/*
Support for Secure Coding

- supportsSecureCoding
*/
/*
Constants
NSURLRequestCachePolicy
NSURLRequestNetworkServiceType
*/


%end


%hook NSMutableURLRequest
/*
 Setting Request Properties

 cachePolicy Property
 mainDocumentURL Property
 networkServiceType Property
 timeoutInterval Property
 URL Property
 allowsCellularAccess Property
*/

/*
 Setting HTTP Specific Properties

 - addValue:forHTTPHeaderField:
 allHTTPHeaderFields Property
 HTTPBody Property
 HTTPBodyStream Property
 HTTPMethod Property
 HTTPShouldHandleCookies Property
 HTTPShouldUsePipelining Property
 - setValue:forHTTPHeaderField:
*/
// -(void) setHTTPBody:(NSData *) data {
// 	NSString *logEntry = [NSString stringWithUTF8String:(char *)[data bytes]];
// 	NSLog(@"NSMutableURLRequest setHTTPBody:");
// 	NSLog(@"%s", [logEntry UTF8String]);
// 	%orig;
// }
- (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
	NSLog(@"NSMutableURLRequest addValue: %@, %@", value, field);
	%orig;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
	NSLog(@"NSMutableURLRequest setValue: %@, %@", value, field);
	%orig;
}

%end



%end