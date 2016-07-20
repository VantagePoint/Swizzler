%group GDUtility
/*
 * (c) 2014 Good Technology Corporation. All rights reserved.
 */

#ifndef ios_GDUtility_h
#define ios_GDUtility_h

#import <Foundation/Foundation.h>

#ifndef __has_extension
#define __has_extension(x) 0  // Compatibility with non-clang compilers.
#endif

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_GETGDAUTHTOKEN __attribute__((deprecated("Instead use -(void)getGDAuthToken:(NSString*)challenge serverName:(NSString*) serverName")))
#else
#   define DEPRECATE_GETGDAUTHTOKEN __attribute__((deprecated))
#endif

/** Delegate for handling the results of Good Dynamics Authentication Token
 * requests.
 * The results of Good Dynamics Authentication Token requests are
 * handled by creating a class that implements this protocol.
 * 
 * Good Dynamics Authentication (GD Auth) tokens can be requested by utilizing a
 * function in the <TT>GDUti</TT><TT>lity</TT> class.
 *
 * For the token request API, and general information about the GD Auth
 * mechanism, see the \link GDUtility GDUtility\endlink class reference.
 */
%hook GDAuthTokenDelegate
// @protocol GDAuthTokenDelegate

- (void)onGDAuthTokenSuccess:(NSString*)gdAuthToken;
/**< Successful token request callback.
 * This callback will be invoked when a new GD Auth token has been
 * generated. Token generation is always in response to a call to the
 * \link GDUtility::getGDAuthToken: getGDAuthToken\endlink function.
 *
 * The function that is invoked could initiate sending of the token to the
 * application server, out of band. The application server will then be able to
 * utilize the token to authenticate the end user of the mobile application.
 * \param gdAuthToken <TT>NSString</TT> containing the GD Auth token.
 */

- (void)onGDAuthTokenFailure:(NSError*) authTokenError;
/**< Failed token request callback.
 * This callback will be invoked when a request for a GD Auth token has
 * failed. Information about the error condition is passed in
 * a parameter.
 * 
 * Requests for tokens are made by calling the
 * \link GDUtility::getGDAuthToken: getGDAuthToken\endlink function. Invocation of this
 * callback notifies the application that a GD Auth token was not issued in
 * response to a request.
 *
 * Depending on the reason for failure, the function that is invoked could:
 * - Retry the request, by initiating a new GD Auth token request.
 * - Notify the user that GD Auth is not available as an authentication
 *   mechanism.
 * .
 *
 * \param authTokenError <TT>NSError</TT> describing the error condition that
 * led to the failure of the token request.
 *
 * \see \ref gdauthtokendomain
 */

// @end
%end
/** Good Dynamics Authentication Token request.
 * The Good Dynamics Authentication Token mechanism enables
 * applications to utilize the user identification that takes place during Good
 * Dynamics authorization processing. This allows the user to be authenticated
 * without the need for entry of any additional credentials at the device.
 * 
 * See below for an overall description of the Good Dynamics Authentication
 * Token mechanism. This class includes the specific API for requesting
 * tokens.
 * 
 * \see  \link GDiOS::authorize: authorize (GDiOS)\endlink for more details of Good Dynamics authorization
 * processing.
 * \see \ref ServerAPIGDAuthToken
 * 
 * <H3>Good Dynamics Authentication Token Mechanism</H3>
 * The Good Dynamics (GD) platform includes rigorous authentication of the end
 * user. This is used when, for example, identifying whether the user is
 * entitled to run the current application, and when applying security policies.
 * 
 * The Good Dynamics Authentication Token (GD Auth) mechanism enables
 * applications to take advantage of the authentication processes of the GD
 * platform.
 *
 * GD Auth tokens can be requested by the GD application on the device. A token
 * will only be issued if authorization processing has completed, and the end
 * user's identity has been authenticated.
 *
 * Once a token has been issued, the application on the device can send the
 * token to the application server at the back end. The GD Auth token can then
 * be checked by the application server, using a verification service provided
 * by the GD infrastructure.
 *
 * The sequence of APIs used in GD Auth is as follows:
 * -# The mobile application calls \link GDUtility::getGDAuthToken: getGDAuthToken\endlink to
 *    request a token.
 * -# All being well, a token is issued and the
 *     \link GDAuthTokenDelegate::onGDAuthTokenSuccess: onGDAuthTokenSuccess\endlink callback is
 *    invoked and passed the new token.
 * -# The mobile application sends the token, and the user ID of the end user,
 *    to its application server, using an HTTP request, socket, or some other
 *    method.
 * -# The application server checks that the token is valid by calling the
 *    verification service in the \ref ServerAPIGDAuthToken, hosted by an
 *    enterprise Good Proxy server.
 * -# The response from the verification service includes the user ID of the end
 *    user, if the token is valid. The application server can check that the
 *    value from the verification service is the same as that originally sent by
 *    the mobile application.
 * .
 * This sequence validates the end user's identity, and the application server
 * can therefore grant access to resources and other permissions.
 *
 * The same token could be sent again later, and verified again. Calling the
 * verification service does not cause the token to be consumed.
 *
 * Note that the mobile application can obtain the user ID of the end user from
 * the <TT>GDAppConfigKeyUserId</TT> value in the collection returned by the
 * \link GDiOS::getApplicationConfig getApplicationConfig (GDiOS)\endlink function.
 * 
 * <H3>Challenge Strings</H3>
 * A <em>challenge string </em>can be passed as a parameter to the GD Auth token
 * request by the mobile application. The same challenge string will then be
 * provided to the application server, in the response from the verification
 * service.
 *
 * The challenge string could have a number of uses for application developers.
 * A typical usage could be to tie an instance of authentication to a previous
 * access request, as follows:
 * -# The mobile application attempts to access a resource on the application
 *    server.
 * -# The application server generates a random challenge string.
 * -# The application server responds to the mobile application with a denial of
 *    access message that includes the random challenge string.
 * -# The mobile application requests a new GD Auth token, and passes the value
 *    from the denial of access message as the challenge string.
 * -# The mobile application again attempts to access the resource on the
 *    application server, but this time includes the GD Auth token in the
 *    request.
 * -# The application server sends the token to the verification service, which
 *    responds with a challenge string.
 * -# The application server checks that the challenge string from the
 *    verification service is the same as the random challenge string initially
 *    sent to the mobile application in the denial of access message.
 * .
 * In the above, a new random challenge string is generated on every resource
 * access attempt. This has the effect of making the GD Auth tokens one-use. A
 * more advanced algorithm might be to store the token and challenge string in
 * the App Server as a session identifier. To end a session, the App Server
 * could delete the stored token and challenge string, effectively forcing the
 * mobile application to generate a new token, based on a new challenge string,
 * when it next connected.
 * 
 * The verification service provides the challenge string to the application
 * server in an HTTP header, which limits the character set that can be utilized
 * safely. All letters and numerals that lie in the ASCII range 32 to 126 can be
 * utilized safely. Use of other characters is not supported.
 */
%hook GDUtility
// @interface GDUtility : NSObject{
//     id<GDAuthTokenDelegate> gdAuthDelegate;
// }
- (void)getGDAuthToken: (NSString*) challenge serverName:(NSString*) serverName;
/**< Good Dynamics Authentication Token request.
 * Call this function to request a new GD Auth token. Pass the
 * challenge string and server name as parameters.
 *
 * See under Good Dynamics Authentication Token Mechanism, above, for
 * information on how to use GD Auth tokens and the challenge string.
 * 
 * This function requests a GD Auth token from the GD Runtime. The GD
 * Runtime might connect to the GD infrastructure installed at the enterprise in
 * order to service the request.
 * 
 * The request is asynchronous. If the request succeeds, the GD Auth token will
 * be passed to the  \link GDAuthTokenDelegate::onGDAuthTokenSuccess: onGDAuthTokenSuccess\endlink callback in
 * the delegate. If the attempt fails, an error will
 * be passed to the  \link GDAuthTokenDelegate::onGDAuthTokenFailure: onGDAuthTokenFailure\endlink callback in
 * the delegate instead.
 *
 * The <TT>delegate</TT> property must be set before this function is called.
 *
 * \param challenge <TT>NSString</TT> containing the challenge string for the token.
 *                  The challenge string can be empty.
 *
 * \param serverName <TT>NSString</TT> containing additional identification, by
 *                   convention the fully qualified domain name of the
 *                   application server for which a token is being requested.
 *                   Whatever value is passed here will also be returned to the
 *                   server as part of the token validation response.
 *
 */

- (void)getGDAuthToken: (NSString*) challenge DEPRECATE_GETGDAUTHTOKEN;
/**< Good Dynamics Authentication Token request without server name
 *   specification (deprecated).
 * \deprecated
 * This function is deprecated and will be removed in a future release. Instead
 * use the form in which a server name is
 * specified:\n<TT>-(void)getGDAuthToken:(NSString*)challenge
 * serverName:(NSString*) serverName</TT>
 *
 * Calling this function has the same effect as calling the
 * \ref getGDAuthToken: function and specifying an empty string as the
 * <TT>serverName</TT> parameter.
 */

// @property (assign, getter = getGDAuthDelegate, setter = setGDAuthDelegate:) id<GDAuthTokenDelegate> gdAuthDelegate;
/**< Delegated event-handling.
 * GD Auth token requests are asynchronous. When a request succeeds or fails, a
 * callback in the application code is invoked by the Good Dynamics Runtime.
 * 
 * Set this property to an instance of a class in the application that contains
 * the code for the required callbacks, i.e. a class that implements
 * the GDAuthTokenDelegate protocol.
 */


// @end
%end
/**
 * \defgroup gdauthtokendomain Good Dynamics Authentication Token Error Domain
 * These constants can be used when handling Good Dynamics Authentication Token
 * request errors, in a \link GDAuthTokenDelegate GDAuthTokenDelegate\endlink implementation.
 *
 * \{
 */

extern NSString* const GDAuthTokenDomain;
/**< The error domain for Good Dynamics Authentication Token errors.
 */

enum
{
    GDAuthTokenErrNotSupported = -2,
    /**< The version of the Good Dynamics servers installed at the enterprise
     * does not support the Good Dynamics Authentication Token mechanism.
     */
    
    GDAuthTokenErrRetry         = -1,
    /**< An error occurred during token generation or communication.
     * Sending the same request later may not encounter the same condition, and
     * could succeed.
     */
    
};

/** \}
 */


#endif
