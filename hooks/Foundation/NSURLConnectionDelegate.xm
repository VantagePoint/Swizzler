/*
 File Description:
  
	*****************************************
	** Foundation NSURLConnectionDelegate  **
	*****************************************

	The NSURLConnectionDelegate protocol defines methods common to the NSURLConnectionDataDelegate 
	and NSURLConnectionDownloadDelegate protocols.

	Delegates of NSURLConnection objects should implement either the data or download delegate protocol 
	(including the methods described in this protocol). Specifically:

	    If you are using NSURLConnection in conjunction with Newsstand Kit’s downloadWithDelegate: method, 
	    the delegate class should implement the NSURLConnectionDownloadDelegate protocol.

	    Otherwise, the delegate class should implement the NSURLConnectionDataDelegate protocol.

	Delegates that wish to perform custom authentication handling should implement the 
	connection:willSendRequestForAuthenticationChallenge: method, which is the preferred mechanism for responding 
	to authentication challenges. (See NSURLAuthenticationChallenge Class Reference for more information on authentication 
	challenges.) If connection:willSendRequestForAuthenticationChallenge: is not implemented, the older, deprecated 
	methods connection:canAuthenticateAgainstProtectionSpace:, connection:didReceiveAuthenticationChallenge:, and 
	connection:didCancelAuthenticationChallenge: are called instead.

	The connection:didFailWithError: method is called at most once if an error occurs during the loading of a resource. 
	The connectionShouldUseCredentialStorage: method is called once, just before the loading of a resource begins.

*/
%group NSURLConnectionDelegate
%hook NSURLConnectionDelegate

/*
Connection Authentication
	- connection:willSendRequestForAuthenticationChallenge:
    - connection:canAuthenticateAgainstProtectionSpace: (Deprecated iOS 8.0)
    - connection:didCancelAuthenticationChallenge: (Deprecated iOS 8.0)
    - connection:didReceiveAuthenticationChallenge: (Deprecated iOS 8.0)
    - connectionShouldUseCredentialStorage:
*/
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	NSLog(@"NSURLConnectionDelegate connection:willSendRequestForAuthenticationChallenge:");
	if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
	    // Now accept the certificate and send the response to the real challenge.sender
	    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
	        			forAuthenticationChallenge:challenge];
    }
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
    NSLog(@"NSURLConnectionDelegate connection:canAuthenticateAgainstProtectionSpace:");
    if([[protectionSpace authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        return YES;
    }

    return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        // Now accept the certificate and send the response to the real challenge.sender
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
						forAuthenticationChallenge:challenge];
    }
}

/*
Connection Completion
    - connection:didFailWithError:
*/



%end
%end