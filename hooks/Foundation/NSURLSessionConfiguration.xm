/*
 File Description:
  
	******************************************
	** Foundation NSURLSessionConfiguration **
	******************************************
*/

%group NSURLSessionConfiguration
%hook NSURLSessionConfiguration


/*
 Creating a Session Configuration Object
 
 + defaultSessionConfiguration
 + ephemeralSessionConfiguration
 + backgroundSessionConfigurationWithIdentifier:
*/

+ (NSURLSessionConfiguration *)defaultSessionConfiguration
{
	NSLog(@"NSURLSessionConfiguration defaultSessionConfiguration");
	return %orig;
}

+ (NSURLSessionConfiguration *)ephemeralSessionConfiguration
{
	NSLog(@"NSURLSessionConfiguration ephemeralSessionConfiguration");
	return %orig;
}

+ (NSURLSessionConfiguration *)backgroundSessionConfigurationWithIdentifier:(NSString *)identifier
{
	NSLog(@"NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier");
	return %orig;
}

%end
%end
