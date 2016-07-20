/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "GDURLLoadingSystem.h"

/** Manage access across the firewall via the URL Loading System.
 * Good Dynamics applications can utilize the native URL Loading System to
 * communicate with servers that are behind the enterprise firewall.
 * This is an alternative approach to using GDHttpRequest.
 * Communication across the enterprise firewall utilizes the Good Dynamics
 * proxy infrastructure, which is secure.
 *
 * Access across the firewall is enabled in the URL Loading System by default,
 * when authorization of the application succeeds.
 * The application can subsequently disable and enable access.
 * If the application's or the user's authorization is withdrawn, access is
 * implicitly disabled for the duration of the withdrawal.
 *
 * Access across the firewall utilizes the Good Dynamics proxy infrastructure.
 * The Good Dynamics Runtime includes a class that interfaces with the
 * infrastructure. The interfacing class is also compatible to be registered as
 * a URL handler in the URL Loading System. Enabling and disabling access across
 * the firewall actually registers and de-registers the interfacing class. This
 * means that, when access is disabled, the default URL Loading System handlers
 * will service any URL requests.
 *
 * <B>Note that synchronous request calls should not be made from the main
 * application thread.</B>
 *
 *  \htmlonly <div class="bulletlists"> \endhtmlonly
 * When access is enabled, the normal URL Loading System classes can be used
 * to communicate with servers that are behind the firewall, using standard
 * Internet protocols. For an overview, refer to the <A
 * HREF="http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/URLLoadingSystem/"
 * target="_blank">URL Loading System Programming Guide in the iOS Developer
 * Library on apple.com</A>. Note the following details:
 * - Only the HTTP and HTTPS schemes are ever handled by the Good Dynamics
 *   Runtime. FTP and other schemes are never handled by the Good Dynamics
 *   Runtime, and hence cannot be used to access resources that are behind the
 *   firewall.
 * - Enterprise servers that are not listed in the Good Control console cannot
 *   be accessed, unless they are accessible from the Internet.
 * - Authorization credentials are supported with the following notes:\n
 *   <TT>NSURLAuthenticationMethodHTTPBasic</TT> is supported.\n
 *   <TT>NSURLAuthenticationMethodDefault</TT> is treated as
 *   <TT>NSURLAuthenticationMethodHTTPBasic</TT>.\n
 *   <TT>NSURLAuthenticationMethodHTTPDigest</TT> is supported.\n
 *   <TT>NSURLAuthenticationMethodNTLM</TT> is supported, specifically: NTLMv1,
 *   NTLMv2, and NTLM2 Session.\n
 *   <TT>NSURLAuthenticationMethodNegotiate</TT> is supported for Kerberos
 *   version 5.
 * - When Kerberos authentication is in use, note the following:
 *   - Credentials are initially taken in the same way as other credentials,
 *     with the same specified persistence.
 *   - The credentials will be a username in the form
 *     <EM>user</EM><TT>\@</TT><EM>realm</EM>, and a password.
 *   - The credentials are used to request Kerberos tickets, which are stored.
 *   - The stored Kerberos tickets are then used to authenticate the user on
 *     any site that supports Kerberos authentication. So long as the ticket
 *     continues to be accepted, there is no need for credentials to be supplied
 *     again, and no authentication challenge.
 *   - This continues until a site does not accept the stored ticket (e.g. the
 *     ticket has expired and cannot be renewed).
 *   - The Kerberos realm must be accessible. Usually, this means that the
 *     Kerberos realm must be listed as an Additional Server in the Good
 *     Control console. See the \ref GC.
 *   - Kerberos delegation can be allowed or disallowed. See
 *     \link GDCacheController::kerberosAllowDelegation:\endlink.
 *   .
 * - Authorization credentials are persisted as per the
 *   <TT>NSURLCredentialPersistence</TT> flag of <TT>NSURLCredential</TT>:\n
 *   <TT>NSURLCredentialPersistenceNone</TT> credential is used for this
 *   connection only\n
 *   <TT>NSURLCredentialPersistenceForSession</TT> credential is persisted in
 *   memory\n
 *   <TT>NSURLCredentialPersistencePermanent</TT> treated as
 *   <TT>NSURLCredentialPersistenceForSession</TT>\n
 * - The Good Dynamics secure store is utilized, as follows:
 *   - Browser cookies are persisted in the secure store. See HTTP Cookie
 *     Handling below.
 *   - The default store is not used to cache retrieved files. Instead, a
 *     separate secure cache is used.
 *   - Kerberos tickets are persisted on the device in the secure store.
 *   .
 *   General access to these secure stores by the application is not
 *   supported, but see \ref GDCacheController.
 * - Data communication does not go via the proxy specified in the device's
 *   native settings, if any.
 * - The value <TT>YES</TT> is assumed for the <TT>setAllowsCellularAccess</TT>
 *   flag. See the <A
 *     HREF="http://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSMutableURLRequest_Class"
 *     target="_blank"
 *   >NSMutableURLRequest class reference</A > in the iOS Developer Library on
 *   apple.com for details of this flag.
 * .
 *  \htmlonly </div> \endhtmlonly
 *
 * Additional features are made available, using the
 * \ref NSMutableURLRequest(GDNET) category, and the \ref NSURLCache(GDURLCache)
 * subclass.
 *
 * \see \ref GDiOS, for Good Dynamics authorization
 * \see \ref background_execution
 * \see <A HREF="https://community.good.com/docs/DOC-1061" target="_blank" >Good Dynamics Administrator and Developer Overview</A > for an introduction to Good Dynamics.
 * \see \ref GC, under Registering an Application, for how to list a server
 *
 * <H3>Multiple Authentication Methods</H3>
 * An HTTP server may support multiple authentication methods. For example, a
 * server could support both NTLM and Kerberos authentication. By default, the
 * GD Runtime handles this by selecting the first authentication method
 * presented.
 *
 * The application can implement its own handling for multiple authentication
 * methods, as follows:
 * -# Add a new row to the application's Info.plist fi<TT></TT>le:
 *     - Key: <TT>GDRejectAuthSupport</TT>
 *     - Type: <TT>Boolean</TT>
 *     - Value: <TT>YES</TT>
 *     .
 *     (In case there are multiple Info.plist files, check that the correct one
 *     has been edited by opening the Info tab of the application target being
 *     built. The setting just made should appear there.)
 * -# Implement a <TT>connection::willSendRequestForAuthenticationChallenge</TT>
 *    callback.
 * -# In the application code for the callback, call the
 *    <TT>rejectProtectionSpaceAndContinueWithChallenge</TT> function, where
 *    necessary.
 * .
 * The following code snippet illustrates a simple implementation of the
 * callback mentioned in the above.
 * \code
 * - (void)connection:
 *     (NSURLConnection *)connection
 * willSendRequestForAuthenticationChallenge:
 *     (NSURLAuthenticationChallenge *)challenge
 * {
 *     if(
 *         [[challenge protectionSpace] authenticationMethod] !=
 *         NSURLAuthenticationMethodNTLM
 *     ) {
 *         // Reject anything that is not NTLM, i.e. reject Negotiate.
 *         [[challenge sender]
 *             rejectProtectionSpaceAndContinueWithChallenge:challenge];
 *     }
 *     else {
 *         NSURLCredential* cred =
 *             [NSURLCredentialcredentialWithUser:@"abc"
 *                                       password:@"abc"
 *                                    persistence:NSURLCredentialPersistenceForSession];
 *
 *         [[challenge sender] useCredential:cred
 *                forAuthenticationChallenge:challenge];
 *     }
 * }
 * \endcode
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/#documentation/Foundation/Reference/NSURLConnectionDelegate_Protocol/Reference/Reference.html"
 *     target="_blank"
 * >NSURLConnectionDelegate protocol reference</A> in the iOS Developer Library
 * on apple.com
 *
 * <H3>HTTP Cookie Handling</H3>
 * By default, HTTP cookies received through Good Dynamics secure communication
 * are handled automatically:
 * - Set-cookie: headers that are received as part of an HTTP response are
 *   processed and then added to subsequent matching requests.
 * - Persistent cookies are written to cookie storage in the Good Dynamics
 *   secure store. Storage takes place when the request's ready state becomes
 *   <TT>GDHttpRequest_DONE</TT>, if <TT>GDHttp</TT><TT>Request</TT> is in use.
 * .
 * The Good Dynamics cookie store persists between executions of the
 * application, and if the mobile device is switched off. The contents of the
 * store can be managed with the native <TT>NSHTTPCookieStorage</TT> API, as can
 * non-persistent cookies received through Good Dynamics secure communication.
 *
 * Automatic handling of HTTP cookies received through Good Dynamics secure
 * communication can be disabled, as follows:
 * - For <TT>GDHttp</TT><TT>Request</TT>, call the
 *   <TT>disableCookieHandling</TT> function in the
 *   <TT>GDHttp</TT><TT>Request</TT> class.
 * - For <TT>GDURLLoad</TT><TT>ingSystem</TT>, call the
 *   <TT>setHTTPShouldHandleCookies:</TT> function in the native
 *   <TT>NSMutableURLRequest</TT> class, as usual.
 * .
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSHTTPCookieStorage_Class/Reference/Reference.html"
 *     target="blank"
 * >NSHttpCookieStorage class reference</A> in the iOS Developer Library on
 * apple.com
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSMutableURLRequest_Class/Reference/Reference.html"
 *     target="blank"
 * >NSMutableURLRequest class reference</A> in the iOS Developer Library on
 * apple.com
 */
@interface GDURLLoadingSystem : NSObject {
}

+ (void) enableSecureCommunication;
/**< Enable access across the enterprise firewall via the URL Loading System.
 * Call this function to enable, or re-enable, access across the enterprise
 * firewall via the URL Loading System.
 *
 * Access across the enterprise firewall is provided by the Good Dynamics
 * proxy infrastructure. Only servers that have been specifically listed in the
 * Good Control console are accessible. See under Registering an Application
 * in the \ref GC for how to list a server.
 *
 * Access is enabled by default during authorization processing, which is
 * initiated by the  \link GDiOS::authorize: authorize (GDiOS)\endlink function. The
 * <TT>enableSecure</TT><TT>Communication</TT> function need only be called if
 * access was disabled after authorization, see the
 * \ref disableSecureCommunication function, below.
 */

+ (void) disableSecureCommunication;
/**< Disable access across the enterprise firewall via the URL Loading System.
 * Call this function to disable access across the enterprise firewall via the
 * URL Loading System.
 *
 * Access can be re-enabled using the \ref enableSecureCommunication function.
 * Access will also be re-enabled during authorization processing, which is
 * initiated by the  \link GDiOS::authorize: authorize (GDiOS)\endlink function.
 *
 * Calling this function has no impact on access across the firewall using
 * \ref GDHttpRequest.
 */

+ (BOOL) isSecureCommunicationEnabled;
/**< Check whether access across the enterprise firewall via the URL Loading
 *   System is enabled.
 * Call this function to check whether access across the enterprise firewall via
 * the URL Loading System is enabled.
 *
 * Access can be re-enabled using the \ref enableSecureCommunication function.
 * Access will also be re-enabled during authorization processing, which is
 * initiated by the  \link GDiOS::authorize: authorize (GDiOS)\endlink function.
 *
 * Calling this function has no impact on access across the firewall using
 * \ref GDHttpRequest.
 *
 * \return <TT>YES</TT> if access is enabled.
 * \return <TT>NO</TT> otherwise.
 */

@end
