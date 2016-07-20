/*
 File Description:
  
	*****************************
	** Foundation NSXMLParser  **
	*****************************

	Instances of this class parse XML documents (including DTD declarations) in an event-driven manner.
	An NSXMLParser notifies its delegate about the items (elements, attributes, CDATA blocks, comments, and so on) 
	that it encounters as it processes an XML document. It does not itself do anything with those parsed items except 
	report them. It also reports parsing errors. For convenience, an NSXMLParser object in the following descriptions 
	is sometimes referred to as a parser object. Unless used in a callback, the NSXMLParser is a thread-safe class as 
	long as any given instance is only used in one thread. 

*/
%group NSXMLParser
%hook NSXMLParser

/*
	Initializing a Parser Object

	- initWithContentsOfURL:
	- initWithData:
	- initWithStream:
*/
- (id)initWithContentsOfURL:(NSURL *)url
{
	NSLog(@"NSXMLParser initWithContentsOfURL: %@", url);
	id ret = %orig;
	return ret;
}

- (id)initWithData:(NSData *)data
{
	NSLog(@"NSXMLParser initWithData: %@", data);
	id ret = %orig;
	return ret;
}

- (id)initWithStream:(NSInputStream *)stream
{
	NSLog(@"NSXMLParser initWithStream");
	id ret = %orig;
	return ret;
}




%end
%end