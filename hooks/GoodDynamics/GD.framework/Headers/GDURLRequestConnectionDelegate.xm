%group GDURLRequestConnectionDelegate

#import "GDURLRequestConnectionDelegate.h"

/*
 * (c) 2014 Good Technology Corporation. All Right Reserved.
 */

// #ifndef __GD_URL_REQUEST_CONNECTION_DELEGATE_H__
// #define __GD_URL_REQUEST_CONNECTION_DELEGATE_H__

// #import <Foundation/Foundation.h>

/** \defgroup gdurlconnectionmanagmentconstants GD URL Connection Management Constants
 * Use these constants in a GD URL connection management delegate. See the
 * \link GDURLRequestConnectionDelegate GDURLRequestConnectionDelegate class
 * reference\endlink for details.
 * 
 * \{
 */

// extern NSString* GDRouteInternet;
/**< Routing specifier for direct connection to the Internet.
 * Routing specifier for URL requests that will be, or have been, sent over a
 * direct Internet connection and <EM>not </EM>via the Good Dynamics proxy
 * infrastructure.
 */

// extern NSString* GDRouteGoodProxy;
/**< Routing specifier for connection via the Good Dynamics proxy
 *   infrastructure.
 * Routing specifier for URL requests that will be, or have been, sent via the
 * Good Dynamics proxy infrastructure.
 */

/** \}
 */

/** Delegate for managing the URL connections associated with a UIWebView control.
 * Connections for URL requests issued by a <TT>UIWebView</TT> control can be
 * managed by creating a class that implements this protocol.
 *
 * The callbacks in this protocol enable the application to:
 * - Respond to a certificate authentication challenge.
 * - Block a connection.
 * - Specify whether a connection will be routed direct to the Internet or via
 *   the Good Dynamics proxy infrastructure.
 * - Confirm that a connection was made, and confirm its routing.
 * .
 *
 * Implement this protocol if any of the following is required by the
 * application:
 * - Custom verification of electronic certificates for Secure Socket Layer or
 *   Transport Layer Security (SSL/TLS) connections.
 * - Mutual authentication of electronic certificates for SSL/TLS connections.
 * - Finer control over routing and filtering than is offered by Good Control
 *   client connection configuration.
 * .
 * But note that this protocol does not enable routing to an application server
 * that is behind the enterprise firewall and that has not been configured in
 * the enterprise Good Control console.
 *
 * Call the <TT>GDSetRequestConnectionDelegate:</TT> function in the
 * \link UIWebView(GDNET)\endlink category to set the delegate for a particular
 * <TT>UIWebView</TT> instance. The delegate callbacks will be executed on the
 * same thread in which the delegate was set.
 *
 * The callbacks in this protocol utilize an <TT>NSURLRequest</TT> object to
 * represent the request to which the callback invocation relates. See the <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSURLRequest_Class/Reference/Reference.html"
 *     target="_blank"
 * >NSURLRequest class reference</A> in the iOS Developer Library on apple.com
 * for details of how to access its attributes.
 *
 * \see \ref GC and the online help available in the Good Control console.
 */
// @protocol GDURLRequestConnectionDelegate <NSObject>
%hook GDURLRequestConnectionDelegate
// @optional

- (BOOL)GDRequest:(NSURLRequest*)request willConnectVia:(NSString**)route;
/**< Invoked before a request is sent.
 * This callback is invoked when a request is about to be sent or a connection
 * is about to be established. A specifier for the routing that is going to be
 * used for the connection is passed as a parameter.
 *
 * The specifier is passed as the location of a pointer to <TT>NSString</TT>, i.e. a
 * pointer to a pointer. The function that is invoked can check the routing
 * specified by comparing the pointed-to value with the
 * \link gdurlconnectionmanagmentconstants GD URL Connection Management
 * Constants\endlink.
 *
 * The function that is invoked can specify a different route by overwriting the
 * pointer with the address of an <TT>NSString</TT> of its own. The value of the
 * <TT>NSString</TT> must be the same as one of the connection management constants.
 *
 * The function that is invoked can also block the connection from being
 * established by doing either of the following:
 * - Overwriting the pointer with <TT>nil</TT>.
 * - Returning <TT>NO</TT>.
 * .
 *
 * \param request <TT>NSURLRequest</TT> representing the request that will be
 *                sent.
 * \param route location of a pointer to <TT>NSString</TT> specifying the
 *              routing of the request. The value will be one of the
 *              \link gdurlconnectionmanagmentconstants GD URL Connection
 *              Management Constants\endlink.
 * \return <TT>YES</TT> to allow the request to be sent, via the original
 *                  or changed route.
 * \return <TT>NO</TT> to block the request.
 */

- (void)GDRequest:(NSURLRequest*)request didConnectVia:(NSString*)route;
/**< Invoked after a request has been sent.
 * This callback is invoked after a URL request has been sent or a new
 * connection was established. A specifier for the routing that was used for the
 * request is passed as a parameter.
 *
 * \param request <TT>NSURLRequest</TT> representing the request that was sent.
 * \param route <TT>NSString</TT> specifying the route of the connection. The
 *              value will be one of the \link gdurlconnectionmanagmentconstants
 *              GD URL Connection Management Constants\endlink.
 */

- (void)GDRequest:(NSURLRequest*)request willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge*)challenge;
/**< Invoked when authentication is requested.
 * This callback is invoked during SSL/TLS connection negotiation and when HTTP resource 
 * authentication is required, once for each authentication challenge. There are six types of
 * challenge, all of which could occur during loading of a document:
 * - An <TT>NSURLAuthenticationMethodServerTrust</TT> challenge occurs when a
 *   host certificate is received and requires verification.
 * - An <TT>NSURLAuthenticationMethodClientCertificate</TT> challenge occurs
 *   when the host requests a client certificate for mutual certificate
 *   authentication.
 * - An <TT>NSURLAuthenticationMethodNegotiate</TT> challenge occurs
 *   when access to the requested resource requires Kerberos or NTLM authentication.
 * - An <TT>NSURLAuthenticationMethodNTLM</TT> challenge occurs
 *   when access to the requested resource requires NTLM authentication.
 * - An <TT>NSURLAuthenticationMethodHTTPDigest</TT> challenge occurs
 *   when access to the requested resource requires HTTP Digest authentication.
 * - An <TT>NSURLAuthenticationMethodHTTPBasic</TT> challenge occurs
 *   when access to the requested resource requires HTTP Basic authentication.
 * .
 * The type of the authentication challenge can be determined from the
 * <TT>challenge</TT> parameter. See the <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSURLAuthenticationChallenge_Class/Reference/Reference.html"
 *     target="_blank"
 * >NSURLAuthenticationChallenge class reference</A> in the iOS Developer
 * Library on apple.com
 *
 * The function that is invoked can respond to the challenge by calling the
 * <TT>NSURLAuthenticationChallengeSender</TT> methods on the object in the
 * <TT>challenge</TT> parameter. See the <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Protocols/NSURLAuthenticationChallengeSender_Protocol/Reference/Reference.html"
 *     target="_blank"
 * >NSURLAuthenticationChallengeSender protocol reference</A> in the iOS
 * Developer Library on the apple.com website for details of the API. The
 * <TT>NSURLAuthenticationChallengeSender</TT> methods must be used within
 * five seconds of the invocation or no response will be assumed.
 *
 * If host certificate verification is required and the application does not
 * respond, then the connection will not be established. If a client certificate
 * is requested and the application does not respond, then the connection may or
 * may not be established depending only on the configuration of the host server.
 * If an HTTP resource requires authentication and the application does not respond,
 * the request will eventually fail with a timeout error.
 *
 * \param request <TT>NSURLRequest</TT> representing the request that will be
 *                sent if SSL/TLS negotiation succeeds.
 * \param challenge <TT>NSURLAuthenticationChallenge</TT> object that:
 *                  - Contains the challenge details.
 *                  - Implements the <TT>NSURLAuthenticationChallengeSender</TT>
 *                  protocol.
 *                  .
 */

// @end

// #endif

%end

%end