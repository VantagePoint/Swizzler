/*
 File Description:
  
	*********************************
	** Foundation NSURLConnection  **
	*********************************

	An NSURLConnection object lets you load the contents of a URL by providing a URL request object. 
	The interface for NSURLConnection is sparse, providing only the controls to start and cancel asynchronous 
	loads of a URL request.
*/

%group NSURLConnection
%hook NSURLConnection

/*
Preflighting a Connection Request
+ canHandleRequest:
*/

/*
 Loading Data Synchronously
 
 + sendSynchronousRequest:returningResponse:error:
*/
+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request
                 returningResponse:(NSURLResponse **)response
                             error:(NSError **)error
{
	NSLog(@"NSURLConnection sendSynchronousRequest: %@\n", request);
	// NSLog(@"       	             returningResponse: %@\n", response);
	// NSLog(@"       	        	             error: %@", error);
	NSData *ret = %orig;
	return ret;
}


/*
Loading Data Asynchronously
+ connectionWithRequest:delegate:
- initWithRequest:delegate:
- initWithRequest:delegate:startImmediately:
+ sendAsynchronousRequest:queue:completionHandler:
- start
*/
+ (NSURLConnection *)connectionWithRequest:(NSURLRequest *)request
                                  delegate:(id)delegate
{
	// NSString *httpMethod = [request HTTPMethod];
	// NSString *url = [[request URL] absoluteString];
	// NSString *httpBody = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];

	// NSLog(@"NSURLConnection initWithRequest: %@, %@", request, delegate);
	
	// NSLog(@"%@ %@\n", httpMethod, url);
	// for (id key in [request allHTTPHeaderFields])
	// {
	// 	NSLog(@"%@: %@\n", key, [[request allHTTPHeaderFields] objectForKey:key]);
	// }
	// NSLog(@"\n");
	// NSLog(@"%@", httpBody);
	NSLog(@"NSURLConnection connectionWithRequest");
	return %orig;
}

- (id)initWithRequest:(NSURLRequest *)request
                       delegate:(id)delegate
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];
    
    if ([[plist objectForKey:@"settings_NSURLConnection_proxy_enable"] boolValue])
    {
        // NSLog(@"GDHttpRequest Proxy Enabled");
        NSString *nsstring_ip = [plist objectForKey:@"settings_NSURLConnection_proxy_ip"];
        const char *ip = [nsstring_ip UTF8String];
        // const char *ip = [(__bridge NSString *)[plist objectForKey:@"settings_NSURLConnection_proxy_ip"] UTF8String];
        int port = [[plist objectForKey:@"settings_NSURLConnection_proxy_port"] intValue];

        NSLog(@"NSURLConnection proxy being set to %s %d", ip, port);

		NSString* proxyHost = [[NSString alloc] initWithUTF8String:ip];
		NSNumber* proxyPort = [NSNumber numberWithInt: port];

		// Create an NSURLSessionConfiguration that uses the proxy
		NSDictionary *proxyDict = @{
		    @"HTTPEnable"  : [NSNumber numberWithInt:1],
		    (NSString *)kCFStreamPropertyHTTPProxyHost  : proxyHost,
		    (NSString *)kCFStreamPropertyHTTPProxyPort  : proxyPort,

		    @"HTTPSEnable" : [NSNumber numberWithInt:1],
		    (NSString *)kCFStreamPropertyHTTPSProxyHost : proxyHost,
		    (NSString *)kCFStreamPropertyHTTPSProxyPort : proxyPort,
		};

		NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
		configuration.connectionProxyDictionary = proxyDict;

		NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:delegate delegateQueue:[NSOperationQueue mainQueue]];

		// Dispatch the request on our custom configured session
		NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
	                              ^(NSData *data, NSURLResponse *response, NSError *error) {
	                                  NSLog(@"NSURLSession got the response [%@]", response);
	                                  NSLog(@"NSURLSession got the data [%@]", data);
	                              }];

		[task resume];
    }
    

	NSString *httpMethod = [request HTTPMethod];
	NSString *url = [[request URL] absoluteString];
	NSString *httpBody = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];

	NSLog(@"NSURLConnection initWithRequest: %@, %@", request, delegate);
	
	NSLog(@"%@ %@\n", httpMethod, url);
	for (id key in [request allHTTPHeaderFields])
	{
		NSLog(@"%@: %@\n", key, [[request allHTTPHeaderFields] objectForKey:key]);
	}
	NSLog(@"\n");
	NSLog(@"%@", httpBody);

	id ret = %orig;
	return ret;
}

/*
Stopping a Connection
- cancel
*/

/*
Scheduling Delegate Method Calls
- scheduleInRunLoop:forMode:
- setDelegateQueue:
- unscheduleFromRunLoop:forMode:
*/
%end
%end