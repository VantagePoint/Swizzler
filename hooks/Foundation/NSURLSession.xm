/*
 File Description:
  
	*****************************
	** Foundation NSURLSession **
	*****************************
*/

%group NSURLSession
%hook NSURLSession

/*
 Creating a Session

 + sessionWithConfiguration:
 + sessionWithConfiguration:delegate:delegateQueue:
 + sharedSession
*/
+ (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
{
	NSLog(@"NSURLSession sessionWithConfiguration");
	return %orig;
};

+ (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
                                  delegate:(id<NSURLSessionDelegate>)delegate
                             delegateQueue:(NSOperationQueue *)queue
{
	NSLog(@"NSURLSession sessionWithConfiguration");
	return %orig;
};

+ (NSURLSession *)sharedSession
{
	NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];
    
    if ([[plist objectForKey:@"settings_NSURLSession_proxy_enable"] boolValue])
    {
        NSString *nsstring_ip = [plist objectForKey:@"settings_NSURLSession_proxy_ip"];
        const char *ip = [nsstring_ip UTF8String];
        int port = [[plist objectForKey:@"settings_NSURLSession_proxy_port"] intValue];

        NSLog(@"NSURLSession proxy being set to %s %d", ip, port);

		NSString* proxyHost = [[NSString alloc] initWithUTF8String:ip];
		NSNumber* proxyPort = [NSNumber numberWithInt: port];

		// Create an NSURLSessionConfiguration that uses the proxy
		NSDictionary *proxyDict = @{
		    @"HTTPEnable": @YES,
		    (NSString *)kCFStreamPropertyHTTPProxyHost  : proxyHost,
		    (NSString *)kCFStreamPropertyHTTPProxyPort  : proxyPort,

		    @"HTTPSEnable": @YES,
		    (NSString *)kCFStreamPropertyHTTPSProxyHost : proxyHost,
		    (NSString *)kCFStreamPropertyHTTPSProxyPort : proxyPort,
		};

		NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
		configuration.connectionProxyDictionary = proxyDict;

		NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

		return session;
    } else {
    	NSLog(@"NSURLSession sharedSession");
		return %orig;
    }

};

/*
 Configuring a Session
 
 configuration Property
 delegate Property
 delegateQueue Property
 sessionDescription Property
*/


/*
 Adding Data Tasks to a Session

 - dataTaskWithURL:
 - dataTaskWithURL:completionHandler:
 - dataTaskWithRequest:
 - dataTaskWithRequest:completionHandler:
*/

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url
{
	NSLog(@"NSURLSessionDataTask dataTaskWithURL");
	return %orig;
};

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url
                        completionHandler:(void (^)(NSData *data,
                                                    NSURLResponse *response,
                                                    NSError *error))completionHandler
{
	NSLog(@"NSURLSessionDataTask dataTaskWithURL");
	return %orig;
};

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request                 
{
	NSLog(@"NSURLSessionDataTask dataTaskWithRequest");
	return %orig;
};

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:(void (^)(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error))completionHandler
{
	NSLog(@"NSURLSessionDataTask dataTaskWithRequest");
	return %orig;
};

/*
Adding Download Tasks to a Session
- downloadTaskWithURL:
- downloadTaskWithURL:completionHandler:
- downloadTaskWithRequest:
- downloadTaskWithRequest:completionHandler:
- downloadTaskWithResumeData:
- downloadTaskWithResumeData:completionHandler:

Adding Upload Tasks to a Session
- uploadTaskWithRequest:fromData:
- uploadTaskWithRequest:fromData:completionHandler:
- uploadTaskWithRequest:fromFile:
- uploadTaskWithRequest:fromFile:completionHandler:
- uploadTaskWithStreamedRequest:

Managing the Session
- finishTasksAndInvalidate
- flushWithCompletionHandler:
- getTasksWithCompletionHandler:
- invalidateAndCancel
- resetWithCompletionHandler:
*/


%end
%end