/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#pragma once

#import <Foundation/Foundation.h>

extern NSString* const GDURLAuthenticationParameters;

/** NSMutableURLRequest category with additional features.
 * This class is a category of the Foundation <TT>NSMutableURLRequest</TT>
 * class that can be used when the Good Dynamics (GD) proxy infrastructure is enabled
 * in the URL Loading System (see \ref GDURLLoadingSystem). This class
 * provides additional features to the default request class.
 *
 * The additional features enable enhanced control over authentication by
 * applications that use the <TT>UIWebView</TT> class.
 *
 * This documentation includes only additional operations that are not part
 * of the default <TT>NSMutableURLRequest</TT> API.
 *
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSMutableURLRequest_Class"
 *     target="_blank"
 * >NSMutableURLRequest class reference</A> in the iOS Developer Library on
 * apple.com
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/documentation/UIKit/Reference/UIWebView_Class"
 *     target="_blank"
 * >UIWebView class reference</A> in the iOS Developer Library on apple.com
 * \see
 * <A
 *     HREF="http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/DisplayWebContent/DisplayWebContent.html"
 *     target="_blank"
 * >WebKit Objective-C Programming Guide</A> in the Mac Developer Library on
 * apple.com
 *
 * <H3>Authentication error-handling</H3>
 * Authentication errors may be encountered when this class is in use.
 * For example, the combination of user ID and password may be rejected by the
 * server that receives the HTTP request.
 *
 * When an authentication error is encountered, a call to
 * <TT>UIWebViewDelegate::didFailLoadWithError:(NSError *)error</TT> will be
 * made. The code used to indicate that the failure condition is an
 * authentication error is <TT>NSURLErrorUserAuthenticationRequired</TT>.
 *
 * The <TT>NSError</TT> object that is passed will have an associated
 * <TT>NSDictionary</TT> object, which can be accessed via the
 * <TT>NSError::userInfo</TT> accessor.
 * In the <TT>NSDictionary</TT>, with the key
 * <TT>GDURLAuthenticationParameters</TT>, there will be an <TT>NSArray</TT>
 * containing the authentication objects associated with the request.
 *
 * The structure of the authentication parameters <TT>NSArray</TT> will be as
 * follows:
 * \code
 * { (NSURLProtectionSpace*) protectionSpace, (NSURLCredential*) credential, nil }
 * \endcode
 * Note that <TT>credential</TT> may be nil.
 *
 * The following example shows how to access the array and credentials.
 * \code
 * - (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
 *
 *   if( NSURLErrorUserAuthenticationRequired == [error code] ) {
 *       NSDictionary* dict = [error userInfo];
 *       NSArray* credentialArray = [dict objectForKey:GDURLAuthenticationParameters];
 *       if(credentialArray){
 *           NSURLProtectionSpace* protSpace = nil;
 *           NSURLCredential* cred = nil;
 *           if([credentialArray count] > 0){
 *               protSpace = [credentialArray objectAtIndex:0];
 *               // we may also have a credential
 *               if([credentialArray count] > 1){
 *                   cred = [credentialArray objectAtIndex:1];
 *               }
 *           }
 *           // Do something with the credentials here
 *       }
 *   }
 *
 *   // Handling for other error conditions goes here
 * }
 * \endcode
 */
@interface NSMutableURLRequest (GDNET)

- (BOOL) failOnAuthorizationChallenge;
/**< Handle authentication challenges by failing in UIWebView.
 * Call this function to force a failure in the URL request's associated
 * <TT>UIWebView</TT> object when an authentication challenge is received.
 *
 * Calling this function sets the following behavior: When the
 * associated URL request receives an HTTP 401 "Unauthorized" response, or an
 * HTTP 407 "Proxy Authentication Required" response, the <TT>UIWebView</TT>
 * will fail with <TT>UIWebViewDelegate::didFailLoadWithError</TT>.
 *
 * The application should handle the failure by taking appropriate action,
 * such as resubmitting the request with authorization credentials.
 *
 * By default, <TT>UIWebView</TT> does not fail when either of these statuses
 * is received in the related request.
 *
 * This function can only be used when the Good Dynamics proxy infrastructure is
 * enabled within the URL Loading System, and a <TT>UIWebView</TT> control is in
 * use.
 */

- (BOOL) failOnAuthorisationChallenge;
/**< Deprecated spelling of <TT>failOnAuthorizationChallenge</TT>.
 * \deprecated This function is deprecated and will be removed in a future
 * release. Use the spelling <TT>failOnAuthorizationChallenge</TT> instead.
 *
 */

- (BOOL) setAuthorizationCredentials:(NSURLCredential*)credentials withProtectionSpace:(NSURLProtectionSpace*)space;
/**< Specify authorization credentials (UIWebView only).
 * Call this function to set the authorization credentials that will be sent if
 * the response to the URL request contains an authentication challenge.
 * This function can be used with requests that are associated with a
 * <TT>UIWebView</TT> object.
 *
 * Authorization credentials would usually be sent in response to receiving
 * <TT>NSURLConnectionDelegate didReceiveAuthenticationChallenge</TT>.
 *
 * Server and proxy credentials can both be set, in separate calls to the function.
 *
 * This function can only be used when the Good Dynamics proxy infrastructure is
 * enabled within the URL Loading System, and a <TT>UIWebView</TT> control is in
 * use.
 *
 * \param credentials <TT>NSURLCredential</TT> containing the username and
 * password.
 * \param space <TT>NSURLProtectionSpace</TT> containing the following:\n
 * Hostname or address,\n
 * Port number,\n
 * Authentication method,\n
 * Proxy indicator.
 */

- (BOOL) setAuthorisationCredentials:(NSURLCredential*)credentials withProtectionSpace:(NSURLProtectionSpace*)space;
/**< Deprecated spelling of <TT>setAuthorizationCredentials:withProtectionSpace:</TT>.
 * \deprecated This function is deprecated and will be removed in a future
 * release. Use the spelling
 * <TT>setAuthorizationCredentials:withProtectionSpace:</TT> instead.
 *
 */

#define DEPRECATE_DISABLEVERIFICATION __attribute__((deprecated( \
    "Implement willSendRequestForAuthenticationChallenge instead")))

- (BOOL) disableHostVerification DEPRECATE_DISABLEVERIFICATION;
/**< Deprecated security option: Disable SSL/TLS host name verification
 *   (UIWebView only).
 * \deprecated This function is deprecated and will be removed in a future
 * release. Do not disable SSL/TLS host name verification by calling this
 * function. Instead, implement a custom authentication challenge handler
 * that does not verify the host name.\n
 * If the server cannot be automatically verified, one of the following
 * custom authentication challenge handlers can be invoked:
 * - <TT>NSURLConnectionDelegate::willSendRequestForAuthenticationChallenge</TT>
 * - <TT>GDURLRequestConnec</TT><TT>tionDelegate::willSendRequestForAuthenticationChallenge</TT>
 * .
 * See the <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLConnectionDelegate_Protocol"
 *     target="_blank"
 * >NSURLConnectionDelegate protocol reference</A> in the iOS Developer Library
 * on the apple.com website, or the
 * \link GDURLRequestConnectionDelegate GDURLRequestConnectionDelegate protocol
 * reference\endlink here for details.
 * 
 * Call this function to disable host name verification, when making an HTTPS
 * request.
 * Host name verification is an SSL/TLS security option.
 * This function can be used with requests that are associated with a
 * <TT>UIWebView</TT> object.
 *
 * Host name verification would usually take place in response to receiving
 * <TT>NSURLConnection::didReceiveAuthenticationChallenge</TT>.
 *
 * This function can only be used when the Good Dynamics proxy infrastructure is
 * enabled within the URL Loading System.
 *
 * See under <TT>disableHost</TT><TT>Verification</TT> in the \link
 * GDHttpRequest::disableHostVerification GDHttpRequest class reference\endlink
 * for further information about host name verification.
 */


- (BOOL) disablePeerVerification DEPRECATE_DISABLEVERIFICATION;
/**< Deprecated security option: Disable SSL/TLS authenticity verification
 *   (UIWebView only).
 * \deprecated This function is deprecated and will be removed in a future
 * release. Do not disable SSL/TLS authenticity verification by calling this
 * function. Instead, implement a custom authentication challenge handler
 * that does not verify certificate authenticity.\n
 * If the server cannot be automatically verified, one of the following
 * custom authentication challenge handlers can be invoked:
 * - <TT>NSURLConnectionDelegate::willSendRequestForAuthenticationChallenge</TT>
 * - <TT>GDURLRequestConnec</TT><TT>tionDelegate::willSendRequestForAuthenticationChallenge</TT>
 * .
 * See the <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLConnectionDelegate_Protocol"
 *     target="_blank"
 * >NSURLConnectionDelegate protocol reference</A> in the iOS Developer Library
 * on the apple.com website, or the
 * \link GDURLRequestConnectionDelegate GDURLRequestConnectionDelegate protocol
 * reference\endlink here for details.
 *
 * Call this function to disable certificate authenticity verification, when
 * making an HTTPS request.
 * Certificate authenticity verification is an SSL/TLS security option.
 * This function can be used with requests that are associated with a
 * <TT>UIWebView</TT> object.
 *
 * Certificate authenticity verification would usually take place in response to
 * receiving <TT>NSURLConnection::didReceiveAuthenticationChallenge</TT>.
 *
 * This function can only be used when the Good Dynamics proxy infrastructure is
 * enabled within the URL Loading System.
 *
 * See under <TT>disablePeer</TT><TT>Verification</TT> in the \link
 * GDHttpRequest::disablePeerVerification GDHttpRequest class reference\endlink
 * for further details about certificate authenticity verification.
 */

#undef DEPRECATE_DISABLEVERIFICATION

- (BOOL)undoPriorTrustDecision;
/**< Cancel persistence of a stored server trust credential.
 * Call this function to cancel the persistence of a server trust
 * credential. Persistence must have been set via the
 * <TT>NSURLCredential(GDNET)</TT> <TT>gdPersistence</TT> property, so that the
 * credential is being managed by the GD Runtime.
 *
 * Credentials managed by the GD Runtime are stored persistently in the GD
 * secure store on the mobile device. The URL of the
 * <TT>NSMutableURLRequest</TT> object on which this method is called will be
 * used by the runtime to identify the server certificate.
 *
 * \return <TT>YES</TT> if a persistent server trust credential was found and
 *                  cancelled.
 * \return <TT>NO</TT> otherwise.
 *
 * \see The class reference of the \ref NSURLCredential(GDNET) category for the
 * API and implications of setting persistence.
 */

@end
