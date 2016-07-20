/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#ifndef __GD_IOS_H__
#define __GD_IOS_H__

#import <UIKit/UIKit.h>
#import "GDAppResultCode.h"

// See: http://clang.llvm.org/docs/LanguageExtensions.html
#ifndef __has_extension
#define __has_extension(x) 0  // Compatibility with non-clang compilers.
#endif

/** Constants for GD service provider type.
 * This enumeration represents the type of service for which a service discovery
 * query is being issued. The <TT>serviceProviderType</TT> parameter of the
 *  \link GDiOS::getServiceProvidersFor:andVersion:andType:  getServiceProvidersFor:  (GDiOS)\endlink function always takes one of these values.
 */
typedef NS_ENUM(NSInteger, GDServiceProviderType)
{
    GDServiceProviderApplication=0,
    /**< Application-based service. */
    GDServiceProviderServer,
    /**< Server-based service. */
};


/**
 * \defgroup gdappevent GDAppEvent property constants
 * Use these enumerated constants in the application code for the
 * Good Dynamics Runtime event-handler.
 *
 * \{
 */

#if __has_extension(attribute_deprecated_with_message)
# define DEPRECATE_DATAPLANUPDATE_EVENT __attribute__((deprecated("Never dispatched")))
#else
# define DEPRECATE_DATAPLANUPDATE_EVENT __attribute__((deprecated))
#endif

/** Constants for GDAppEvent type.
 * This enumeration represents the type of a GDAppEvent that is being
 * notified. The \ref GDAppEvent.type property will always take one of these
 * values.
 */
typedef NS_ENUM(NSInteger, GDAppEventType)
{
    GDAppEventAuthorized = 0,
    /**< Either the user has been authorized to access the application and its
     * data, following authorization processing, or a condition that caused
     * authorization to be withdrawn has been cleared.
     * In either case, the user can be given access to the application data, and
     * the application can make full use of the Good Dynamics API.
     * 
     * The event result code will be <TT>GDErrorNone</TT>.
     * 
     * See  \link GDiOS::authorize: authorize (GDiOS)\endlink for authorization processing initiation.
     */

    GDAppEventNotAuthorized = 1,
    /**< Either the user has <EM>not </EM>been authorized to access the
     * application and its data, following authorization processing, or a
     * condition has arisen that caused authorization to be withdrawn.
     * In either case, the application must deny the user access to any
     * application data. This includes not displaying any data in the
     * application user interface.
     * 
     * In the case that the user is found not to be authorized following
     * authorization processing, the application cannot make use of the Good
     * Dynamics APIs, except to initiate authorization processing again.
     * Otherwise, if authorization has only been withdrawn, the application can
     * make use of the Good Dynamics APIs.
     * 
     * The event result code will indicate the condition that has arisen.
     * See \ref GDAppResultCode.
     * 
     * See  \link GDiOS::authorize: authorize (GDiOS)\endlink for authorization processing initiation.
     */

    GDAppEventRemoteSettingsUpdate = 2,
    /**< A change to application configuration or other settings from the
     * enterprise has been received.\ An event of this type is despatched
     * whenever there is a change in any value that is returned by
     * \link GDiOS::getApplicationConfig getApplicationConfig (GDiOS)\endlink.
     */

    GDAppEventServicesUpdate = 3,
    /**< A change to services-related configuration of one or more applications
     * has been received.\ See under  \link GDiOS::getServiceProvidersFor:andVersion:andType:  getServiceProvidersFor:  (GDiOS)\endlink.
     */
    
    GDAppEventPolicyUpdate = 4,
    /**< A change to one or more application-specific policy settings has been
     * received.\ See under \link GDiOS::getApplicationPolicy getApplicationPolicy (GDiOS)\endlink.
     */
    
    GDAppEventDataPlanUpdate DEPRECATE_DATAPLANUPDATE_EVENT = 5,
    /**< \deprecated This event type is deprecated and will be removed in a
     * future release.\ It is never dispatched.
     *
     * A change to the data plan state of the running application has been
     * received.\ See also \link GDiOS::isUsingDataPlan isUsingDataPlan (GDiOS)\endlink.
     */

    GDAppEventEntitlementsUpdate = 6,
    /**< A change to the entitlements data of the end user has been
     * received.\ If the entitlements of the end user had previously been
     * checked, by calling the
     * \link GDiOS::getEntitlementVersionsFor:callbackBlock: getEntitlementVersionsFor:callbackBlock: (GDiOS)\endlink function,
     * then the entitlements should be checked again now.
     */
};

/** \}
 */

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_APPCONFIGKEYS __attribute__((deprecated("Use GDAppConfigKeyServers")))
#else
#   define DEPRECATE_APPCONFIGKEYS __attribute__((deprecated))
#endif

extern const NSString* const GDAppConfigKeyServers;
/**< Constant key value for application server configuration.\ See under
 * \ref GDiOS::getApplicationConfig.
 */

extern const NSString* const GDAppConfigKeyHost DEPRECATE_APPCONFIGKEYS;
/**< Deprecated constant key value for application server address.\ See under
 * \ref GDiOS::getApplicationConfig.
 * \deprecated The <TT>GDAppConfigKeyHost</TT> and <TT>GDAppConfigKeyPort</TT>
 * keys are deprecated and will be removed in a future release. The recommended
 * way to access application server configuration is to use the
 * <TT>GDAppConfigKeyServers</TT> value.
 */

extern const NSString* const GDAppConfigKeyPort DEPRECATE_APPCONFIGKEYS;
/**< Deprecated constant key value for application server port number.\ See
 * under \ref GDiOS::getApplicationConfig.
 * \deprecated The <TT>GDAppConfigKeyHost</TT> and <TT>GDAppConfigKeyPort</TT>
 * keys are deprecated and will be removed in a future release. The recommended
 * way to access application server configuration is to use the
 * <TT>GDAppConfigKeyServers</TT> value.
 */

extern const NSString* const GDAppConfigKeyConfig;
/**< Constant key value for application-specific configuration data.\ See under
 * \ref GDiOS::getApplicationConfig.
 */

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_APP_COPYPASTEON __attribute__((deprecated("Use GDAppConfigKeyPreventDataLeakageOut")))
#else
#   define DEPRECATE_APP_COPYPASTEON __attribute__((deprecated))
#endif

extern const NSString* const GDAppConfigKeyCopyPasteOn DEPRECATE_APP_COPYPASTEON;
/**< Deprecated constant key value for application server port number.\ See
 * under \ref GDiOS::getApplicationConfig.
 * \deprecated The <TT>GDAppConfigKeyCopyPasteOn</TT> key is deprecated and will be removed
 * in a future release. The recommended way to access Data Leakage security policy indicator is to
 * use the <TT>GDAppConfigKeyPreventDataLeakageOut</TT> value.
 */

extern const NSString* const GDAppConfigKeyPreventDataLeakageOut;
/**< Constant key value for the Data Leakage security policy indicator.\ See
 * under \ref GDiOS::getApplicationConfig.
 */

extern const NSString* const GDAppConfigKeyPreventDataLeakageIn;
/**< Constant key value for the Data Leakage security policy indicator.\ See
 * under \ref GDiOS::getApplicationConfig.
 */

extern const NSString* const GDAppConfigKeyDetailedLogsOn;
/**< Constant key value for enabling and disabling detailed diagnostic
 * logging.\ See under \ref GDiOS::getApplicationConfig.
 */

extern const NSString* const GDAppConfigKeyUserId;
/**< Constant key value for the user's enterprise email address.\ See under
 * \ref GDiOS::getApplicationConfig.
 */

extern const NSString* const GDAppConfigKeyUserPrincipalName;
/**< Constant key value for the user's User Principal Name (UPN).\ See under
 * \ref GDiOS::getApplicationConfig.
 */

/** Event dispatched from the Good Dynamics Runtime.
 * This class is used to deliver events to the \link GDiOS\endlink event handler
 * in the application. See \ref GDiOSDelegate.
 */
@interface GDAppEvent : NSObject
{
    NSString* message;
    /**< Textual description of the event.
     * This property contains a textual description of the event.
     * The text is suitable for display to the end user, at least for reporting
     * diagnostic information for support purposes.
     */

    GDAppResultCode code;
    /**< Numeric result code.
     * This property contains a numeric result code.
     * For success events, the <TT>GDErrorNone</TT> code is used.
     * Other values in the \ref GDAppResultCode enumeration are used for errors.
     */

    GDAppEventType type;
    /**< Numeric event type.
     * This property contains a numeric type code.
     * To determine the type of event being notified, compare this property's
     * value to the constants in the \ref GDAppEventType enumeration.
     */
}

@property (nonatomic, copy) NSString* message;
/*optional description of the event*/
@property (nonatomic, assign) GDAppResultCode code;
/* error code 0, means success */
@property (nonatomic, assign) GDAppEventType type;
/* type of the event, */
@end


/** Handler for events dispatched from the Good Dynamics Runtime,
 * including authorization events.
 * Errors and state changes that occur when using \link GDiOS\endlink
 * are handled by creating a class that implements this protocol.
 */
@protocol GDiOSDelegate
@required

- (void)handleEvent:(GDAppEvent*)anEvent;
/**< Callback for all events.
 * The callback is invoked whenever a Good Dynamics Runtime object event occurs.
 * Runtime object events include authorization results, see  \link GDiOS::authorize: authorize (GDiOS)\endlink for
 * details.
 *
 * \param anEvent GDAppEvent populated with details of the event.
 */

@end

/** Good Dynamics Runtime object interface, including authorization.
 * This class represents the application's connection to the Good
 * Dynamics Runtime on the device, and hence to the wider Good Dynamics platform
 * infrastructure.
 *
 * The API includes a number of functions that the application must call at
 * particular points in the application execution cycle. The application must
 * also implement a handler for events dispatched in this API. Calling the
 * functions, and handling the events correctly, ensures compliance with
 * enterprise security policies. This API also includes a number of
 * miscellaneous functions for various purposes, such as setting a custom
 * logo for display in the user interface.
 *
 * The application must initialize the Good Dynamics interface object, using
 * this API, prior to using any other Good Dynamics API. Initialization will
 * only succeed if the end user has been provisioned in the enterprise's Good
 * Control server, and is entitled to use the application.
 * 
 * The user's entitlement to the application may later be revoked or
 * temporarily withdrawn. For example, temporary withdrawal may take place if
 * the user is inactive for a period of time. In either case, the application
 * will be notified with an event or callback from this API.
 *
 * Successful initialization of the Good Dynamics interface object enables
 * the Good Dynamics proxy infrastructure within the URL Loading System.
 *
 * \see \ref GC
 * \see <A HREF="https://community.good.com/docs/DOC-1061" target="_blank" >Good Dynamics Administrator and Developer Overview</A > for an introduction to Good Dynamics.
 * \see \ref threads
 * \see \ref background_execution
 * \see \ref GDURLLoadingSystem for proxy enablement within the URL Loading
 *           System
 *
 * <H3>Good Dynamics Platform Connection</H3>
 * Establishing a connection to the Good Dynamics (GD) platform requires
 * authorization of the end user, and of the application. Both authorizations
 * are initiated by a single call to the <TT>authorize</TT> function.
 *
 * The <TT>authorize</TT> function call is typically made when the
 * application starts, in the
 * <TT>application:didFinishLaunchingWithOptions:</TT> handler.
 *
 * Authorization generally includes establishing a data connection to the GD
 * proxy infrastructure, and hence to the enterprise that provisioned the end
 * user. In addition, authorization will also include any necessary registration
 * of the device, at the GD Network Operation Center (infrastructure
 * activation), and at the enterprise (enterprise activation). See under
 * Activation, below, for more details.
 *
 * Authorization may include user interaction, see the documentation of the
 * authorize function, below, for details. All user interaction that is part
 * of authorization takes place in a user interface that is part of the GD
 * Runtime library, not part of the application.
 *
 * The authorization API is state-based and asynchronous. The initiation
 * function generally returns immediately. Success or failure of
 * authorization is then notified to the application code later, as a
 * transition of the <em>authorization state</em>. The application should
 * generally wait to be notified of transition to the "authorized" state before
 * attempting to utilize any other GD APIs.
 *
 * Further changes to the authorization state can take place, and are notified
 * to the application in the same way. See under Authorization State, below.
 *
 * \see \ref enterprisesimulation for instructions on building an application to
 * run in a special limited mode in which authorization with the enterprise is
 * only simulated.
 * \see <A
 *     href="https://community.good.com/docs/DOC-1121" target="_blank"
 * >Network Operation Center server addresses</A> on the Good Developer Network for IP address
 * and port number details of the GD Network Operation Center services.
 *
 * <H3>Authorization State</H3>
 * The GD Runtime maintains the authorization state of the application. The GD
 * APIs that can be utilized by the application depend on its current
 * authorization state.
 *
 * The initial state of the application when it starts is <em>not
 * authorized</em>. In this state the application can utilize the authorization
 * processing initiation API but cannot utilize any principal GD APIs, such as
 * secure store access and secure communication.
 *
 * After authorization has been initiated and has succeeded, the application
 * enters the <em>authorized </em>state. The principal GD APIs can then be
 * utilized.
 *
 * Authorization of the end user may be temporarily withdrawn, in which case the
 * application enters the <em>locked </em>state. This would happen when, for
 * example, the user does not interact with the application for an extended
 * period and the enterprise inactivity time out expires. Note that the
 * authorization of the application itself has not been withdrawn in this state,
 * only the authorization of the end user to access the application's data.\n
 * In the locked state, the GD Runtime superimposes an unlock screen on the
 * application user interface to prevent the user from interacting with the
 * application or viewing its data. Note that the GD Runtime does not block the
 * whole device user interface, which means that native notification features
 * and other ancillary mechanisms
 * could still be utilized by the application. The application must not cause
 * sensitive enterprise data to be displayed through these features and
 * mechanisms when in the locked state.\n
 * The application can continue to utilize the principal GD APIs, in the
 * background.
 *
 * After a temporary withdrawal ends, the application returns to the authorized
 * state. This would happen when, for example, the user enters their security
 * password in the unlock screen.
 *
 * Authorization may also be permanently withdrawn, in which case the
 * application enters the <em>wiped </em>state. This would happen when, for
 * example, the end user's entitlement to the application is removed by the
 * enterprise administrator. In the wiped state, the application cannot utilize
 * the principal GD APIs.
 * 
 * Transitions of the authorization state are notified by dispatching a
 * <TT>GDAppEvent</TT> object to the <TT>GDiOSDelegate</TT> instance in the
 * application. The event will have a number of attributes, including a type
 * value that indicates whether the user is now authorized.
 * 
 * The authorization states and their corresponding event type values are listed
 * in the following table.
 * <TABLE>
 *     <TR
 *         ><TH>State</TH
 *         ><TH>Description</TH
 *         ><TH
 *         ><TT>GDApp</TT><TT>Event</TT><BR>type value</TH
 * 
 *     ></TR><TR><TD
 *         >Not authorized</TD
 *     ><TD
 *         >Initial state.\n
 *         The application can initiate authorization, but cannot utilize the
 *         principal GD APIs.</TD
 *     ><TD
 *         ></TD
 *
 *     ></TR><TR><TD
 *         >Authorized</TD
 *     ><TD
 *         >Either the user has just been authorized to access the application,
 *         following authorization processing, or a condition that caused
 *         authorization to be withdrawn has been cleared.\n
 *         The application can utilize the principal GD APIs.</TD
 *     ><TD
 *         ><TT>GDAppEventAuthorized</TT></TD
 *
 *     ></TR><TR><TD
 *         >Locked</TD
 *     ><TD
 *         >Authorization of the user has been temporarily withdrawn, for
 *         example due to inactivity.\n
 *         User interaction is blocked. The application can still utilize the
 *         principal GD APIs.</TD
 *     ><TD
 *         ><TT>GDAppEventNotAuthorized</TT></TD
 *
 *     ></TR><TR><TD
 *         >Wiped</TD
 *     ><TD
 *         >Authorization of the user has been permanently withdrawn, for
 *         example due to violation of an enterprise policy for which the
 *         enforcement action is to wipe the secure container.\n
 *         The application cannot use any GD APIs.</TD
 *     ><TD
 *         ><TT>GDAppEventNotAuthorized</TT>\n
 *         This is the same event type as the Locked state transition event.</TD
 *
 *     ></TR
 * ></TABLE
 * >The transitions in the above table are also shown in the
 * \ref st04gdauthorisation.
 *
 * The GD Runtime user interface includes all the necessary screens and messages
 * to inform the user of the authorization state. The application code needs
 * only to ensure:
 * - That it does not bypass the GD Runtime user interface.
 * - That it does not attempt to access the principal GD APIs prior to
 *   authorization.
 * - That it does not attempt to access the principal GD APIs after the
 *   authorization state has changed to wiped.
 * .
 *
 * 
 * <H3>API Restrictions</H3>
 * The application cannot use any of the principal GD APIs before authorization
 * has succeeded. If the application attempts to do so, the GD Runtime
 * generates an assertion, which results in the
 * application being terminated.
 * The runtime uses the Foundation <TT>NSAssert</TT> macro to generate these
 * assertions.
 *
 * The GD Runtime does not generate assertions
 * for transient conditions, but only for apparent programming errors in the
 * application. Consequently, these assertions are only
 * expected when the application is in development, and not when the application
 * is in production. The failure message of the
 * assertion will describe the programming error.
 *
 * The recommended approach is that the application should be allowed to
 * terminate, so that the failure message can be read
 * on the console.
 * The failure message will describe the programming error, which can then be
 * corrected.
 * For example, a message like the following could be seen in the logs:\n
 * <TT>My application [7506:40b] *** Terminating app due to uncaught exception
 * 'NSInternalInconsistencyException', reason:
 * 'Not authorized. Call [GDi</TT><TT>OS autho</TT><TT>rize] first.'</TT>
 *
 * <H4>First usage of the API in the execution cycle</H4>
 * The typical first usage of the API in the execution cycle is to initiate GD
 * authorization, in the <TT>application:didFinishLaunchingWithOptions:</TT>
 * handler. The first point in the execution cycle at which it is possible to
 * use the GD API is the invocation of the
 * <TT>application:willFinishLaunchingWithOptions:</TT> handler. The GD API
 * cannot be used prior to <TT>application:willFinishLaunchingWithOptions:</TT>
 * invocation. For example, if the application uses a subclass of
 * <TT>UIApplication</TT>, the GD API cannot be used in its <TT>init</TT>
 * method.
 * 
 * Some prior versions of the Good Dynamic SDK for iOS required a call to one of 
 * these initialization functions in some circumstances:
 * - \link GDiOS::initializeWithClassConformingToUIApplicationDelegate: initializeWithClassConformingToUIApplicationDelegate:\endlink
 * - \link GDiOS::initializeWithClassNameConformingToUIApplicationDelegate: initializeWithClassNameConformingToUIApplicationDelegate:\endlink
 * .
 * In this version of GD, these functions need never be called and are
 * deprecated.
 *
 * <H3>Activation</H3>
 * In Good Dynamics, activation refers to a number of registration procedures
 * that must be completed in order to access all platform capabilities. Once a
 * particular activation has been completed, registration credentials are stored
 * on the device. This means that each activation need only be processed once.
 *
 * Activations are generally transparent to the application. The application
 * will call a Good Dynamics authorization method, and the runtime will process
 * whichever activations are required.
 *
 * There are two activations in Good Dynamics.<DL
 * ><DT
 *     >Infrastructure activation</DT><DD
 *         >Recognition of the mobile device as a terminal by the
 *         Good Technology central server.</DD
 * ><DT
 *     >Enterprise activation</DT><DD
 *         >Association of the terminal with a provisioned end user at the
 *         enterprise. This requires the user to enter an activation key. The
 *         key can be sent to the user by email when they are provisioned, or
 *         made available through the Good Control self-service interface.</DD
 * ></DL>
 * \see \ref GC for details on how to provision a user for development purposes.
 * \see \ref enterprisesimulation for instructions on building an application to
 * run in a special limited mode in which there is no enterprise activation.
 *
 * <H3>Application identification</H3>
 * Unique Good Dynamics application identifier (GD App ID) values are used to
 * identify GD mobile applications. GD App ID values are used in the mobile
 * application, and in the management user interface at the enterprise, the Good
 * Control console. The GD App ID is generally accompanied by a separate GD
 * Application Version.
 *
 * In the mobile application, the GD App ID and version values are set by the
 * authorization call, as documented in the <TT>authorize</TT> function
 * reference, below. In the Good Control console, the GD App ID and version
 * values are entered as part of application registration, see the \ref GC.
 *
 * <H4>Good Dynamics Application Identifier</H4>
 * GD App IDs are textual and follow a typical naming convention. The reversed
 * Internet domain of the application developer forms the initial part of the GD
 * App ID. For example, applications developed by Good Technology have IDs that
 * begin "com.good." since Good Technology owns the good.com domain.
 *
 * The rest of the ID is made up of the application's name, possibly preceded by
 * a number of categories and sub-categories. Categories and sub-categories are
 * separated by full stops. For example, the ID of an example Good Dynamics
 * remote database application, made by Good Technology, could be:
 * "com.good.gd.examples.remotedb".
 *
 * Formally, the syntax of a GD App ID is a string that:
 * - Contains only the following ASCII characters: hyphen (dash), full stop
 *   (period), numeric digit, lower-case letter.
 * - Conforms to the &lt;subdomain&gt; format initially defined in section 2.3.1
 *   of <A
 *      HREF="http://www.ietf.org/rfc/rfc1035.txt"
 *      target="_blank"
 *   >RFC1035</A> and subsequently modified in section 2.1 of <A
 *      HREF="http://www.ietf.org/rfc/rfc1123.txt"
 *      target="_blank"
 *   >RFC1123</A>.
 * .
 *
 * <H4>Good Dynamics Application Version</H4>
 * A GD Application Version value is a string made up of a sequence of numbers
 * separated by full stops (periods). The following represents best practice.
 * - The first release of the application should have "1.0.0.0" as its GD
 *   Application Version.
 * - The version string should change in subsequent releases in which one of the
 *   following software changes is made:
 *   - The application starts to provide a new shared service or shared service
 *     version.
 *   - The application stops providing a shared service or shared service
 *     version.
 *   .
 *   Otherwise, version should not change in the release.
 * .
 *
 * See the   \link GDService GDService class reference\endlink for details of shared services.
 *
 * The syntax rules of the GD Application Version value are as follows.
 * - A version string consists of one to four version numbers separated by full
 *   stop (period) characters.
 * - A version number consists of one of the following:
 *   - A single zero.
 *   - A sequence of up to three digits with no leading zero.
 *   .
 * .
 * The syntax can be formally expressed as the following regular expression:
 * <TT>(0|[1-9][0-9]{0,2})(.(0|[1-9][0-9]{0,2})){0,3}</TT>
 * 
 * Do not use a different GD Application Version for an early access or beta
 * software release. Instead, add a suffix to the GD App ID and native
 * application identifier used for general access. For example, the GD App ID
 * "com.example.gdapp.beta" could be used to identify a "com.example.gdapp" beta
 * release.\n
 * Using a different native identifier makes it possible for general access and
 * early access software to be installed on the same mobile device, and
 * facilitates use of different signing certificates.
 *
 * <H3>Application user interface restrictions</H3>
 * The Good Dynamics Runtime monitors the application user interface in order to
 * enforce a number of enterprise security policies. For example, there may be a
 * policy that the user must always enter their security password when the
 * application makes the transition from background to foreground. There may
 * also be a policy that the user interface must be locked after a period of
 * inactivity.
 *
 * The application user interface must observe a number of restrictions in order
 * to enable monitoring by the Good Dynamics Runtime.
 *
 * The application must use the \link GDiOS::getWindow getWindow (GDiOS)\endlink function instead
 * of creating a new <TT>UIWindow</TT> object.
 *
 * The application must close any open modal dialogs when entering background.
 * This includes, for example, any <TT>UIAlertView</TT> messages that are open.
 * This can be done in the <TT>applicationDidEnterBackground:</TT> handler, by
 * calling the <TT>dismissWithClickedButtonIndex:</TT> method of the view
 * controller.
 *
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIAlertView_Class/UIAlertView/UIAlertView.html"
 *     target="_blank"
 * >UIAlertView class reference in the iOS Developer Library on apple.com</A>
 *
 *  \htmlonly <div class="bulletlists"> \endhtmlonly
 *
 * <H3>Build-Time Configuration</H3>
 * See the \ref BuildTimeConfiguration page.
 *
 * <H3>Enterprise Configuration Information</H3>
 * There are a number of functions in this class for obtaining enterprise
 * configuration information, including settings that apply to the current end
 * user. The \link GDiOS::getApplicationPolicy getApplicationPolicy (GDiOS)\endlink and
 * \link GDiOS::getApplicationConfig getApplicationConfig (GDiOS)\endlink functions are examples of this
 * type of function.
 *
 * All the functions of this type:
 * - Return their results in a collection of objects.
 * - Have a corresponding \link GDAppEvent GDAppEvent\endlink event type that is
 *   dispatched to the application's \link GDiOSDelegate GDiOSDelegate\endlink instance when
 *   the result would change.
 * .
 *
 * For example, the \link GDiOS::getApplicationPolicy getApplicationPolicy (GDiOS)\endlink function returns 
 * an <TT>NSDictionary</TT>
 * collection. When there is a change,
 * a <TT>GDAppEventPolicyUpdate</TT> event is dispatched.
 *
 * Use these functions as follows:
 * -# Make a first call to get an initial collection.
 * -# Retain the collection, and refer to it in any code that utilizes its
 *    values.
 * -# When the update event is received, discard the retained collection and
 *    call the function again to get a new collection.
 * .
 *
 * Do not make a subsequent call to the same function until an update event
 * has been received. The GD Runtime generates a new collection for each call to
 * one of these functions. If the application code makes multiple calls and
 * retains all the returned collections, then they will all consume memory or
 * other application resources.
 * 
 *  <H2>Code Snippets</H2> The following code snippets illustrate some common tasks.
 * <H3>Authorization</H3>
 * The following snippet shows initiation of Good Dynamics authorization.
 * \code
 * [GDiOS sharedInstance].delegate = self;
 * [[GDiOS sharedInstance] authorize];
 * \endcode
 * After executing the above code, the application would wait for its delegate
 * callback to be invoked. The invocation would have an event type of
 * <TT>GDAppEventAuthorized</TT> if the user was authorized. After that, the
 * application could make full use of all Good Dynamics capabilities.
 *
 * The above code relies on the identification parameters being in the
 * Info.plist file, as shown in the following snippet.
 * \code
 * <key>GDApplicationID</key>
 * <string>com.example.browser</string>
 * <key>GDApplicationVersion</key>
 * <string>1.0.0.0</string>
 * \endcode
 * The above is an extract from the XML of the application's Info.plist file.
 * The extract sets "com.example.browser" as the GD application ID, and
 * "1.0.0.0" as the GD application version.
 *
 * <H3>User interface pre-initialization</H3>
 * The following snippet shows some necessary steps that precede initialization
 * of the application's user interface. The recommended place in the code for
 * these steps is as shown in the snippet.
 * \code
 *
 * @synthesize window;
 *
 * - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 * { 
 *     GDiOS *gdiOS = [GDiOS sharedInstance];
 *     self.window = [gdiOS getWindow];
 *     gdiOS.delegate = self;
 *     started = NO;
 *     // Following line will cause the GD Runtime user interface to open.
 *     [gdiOS authorize];
 *     return YES;
 * }
 * \endcode
 *
 * The above snippet shows the following sequence of actions.
 * -# A reference to the GDiOS singleton object is obtained.
 * -# The application sets its window to be the <TT>UIWindow</TT> of the Good
 *    Dynamics Runtime.
 * -# The current class is set as the delegated event handler.
 * -# The <TT>started</TT> flag is set, to control initialization of the
 *    application's user interface, which is covered in the following snippet.
 *    The flag's declaration (not shown) would be <TT>BOOL</TT>.
 * -# The application initiates Good Dynamics authorization.
 * .
 * Authorization processing is asynchronous. On completion, an event will be
 * dispatched to the application's handler. The application completes user
 * interface initialization within its event handler, as shown in the following
 * code snippet.
 *
 * <H3>User interface initialization</H3>
 * The following snippet shows the recommended place in the code to initialize
 * the application's user interface.
 * \code
 *
 * -(void)handleEvent:(GDAppEvent*)anEvent
 * {
 *     switch (anEvent.type) {
 *         case GDAppEventAuthorized: {
 *             if (!started) {
 *                 [self initializeUI];
 *                 started = YES;
 *             }
 *             break;
 *         }
 *
 *         case GDAppEventNotAuthorized: {
 *             [self onNotAuthorized:anEvent];
 *             break;
 *         }
 *
 *         case GDAppEventRemoteSettingsUpdate:
 *         case GDAppEventServicesUpdate:
 *         case GDAppEventPolicyUpdate:
 *         default: {
 *             // This application ignores other types of event.
 *             break;
 *         }
 *     }
 * }
 * \endcode
 * The above code shows a simple GD Event Handler.
 *
 * The handler calls the application's own <TT>initializeUI</TT> function
 * when a <TT>GDAppEventAuthorized</TT> event is received for the first time.
 * The application's <TT>started</TT> flag is used to control first-time
 * execution. Initialization of this flag is shown in the previous snippet.\n
 * The <TT>initializeUI</TT> function would complete user interface
 * initialization, utilizing a reference to the Good Dynamics runtime's
 * <TT>UIWindow</TT>.
 * The previous snippet shows how the reference can be obtained.
 *
 * The handler calls the application's own <TT>onNotAuthorized</TT> function
 * whenever a <TT>GDAppEventNotAuthorized</TT> event is received.
 */
@interface GDiOS : NSObject {
    id<GDiOSDelegate> delegate;
    NSDictionary* launchOptions;
}

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_INITWITHCLASSNAMECONFORMINGTOUIAPPDELEGATE __attribute__((deprecated("Not required.")))
#else
#   define DEPRECATE_INITWITHCLASSNAMECONFORMINGTOUIAPPDELEGATE __attribute__((deprecated))
#endif

+ (void)initializeWithClassNameConformingToUIApplicationDelegate:(NSString*)applicationDelegate DEPRECATE_INITWITHCLASSNAMECONFORMINGTOUIAPPDELEGATE;
/**< Enable early authorization by specifying a class name (deprecated).
 * \deprecated This function has been deprecated and will be removed in a future
 * release. In some earlier versions of the GD SDK for iOS it was sometimes
 * necessary to call an initialization function like this one to allocate
 * resources for the GD Runtime. Resource allocation is now always automatic so
 * this function is no longer required.
 *
 * \param applicationDelegate <TT>NSString</TT> containing the name of the
 * application class that conforms to <TT>UIApplicationDelegate</TT>.
 */

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_INITWITHCLASSCONFORMINGTOUIAPPDELEGATE __attribute__((deprecated("Not required.")))
#else
#   define DEPRECATE_INITWITHCLASSCONFORMINGTOUIAPPDELEGATE __attribute__((deprecated))
#endif

+ (void)initializeWithClassConformingToUIApplicationDelegate:(Class<UIApplicationDelegate>)applicationDelegate DEPRECATE_INITWITHCLASSCONFORMINGTOUIAPPDELEGATE;
/**< Enable early authorization by specifying a class (deprecated).
 * \deprecated This function has been deprecated and will be removed in a future
 * release. In some earlier versions of the GD SDK for iOS it was sometimes
 * necessary to call an initialization function like this one to allocate
 * resources for the GD Runtime. Resource allocation is now always automatic so
 * this function is no longer required.
 *
 * \param applicationDelegate The application <TT>Class</TT> that conforms to
 * <TT>UIApplicationDelegate</TT>.
 */

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_ISINITIALIZED __attribute__((deprecated("Not required.")))
#else
#   define DEPRECATE_ISINITIALIZED __attribute__((deprecated))
#endif

+ (BOOL)isInitialized DEPRECATE_ISINITIALIZED;
/**< Get the Good Dynamics interface object's initialization status
 *   (deprecated).
 * \deprecated This function has been deprecated and will be removed in a future
 * release. In some earlier versions of the GD SDK for iOS it was sometimes
 * necessary to check the initialization status of the Good Dynamics interface.
 * Initialization is now always automatic so this function is no longer
 * required.
 *
 * \return <TT>YES</TT> always.
 */

+ (GDiOS*)sharedInstance;
/**< Get a reference to the Good Dynamics interface object.
 * This function returns a reference to the Good Dynamics
 * interface object.
 * This function can be called in the
 * <TT>application:didFinishLaunchingWithOptions:</TT> handler of the
 * application.
 *
 * The Good Dynamics interface object is a "singleton class".
 *
 * \return Reference that can be used to call, for example, \link GDiOS::authorize: authorize (GDiOS)\endlink.
 */

- (void)authorize:(id<GDiOSDelegate>)aDelegate;
/**< Connect to the Good Dynamics infrastructure.
 * Call this function to initiate GD authorization
 * processing.
 *
 * 
 * Authorization involves a number of exchanges with various servers in the
 * Good Dynamics proxy infrastructure, and may involve user interaction.
 * The following processing items are the most significant.<DL
 *
 * ><DT>Infrastructure activation</DT><DD
 * >The Good Dynamics Runtime registers the device as a terminal with the Good
 * Technology Network Operation Center (NOC). The NOC issues registration
 * credentials, which are encrypted and stored on the device. Infrastructure
 * activation is not processed if registration credentials are already
 * present.</DD
 *
 * ><DT>Enterprise activation</DT><DD
 * >Enterprise activation is the completion of the Enterprise Provisioning
 * process, which begins on the enterprise's Good Control server.
 * During enterprise provisioning, an activation key will have been made
 * available to the end user, either by email or in the Good Control
 * self-service interface. During enterprise activation, the user enters
 * the activation key, in a Good Dynamics Runtime user interface. The
 * runtime then sends the key to the NOC. If the key is recognized, the device
 * is registered as being associated with the provisioning enterprise.
 * Enterprise registration credentials are then issued, and encrypted and stored
 * on the device.\n
 * Enterprise activation is not processed if enterprise registration
 * credentials are already present.\n
 * Note that successful enterprise activation has the effect of consuming the
 * activation key. This will be the case even if a later stage of authorization
 * processing fails, or if the user is found to be not entitled to this
 * application.</DD
 *
 * ><DT>Entitlement checking</DT><DD
 * >The enterprise that provisioned the end user can later withdraw the
 * user's entitlement to the application. Withdrawal is flagged in the
 * enterprise's Good Control server.
 * The Good Dynamics Runtime checks the end user's ongoing entitlement to the
 * application every time authorization is processed. (In addition, withdrawal
 * may be notified to the runtime by the Good Dynamics NOC.)\n
 * In the Good Control (GC) console, entitlement is given to particular
 * versions of particular applications. The version and GD App ID values must
 * match exactly with a version and GD App ID to which the user has been given
 * entitlement in the GC console. If there is not an exact match, then user
 * entitlement is assumed to have been withdrawn.\n
 * If the user is found not to be entitled, then the Good Dynamics container
 * will be wiped of all application data and authentication credentials.</DD
 *
 * ><DT>Policy update</DT><DD
 * >Policies govern many aspects of the Good Dynamics user experience. For
 * example, the minimum characteristics of the end user's security password with
 * respect to length and types of character are governed by a
 * Good Dynamics policy. So is the need for the end user to set a security
 * password.
 * The Good Dynamics Runtime checks for and retrieves updated policies
 * every time authorization is processed.</DD
 *
 * ><DT>Policy checking</DT><DD
 * >The Good Dynamics Runtime checks for compliance with the most up-to-date
 * policies every time authorization is processed.</DD
 *
 * ><DT>Configuration retrieval</DT><DD
 * >The Good Dynamics Runtime retrieves a set of application configuration
 * settings from the enterprise Good Control server during authorization
 * processing. These will have been entered in the Good Control console.
 * See under \link GDiOS::getApplicationConfig getApplicationConfig (GDiOS)\endlink for a list of settings.</DD
 *
 * ><DT>Unlock secure store</DT><DD
 * >The Good Dynamics secure store is unlocked during authorization. If the
 * store is protected by an end-user password, then the user must enter their
 * password for authorization processing to complete. Password entry is a Good
 * Dynamics Runtime user interface.</DD
 * ></DL>
 * Note that Good Dynamics Runtime user interfaces, such as Enterprise
 * activation and Password entry, are opened and closed as needed, without
 * reference to the application.
 *
 * This function can be called in the
 * <TT>application:didFinishLaunchingWithOptions:</TT> handler of the
 * application.
 *
 * This function must be called before any of the principal Good Dynamics
 * API functions.
 *
 * Data communication during authorization processing does not go via
 * the proxy specified in the device's native settings, if any.
 *
 * \param aDelegate Reference to the delegated event handler, typically
 * <TT>self</TT>.
 *
 * Application identification parameters will be read from the following properties
 * in the application Info.plist fi<TT></TT>le:<TABLE
 *     ><TR><TH>Key</TH><TH>Type</TH><TH>Value</TH
 *     ></TR><TR><TD
 *         ><TT>GDApplicationID</TT></TD
 *         ><TD><TT>String</TT></TD
 *         ><TD>Good Dynamics Application ID (GD App ID)
 *
 *         GD App ID is used to control access to the application by end users,
 *         and to configure its application server connections. The value passed
 *         must be the same as that entered when the application was registered
 *         in the enterprise's Good Control console. (Note that the value need
 *         not be the same as the native application identifier.)
 *
 *         For syntax details see under Application Identification, above.</TD
 *     ></TR><TR><TD
 *         ><TT>GDApplicationVersion</TT></TD
 *         ><TD><TT>String</TT></TD
 *         ><TD>Good Dynamics application version number
 *
 *         The version number can be combined with the GD App ID, above, to
 *         control access to particular versions of the application.</TD
 *     ></TR
 * ></TABLE>
 * (In case there are multiple Info.plist files, check that the correct one has
 * been edited by opening the Info tab of the application target being built.
 * The settings should appear there.)
 * 
 * Authorization is asynchronous. When authorization processing completes,
 * the delegate \link GDiOSDelegate::handleEvent: handleEvent\endlink callback
 * is invoked.
 *
 * For instructions on how to set up applications and users for development
 * purposes, see \ref GC and \ref enterprisesimulation.
 */

- (void)authorize;
/**< Connect to the Good Dynamics infrastructure, without specifying a delegate.
 * Call this function to initiate Good Dynamics authorization processing without
 * specifying a delegated event handler. This style of call should only be used
 * after setting the <TT>delegate</TT> property directly.

 * Calling this function is equivalent to calling the <TT>authorize:</TT>
 * function, above, after having set the <TT>delegate</TT> property directly.
 * 
 * See  \link GDiOS::authorize: authorize (GDiOS)\endlink for details.
 */

- (void)programmaticAuthorize:(NSString *)userID  withAccessKey:(NSString *)accessKey;
/**< Initiate programmatic activation.
 * Call this function to
 * initiate programmatic activation.
 * Programmatic activation can only be utilized by applications
 * that can obtain credentials for enterprise activation on behalf of the end
 * user. The credentials are passed as parameters to this function.
 *
 * Calling this function also initiates authorization processing, as if the
 *  \link GDiOS::authorize: authorize (GDiOS)\endlink function had
 * been called.
 *
 * Only call this function after checking that the application is not
 * already activated, by
 * accessing the \link GDiOS::activationComplete activationComplete (GDiOS)\endlink property.
 * 
 * \param userID <TT>NSString</TT> containing the user ID, an enterprise activation
 *               credential.
 * \param accessKey <TT>NSString</TT> containing the access key, an enterprise
 *                  activation credential.
 */

@property (assign, readonly, getter=isActivated) BOOL activationComplete;
/**< Application activation status.
 * Read the value of this property, using the <TT>isActivated</TT> accessor, to
 * check whether the application has already been activated. It is necessary to
 * check whether the application has been activated before initiating
 * programmatic activation.
 *
 * This property has the value:
 * - <TT>YES</TT> if the application has been activated.
 * - <TT>NO</TT> otherwise.
 * .
 */

- (NSDictionary*)getApplicationConfig;
/**< Get application configuration and other settings from the enterprise.
 * This function returns a collection of application configuration
 * and other settings. The settings will have been made in the enterprise Good
 * Control (GC) server, and retrieved by the Good Dynamics Runtime.
 *
 * Retrieval of configuration settings may happen during authorization
 * processing, or whenever settings are changed on the GC. When changed settings
 * have been retrieved by the runtime, a <TT>GDAppEventRemoteSettingsUpdate</TT>
 * event will be dispatched to the application. See the
 * \link GDAppEvent GDAppEvent\endlink class reference for details, and see the notes
 * under the Enterprise Configuration Information heading, above.
 *
 * Note that retrieval is <EM>not </EM>triggered by calling this function.
 *
 * \return <TT>NSDictionary</TT>
 * object containing configuration values. Use the <TT>GDAppConfigKey</TT>
 * constant strings as keys. Any of the following configuration settings may be
 * present:<TABLE
 *     ><TR
 *         ><TH>Key Constant</TH
 *         ><TH>Setting</TH
 *         ><TH>Type</TH
 *
 *     ></TR><TR><TD
 *         ><TT>GDAppConfigKeyServers</TT></TD
 *     ><TD
 *         >Application server configuration.\n
 *         A number of servers can be configured for an application. This
 *         configuration is entered in the GC console, in the application
 *         management user interface.\n
 *         See the \link GDAppServer
 *         GDAppServer class reference\endlink for documentation of the details
 *         that are returned for each configured server.</TD
 *     ><TD
 *         ><TT>NSArray</TT> of
 *         <TT>GDAppServer</TT></TD
 *
 *     ></TR><TR><TD
 *         ><TT>GDAppConfigKeyHost</TT> (deprecated&nbsp;*)</TD
 *     ><TD
 *         >Application server address.\n
 *         An application server address can be entered in the GC console,
 *         in the application management user interface.</TD
 *     ><TD><TT>NSString</TT></TD
 *
 *     ></TR><TR><TD
 *         ><TT>GDAppConfigKeyPort</TT> (deprecated&nbsp;*)</TD
 *     ><TD
 *         >Application server port number.\n
 *         An application port number can also be entered in the GC console,
 *         in the application management user interface.</TD
 *     ><TD
 *         ><TT>NSNumber</TT></TD
 *
 *     ></TR><TR><TD
 *         ><TT>GDAppConfigKeyConfig</TT></TD
 *     ><TD
 *         >Application-specific configuration data.\n
 *         As well as the application server details, above, a free
 *         text can also be entered in the GC console.
 *         Whatever was entered is passed through by the runtime and made
 *         available to the application code here.</TD
 *     ><TD><TT>NSString</TT></TD
 *
 *     ></TR><TR><TD
 *         ><TT>GDAppConfigKeyCopyPasteOn</TT> (deprecated)</TD
 *     ><TD
 *         ><TT>GDAppConfigKeyCopyPasteOn</TT> key is deprecated and will be removed in a future release. The recommended way to
 *         access the Data Leakage policy indicator is to use the <TT>GDAppConfigKeyPreventDataLeakageOut</TT> value.\n</TD
 *
 *     ></TR><TR><TD
 *         ><TT>GDAppConfigKeyPreventDataLeakageOut</TT></TD
 *     ><TD
 *         >Data Leakage policy indicator.\n
 *         1 means that enterprise security
 *         policies require that the end user must be prevented from taking any
 *         action that is classified as data loss or data leakage in the Good
 *         Dynamics Security Compliance Requirements document.\n
 *         0 means that the above policy is <EM
 *         >not</EM> in effect, so the user is permitted to take those
 *         actions.</TD
 *     ><TD
 *         ><TT>NSNumber</TT></TD
 *
 *     ></TR><TR><TD
 *         ><TT>GDAppConfigKeyPreventDataLeakageIn</TT></TD
 *     ><TD
 *         >Data Leakage policy indicator.\n
 *         1 means that enterprise security
 *         policies require that the end user must be prevented from taking any
 *         action that will lead to copying data into a Good Dynamics Secure application
 *         from any other external non enterprise application on the device.\n
 *         0 means that the above policy is <EM
 *         >not</EM> in effect, so the user is permitted to take those
 *         actions.</TD
 *     ><TD
 *         ><TT>NSNumber</TT></TD
 *
 *     ></TR><TR><TD
 *         ><TT>GDAppConfigKeyDetailedLogsOn</TT></TD
 *     ><TD
 *         >Logging level.\n
 *         0 means that the logging level is
 *         low, and only minimal logs should be written.\n
 *         1 means that the logging level is
 *         high, and detailed logs should be written. Detailed logs facilitate
 *         debugging of runtime issues.\n
 *         The Good Dynamics Runtime will automatically adjust its logging
 *         according to the configured setting.
 *         The setting is present in the API so that the application can adjust
 *         its logging consistently with the runtime.</TD
 *     ><TD
 *         ><TT>NSNumber</TT></TD
 *
 *     ></TR><TR><TD
 *         ><TT>GDAppConfigKeyUserId</TT></TD
 *     ><TD
 *         >Enterprise user identifier, typically email address.\n
 *         An enterprise identifier for the end user is one of the credentials
 *         required for initial activation of a GD application. This could be
 *         the email address entered in the GD activation user interface when
 *         the application was run for the first time, for example.\n
 *         The value obtained for this setting will initially be the enterprise
 *         email address, or other identifier, used for activation. If the
 *         enterprise email address of the end user changes after activation
 *         then the value of this setting will also change, next time it is
 *         obtained.</TD
 *     ><TD><TT>NSString</TT></TD
 *
 *     ></TR><TR><TD
 *         ><TT>GDAppConfigKeyUserPrincipalName</TT></TD
 *     ><TD
 *         >User Principal Name.\n
 *         The User Principal Name (UPN) will have been retrieved from the
 *         enterprise Active Directory (AD) service by the enterprise GC, and
 *         then sent to the GD Runtime, initially at activation time. This value
 *         will only be present if the current end user corresponds to an AD
 *         entry. The value may or may not be the same as the
 *         <TT>GDAppConfigKeyUserId</TT> value, depending on enterprise domain
 *         configuration.\n
 *         The value will be in
 *         <TT><EM>username</EM>\@<EM>fully.qualified.domain.name</EM></TT>
 *         format.\n
 *         If the UPN of the end user changes after activation then the value of
 *         this setting will also change, next time it is obtained.</TD
 *     ><TD><TT>NSString</TT></TD
 *
 *     ></TR
 * ></TABLE
 * >* The <TT>GDAppConfigKeyHost</TT> and <TT>GDAppConfigKeyPort</TT> keys are
 * deprecated and will be removed in a future release. The recommended way to
 * access application server configuration is to use the
 * <TT>GDAppConfigKeyServers</TT> value, which returns a list. For backward
 * compatibility, the deprecated values will be populated with details for the
 * first server of the highest priority.
 *
 * \par Data Leakage Policy Enforcement
 * Security policies other than the Data Leakage policy (DLP) mentioned in the
 * above are enforced by the Good Dynamics Runtime, without reference to the
 * application. DLP must generally be enforced by the application, with some
 * exceptions.\n
 * If DLP is switched on, the Good Dynamics Runtime will:<UL
 * ><LI
 *     >Secure general cut-copy-paste operations by the user.</LI
 * ><LI
 *     >Secure data written to the general pasteboard by content-rendering
 *     <TT>UIKit</TT> components.</LI
 * ></UL
 * >Secure cut-copy-paste operations allow the user to copy and move data via
 * the clipboard only:
 * - Within one Good Dynamics application.
 * - Between Good Dynamics applications that were activated for the same end
 *   user from the same enterprise Good Control server.
 * .
 * Other aspects of data leakage must be enforced by the application.\n
 * Note that pasteboards other than the general pasteboard, i.e.
 * programmatically created <TT>UIPasteboard</TT> instances, are never secured
 * by the Good Dynamics Runtime.\n
 * 
 * \par Application Server Selection
 * The <TT>GDAppConfigKeyServers</TT> value will contain a list of the servers
 * that have been configured for the application in the GC console. In the case
 * that more than one server has been configured, the recommended selection
 * algorithm is as follows:
 * -# For each priority value in the list, starting with the highest:
 * -# Select a server that has that priority, at random.
 * -# Attempt to connect to the server.
 * -# If connection succeeds, use that server.
 * -# If connection fails, try another server at the same priority, at random.
 * -# If there are no more untried servers at that priority, try the servers at
 *    the next lower priority.
 * .
 * 
 * \see \ref GC
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSDictionary_Class/"
 *     target="_blank"
 * >NSDictionary class reference</A> in the iOS Developer Library on apple.com
 * \see The GD-Secure compliance document.
 */

- (NSDictionary*)getApplicationPolicy;
/**< Get application-specific policy settings from the Good Control server, as a
 * collection.
 * 
 * This function returns a collection of application-specific policy
 * settings.
 * The settings will have been entered in the Good Control (GC) console, and
 * retrieved by the Good Dynamics Runtime.
 *
 * For more documentation of the feature and how application policies are
 * defined, see the \ref AppPolicies documentation.
 * 
 * Retrieval of policy settings may happen during authorization
 * processing, or whenever settings are changed on the GC.
 * When changed settings have been retrieved by the runtime, a
 * <TT>GDAppEventPolicyUpdate</TT> event will be dispatched to the
 * application. See the \link GDAppEvent GDAppEvent\endlink class reference for details,
 * and see the notes under the Enterprise Configuration Information heading,
 * above.
 *
 * Note that retrieval is <EM>not </EM>triggered by calling this function.
 * 
 * \return <TT>NSDictionary</TT>
 * containing policy settings.
 * The keys will be the same as the settings identifiers in the policy
 * definition. The values will be the particular values that apply to the end
 * user. The value types are mapped from the definition as follows:<TABLE
 *  ><TR
 *      ><TH>Definition Type</TH><TH>Dictionary Value Type</TH
 *
 *  ></TR><TR><TD>null</TD><TD><TT>nil</TT></TD
 *
 *  ></TR><TR><TD
 *      >boolean</TD><TD><TT>NSNumber</TT></TD
 *
 *  ></TR><TR><TD
 *      >double</TD><TD><TT>NSNumber</TT></TD
 *
 *  ></TR><TR><TD
 *      >int</TD><TD><TT>NSNumber</TT></TD
 *
 *  ></TR><TR><TD
 *      >object</TD><TD><TT
 *          >NSDictionary</TT></TD
 *
 *  ></TR><TR><TD
 *      >array</TD><TD><TT>NSArray</TT></TD
 *
 *  ></TR><TR><TD>string</TD><TD><TT>NSString</TT></TD
 *
 * ></TR
 * ></TABLE>
 * \see \link GDiOS::getApplicationPolicyString getApplicationPolicyString (GDiOS)\endlink
 */

- (NSString*)getApplicationPolicyString;
/**< Get application-specific policy settings from the Good Control server, as
 * JSON.
 *  
 * This function returns application-specific policy settings in a JSON
 * string.
 * The settings will have been entered in the Good Control (GC) console, and
 * retrieved by the Good Dynamics Runtime.
 * 
 * For more documentation of the feature and how application policies are
 * defined, see the \ref AppPolicies documentation.
 *
 * Retrieval of policy settings may happen during authorization
 * processing, or whenever settings are changed on the GC.
 * When changed settings have been retrieved by the runtime, a
 * <TT>GDAppEventPolicyUpdate</TT> event will be dispatched to the
 * application. See the \link GDAppEvent GDAppEvent\endlink class reference for details,
 * and see the notes under the Enterprise Configuration Information heading,
 * above.
 *
 * Note that retrieval is <EM>not </EM>triggered by calling this function.
 * 
 * \return <TT>NSString</TT> containing policy settings in a JSON string.
 * The string will evaluate to an object with an attribute for each
 * application-specific setting. The names of the attributes will be the same as
 * the settings identifiers in the policy definition.
 * The attribute values will be the particular values that apply to the end user.
 * \see \link GDiOS::getApplicationPolicy getApplicationPolicy (GDiOS)\endlink
 */

- (NSArray*)getServiceProviders;
/**< Get providers of shared services.
 * This function returns a list of all available providers of
 * shared services. The list contains both application-based and server-based
 * service providers.
 *
 * The returned list is based on the GD Application Identifier (GD App ID)
 * configuration in the enterprise Good Control (GC) server and in the central
 * GD Catalog. The list includes an entry for each GD App ID and version pair
 * that meets all the following conditions:
 * - The GD App ID and version is registered as the provider of one or more
 *   shared services. Registrations are stored in the enterprise GC or in the
 *   GD Catalog.
 * - The end user of the current application is entitled to the GD App ID and
 *   version. Entitlements are stored in the enterprise GC only.
 * - For application-based service providers, the mobile application has been
 *   installed and activated for the same end user, and on the same mobile
 *   device, as the current application.
 * .
 *
 * On devices running iOS version 9 or later, the list could include providers
 * of application-based services that were installed and activated as above, but
 * then uninstalled. An attempt to send a service request to an application that
 * is not currently installed results in a
 * <TT>GDServicesErrorApplicationNotFound</TT> error.
 *
 * The GD Catalog is a server within the GD infrastructure. Developers may
 * register their GD applications as providers of one or more shared services.
 * Registration of the services provided by a GD application can be carried out
 * in the enterprise GC console user interface, or on the Good Developer Network website.
 * Registrations are then stored in the GD Catalog. The creation of individual
 * shared service definitions is also carried out in the enterprise GC or in the
 * Good Developer Network website.
 * 
 * The GD Runtime retrieves the information used to generate the list of
 * service providers from the GD Catalog, and from the enterprise GC server.
 * Retrieval can take place when the application is authorized, or when another
 * application activates on the same device, or when the configuration is
 * changed in the enterprise GC. Note that retrieval is <EM>not </EM>triggered
 * by calling this function.
 * 
 * For each GD App ID and version that satisfies the conditions, this
 * function returns a \link GDServiceProvider GDServiceProvider\endlink object.
 * 
 * The returned details for an application-based provider can be used to send a
 * service request to the service provider using Good Inter-Container
 * Communication. See the   \link GDService GDService class reference\endlink for details of the API. See
 * under Service Provider Requirements on that page for information on service
 * provider registration, which is a prerequisite for an application to be on
 * the list returned by this function.
 *
 * The returned details for a server-based provider can be used to establish
 * HTTP or TCP socket communications with a server instance.
 * 
 * \return <TT>NSArray</TT> of <TT>GDServiceProvider</TT
 *         > objects containing the list of available service providers. The
 *         order of objects in the list is not specified.
 * 
 * A single service could have multiple providers. A single provider could
 * provide multiple services, and multiple versions of services.
 *
 * When changed details have been retrieved by the runtime, a
 * <TT>GDAppEventServicesUpdate</TT> event will be dispatched to the
 * application. See the \link GDAppEvent GDAppEvent\endlink class reference for details,
 * and see the notes under the Enterprise Configuration Information heading,
 * above.
 * 
 * <H4>Icon images</H4>
 * The objects returned by this function can include icon images for service
 * provider applications. Utilization of icon images is optional. If the
 * application does utilize icon images, then make a setting in the
 * application's Info.plist file* as follows:
 * - Key: <TT>GDFetchResources</TT>
 * - Type: <TT>Boolean</TT>
 * - Value: <TT>YES</TT>
 * .
 * (*In case there are multiple Info.plist files, check that the correct one has
 * been edited by opening the Info tab of the application target being built.
 * The setting just made should appear there.)
 * 
 * If the setting is missing or the value is <TT>NO</TT>, this indicates that
 * the application does not utilize icon images.
 *
 * The data for icon images would be retrieved by the GD Runtime, from a GD
 * Catalog service. Good Technology may switch off the icon image service at the
 * GD Catalog from time to time, for operational reasons. If the icon image
 * service is switched off then all icon images in the returned objects will be
 * <TT>nil</TT>.
 */

- (NSArray*)getServiceProvidersFor:(NSString*)serviceId andVersion:(NSString*)version andType:(GDServiceProviderType)serviceProviderType;
/**< Discover providers of a specific shared service.
 * This function returns a list of the available providers of a
 * specified service.
 *
 * The returned list is based on the GD Application Identifier (GD App ID)
 * configuration in the enterprise Good Control (GC) server and in the central
 * GD Catalog. The list includes an entry for each GD App ID and version pair
 * that meets all the following conditions:
 * - The GD App ID and version pair would be returned by the
 *   \link GDiOS::getServiceProviders getServiceProviders (GDiOS)\endlink function, see above.
 * - The pair has been registered as a provider of the specified service.
 * - The pair has been registered as a provider of the service version, if
 *   specified.
 * - The pair has been registered as a provider of the specified service type.
 * .
 *
 * 
 * \param serviceId <TT>NSString</TT> specifying the ID of the required service.
 *
 * \param version <TT>NSString</TT> specifying the required version of the service, or
 *                <TT>nil</TT> to leave unspecified.
 *
 * \param serviceProviderType <TT>GDServiceProviderType</TT> value specifying
 *                            the required type of service.
 * 
 * \return <TT>NSArray</TT> of <TT>GDServiceProvider</TT
 *         > objects containing the list of available service providers. The
 *         order of objects in the list is not specified.
 *
 * See also the note on Icon images in the <TT>getServiceProviders</TT>
 * function documentation, above.
 */

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_GETAPPLICATIONDETAILSFORSERVICE __attribute__((deprecated("Use getServiceProvidersFor:andVersion:andType:")))
#else
#   define DEPRECATE_GETAPPLICATIONDETAILSFORSERVICE __attribute__((deprecated))
#endif

- (NSArray*)getApplicationDetailsForService:(NSString*)serviceId andVersion:(NSString*)version DEPRECATE_GETAPPLICATIONDETAILSFORSERVICE;
/**< Discover application-based service providers (deprecated).
 * \deprecated This function is deprecated and will be removed in a future
 * release. Use  \link GDiOS::getServiceProvidersFor:andVersion:andType:  getServiceProvidersFor:  (GDiOS)\endlink instead.
 * 
 * Calling this function is equivalent to calling
 * <TT>getApplicationDetailsForService</TT> and specifying
 * <TT>GDServiceProviderType.GDProviderTypeClient</TT> as the
 * <TT>providerType</TT> parameter.
 */

- (NSArray*)getApplicationDetailsForService:(NSString*)serviceId andVersion:(NSString*)version andType:(GDServiceProviderType)serviceProviderType DEPRECATE_GETAPPLICATIONDETAILSFORSERVICE;
/**< Discover application-based or server-based service providers (deprecated).
 * \deprecated This function is deprecated and will be removed in a
 * future release. Use  \link GDiOS::getServiceProvidersFor:andVersion:andType:  getServiceProvidersFor:  (GDiOS)\endlink instead.
 *
 * This function returns a list of the available providers of a
 * specified service. The list contains either application-based providers or
 * server-based providers, as specified by a parameter.
 *
 * If a list of application-based providers is specified then the list includes
 * applications that meet the following conditions:
 * - Registered as a provider of the specified service in the Good Dynamics (GD)
 *   Catalog, see note below.
 * - Registered as a provider of the service version, if specified.
 * - Activated for the same end user, and on the same mobile device, as the
 *   current application.
 * .
 * If a list of server-based providers is specified then the returned list is
 * based on the GD Application Identifier (GD App ID) configuration in the
 * enterprise Good Control (GC) server. The list includes those that meet the
 * following conditions:
 * - The GD App ID has been registered as a provider of the specified service.
 * - The GD App ID has been registered as a provider of the service version, if
 *   specified.
 * - The end user of the current application is entitled to the GD App ID.
 *   Entitlement is also set up in the enterprise GC.
 * .
 * 
 * The GD Catalog is a server within the GD infrastructure. Developers may
 * register their GD applications as providers of services, which are also
 * registered in the GD Catalog. Registration of applications as service
 * providers can be carried out in the enterprise GC console user interface, or
 * on the Good Developer Network website.
 * 
 * The GD Runtime retrieves the information used to generate the list of
 * service providers from the GD Catalog, and from the enterprise GC server.
 * Retrieval can take place when the application is authorized, or when another
 * application activates on the same device, or when the application server
 * configuration is changed in the enterprise GC. Note that retrieval is <EM
 * >not </EM>triggered by calling this function.
 * 
 * For each provider that satisfies the conditions, this function returns a
 * \link GDAppDetail GDAppDetail\endlink object. If no version was specified, and there is
 * a single provider that provides more than one version of the specified
 * service, then a separate object is returned for each provided service
 * version.
 * 
 * The returned details for an application-based provider can be used to send a
 * service request to the service provider using Good Inter-Container
 * Communication. See the   \link GDService GDService class reference\endlink for details of the API. See
 * under Service Provider Requirements on that page for information on service
 * provider registration, which is a prerequisite for an application to be on
 * the list returned by this function.
 *
 * The returned details for a server-based provider can be used to establish
 * HTTP or TCP socket communications with a server instance.
 * 
 * \param serviceId <TT>NSString</TT> specifying the ID of the required service.
 *
 * \param version <TT>NSString</TT> specifying the required version of the service, or
 *                <TT>nil</TT> to list all provided versions separately.
 *
 * \param serviceProviderType <TT>GDServiceProviderType</TT> value specifying
 *                            whether to return a list of applications-based or
 *                            server-based providers.
 *
 * \return <TT>NSArray</TT> of <TT>GDAppDetail</TT>
 *         objects containing the list of available service providers. The
 *         order of objects in the list is not specified.
 * 
 * A single service could have multiple providers. A single provider could
 * provide multiple services, and multiple versions of services.
 * 
 * When changed details have been retrieved by the runtime, a
 * <TT>GDAppEventServicesUpdate</TT> event will be dispatched to the
 * application. See the \link GDAppEvent GDAppEvent\endlink class reference for details,
 * and see the notes under the Enterprise Configuration Information heading,
 * above.
 */

#undef DEPRECATE_GETAPPLICATIONDETAILSFORSERVICE

typedef void (^GDGetEntitlementVersionsForBlock) (NSArray* entitlementVersions, NSError* error);
/**< Type for getEntitlementsFor block parameter.
 * Pass a code block of this type as the <TT>block</TT> parameter to the
 * \link GDiOS::getEntitlementVersionsFor:callbackBlock:
 * getEntitlementVersionsFor:\endlink function.
 *
 * The block receives the following parameters.
 * \param entitlementVersions <TT>NSArray</TT> of \ref GDVersion objects
 *                            representing the versions of the entitlement to
 *                            which the end user is entitled if the original
 *                            call succeeded, or <TT>nil</TT> otherwise.
 * \param error <TT>NSError</TT> containing a description of the error condition
 *                               if the original call failed, or <TT>nil</TT>
 *                               otherwise.
 */

- (void)getEntitlementVersionsFor:(NSString*)identifier
                    callbackBlock:(GDGetEntitlementVersionsForBlock)block;
/**< Check whether the end user has a particular entitlement.
 * Call this function to check whether the current end user has a
 * specific entitlement. The return value is a list of entitlement versions,
 * which might be empty.
 *
 * This function can be used to check for entitlement to:
 * - A specific mobile application, identified by a GD Application Identifier
 *   (GD App ID).
 * - A more abstract entitlement, such as a feature, identified by an
 *   entitlement identifier.
 * .
 * Note that there is a single namespace and format for entitlement identifiers,
 * whether used for mobile applications or for more abstract entitlements. All
 * entitlements have versions, as well as identifiers. The syntax for
 * application identifiers and versions that is detailed above, under
 * Application Identification, applies to all types of entitlement.
 *
 * Specify the entitlement to be checked by passing its identifier as a
 * parameter. The return value will be a list:
 * - If the end user does not have the specified entitlement, the list will have
 *   zero elements.
 * - Otherwise, the list will have one element for each version to which the end
 *   user is entitled. Each element will be a
 *   \link GDVersion\endlink
 *   object.
 * .
 *
 * This function is asynchronous.
 * The result list is returned by execution of a code block. Specify the code
 * block as a parameter to this function. The result list will be passed as
 * a block parameter to the execution. If an error occurs and the entitlement
 * cannot be checked, <TT>nil</TT> will be passed instead of the list, and an
 * <TT>NSError</TT> object will be passed as a second block parameter.
 *
 * Calling this function can result in data communication with the GD
 * infrastructure.
 * 
 * \param identifier <TT>NSString</TT> containing the entitlement identifier.
 * 
 * \param block Block to execute when the lookup completes. The block receives
 *              two parameters:\n
 *              <TT>NSArray</TT> of \ref GDVersion objects representing the
 *              versions to which the end user is entitled if the original call
 *              succeeds, or <TT>nil</TT> otherwise.\n
 *              <TT>NSError</TT> object containing a numeric code for the error
 *              condition if the original call fails, or <TT>nil</TT> otherwise.\n
 *              The numeric code will be in one of the following ranges,
 *              depending on the type of error condition encountered:
 *              - 400 to 599: One or more servers involved in the check
 *                            encountered an error and the check could not be
 *                            completed.
 *              - -1 to -50: A general error occurred.
 *              .
 * 
 * \par
 * The entitlements of the end user can change, for example if the user's group
 * membership is changed at the enterprise Good Control server. The GD Runtime
 * is notified of these changes by the GD infrastructure, and dispatches a
 * <TT>GDAppEventEntitlementsUpdate</TT> event to the application. See the
 * \link GDAppEvent GDAppEvent\endlink class reference for details, and see the notes
 * under the Enterprise Configuration Information heading, above.
 */

- (UIWindow*)getWindow;
/**< Get the <TT>UIWindow</TT> for the application.
 * This function returns a reference to the <TT>UIWindow</TT> that contains
 * the core logic of the Good Dynamics Runtime. Always use this function
 * instead of creating a new <TT>UIWindow</TT> in the application.
 *
 * The Good Dynamics Runtime creates its own <TT>UIWindow</TT> in order to show
 * its user interface elements, and to track for user inactivity. The runtime
 * does not add any persistent subviews, so the application is free to add and
 * remove its own subviews on the runtime's <TT>UIWindow</TT>. For example,
 * after authorization, the application could call
 * <TT>setRootViewController</TT> to add its own <TT>UIViewController</TT> or
 * <TT>UINavigationController</TT>.
 *
 * The runtime calls <TT>makeKeyAndVisible</TT> on its <TT>UIWindow</TT> during
 * authorization processing, so the application need not do this. The
 * application must not make a different <TT>UIWindow</TT> the key window. The
 * application also must not release the runtime's <TT>UIWindow</TT> object.
 *
 * \return Reference to the Good Dynamics Runtime's <TT>UIWindow</TT>, which
 * must be used as the application's key window.
 *
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/documentation/UIKit/Reference/UIWindow_Class/"
 *     target="_blank"
 * >UIWindow class reference</A> in the iOS Developer Library on apple.com
 */

- (NSString*)getVersion;
/**< Get the Good Dynamics Runtime library version.
 * \return <TT>NSString</TT> containing the Good Dynamics Runtime library
 * version in <EM>major</EM><TT>.</TT><EM>minor</EM><TT>.</TT><EM>build</EM>
 * format.
 */

- (BOOL)showPreferenceUI:(UIViewController*)baseViewController;
/**< Open the Good Dynamics preferences user interface.
 * Call this function to show the Good Dynamics (GD) preferences user
 * interface (UI).
 * This is the UI in which the end user sets any options that are applied by
 * the runtime directly, without reference to the application. This includes,
 * for example, changing their security password.
 *
 * This function enables the GD preferences UI to be included in the
 * application's own user interface.
 *
 * \param baseViewController Reference to the navigation controller within which
 * the preferences UI is to open as a view controller.\n
 * Pass a null pointer to open the GD preferences UI as a modal view
 * controller, for example when no navigation controller is available.
 *
 * \return <TT>YES</TT> if the GD preferences UI opened OK.
 * \return <TT>NO</TT> if the preferences UI was already open, or if authorization
 *                   is delegated to another application.
 */

- (BOOL)setUIAutoRotationForPortrait:(BOOL) portrait
               andPortraitUpsideDown:(BOOL) portraitUpsideDown
                   andLandscapeRight:(BOOL) landscapeRight
                    andLandscapeLeft:(BOOL)landscapeLeft;
/**< Set autorotation for the Good Dynamics user interface.
 * Call this function to set the supported presentation orientations for
 * screens in the Good Dynamics user interface (GD UI).
 * The GD UI should be set to support the same orientations as the
 * application's own user interface, if these are different to the GD UI
 * default, see below.
 *
 * (The GD UI consists of a small number of screens, including the Enterprise
 * activation screen and the Password entry screen, see under
 * <TT>authorize</TT>, above. Some of these screens will generally appear
 * before the application's own user interface has been opened.)
 *
 * The iOS operating system recognizes four device orientations.
 * Each of these orientations may be set as supported or unsupported for GD UI
 * interface presentation. The GD UI will auto-rotate so as to be visually the
 * "right way up" when the device is placed in a supported presentation
 * orientation.
 * When the device is placed in an unsupported orientation, the GD UI does not
 * auto-rotate.
 *
 * The GD UI default orientation support settings depend on the type of device
 * in use:
 * - For iPhone devices, <TT>UIInterfaceOrientationPortrait</TT> and
 * <TT>UIInterfaceOrientationPortraitUpsideDown</TT> are supported and
 * other orientations are unsupported.
 * - For iPad devices, all orientations are supported.
 *
 * \param portrait Sets support for <TT>UIInterfaceOrientationPortrait</TT>
 * presentation orientation. <TT>YES</TT> for supported, <TT>NO</TT> for
 * unsupported.
 * \param portraitUpsideDown  Sets support for
 * <TT>UIInterfaceOrientationPortraitUpsideDown</TT> presentation orientation.
 * \param landscapeRight Sets support for
 * <TT>UIInterfaceOrientationLandscapeRight</TT> presentation orientation.
 * \param landscapeLeft Sets support for
 * <TT>UIInterfaceOrientationLandscapeLeft</TT> presentation orientation.
 *
 * \return <TT>YES</TT> if supported presentation orientations were set as
 * specified.
 * \return <TT>NO</TT> if supported presentation orientations were not set. Note
 * that this will be returned if all parameters were <TT>NO</TT>, which would
 * specify no supported presentation orientations.
 *
 * \see Definition of iOS orientations, in the <TT>UIInterfaceOrientation</TT>
 * sub-section of the Constants section of the <A
 *     HREF="http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIApplication_Class/Reference/Reference.html"
 *     target="_blank"
 * >UIApplication Class Reference</A> in the iOS Developer Library on apple.com
 */

- (void)configureUIWithLogo:(NSString*)imagePath
                     bundle:(NSBundle*)bundle
                      color:(UIColor*)color;
/**< Configure the visual appearance of the Good Dynamics user interface.
 * 
 * Call this function to configure the visual appearance of
 * screens in the Good Dynamics user interface (GD UI).
 * The following aspects of the GD UI's appearance can be configured:
 * - Logo image.
 * - Brand color, used for the key line and interactive elements.
 * .
 * This function can be called prior to <TT>authorize</TT>, in order to
 * configure the GD UI as displayed during authorization processing.
 *
 * \param imagePath <TT>NSString</TT> containing the path of the image to show as the
 *                  logo, or <TT>nil</TT> to select the default logo.\n
 *                  If specified, the image must be in PNG format. The maximum
 *                  supported image size is 528 by 140 pixels. If the specified
 *                  image is larger than the maximum, the image will be adjusted
 *                  using <TT>UIViewContentModeScaleAspectFit</TT> mode.\n
 *
 * \param bundle <TT>NSBundle</TT> for the resource bundle that contains the
 *               replacement logo image, or <TT>nil</TT> to specify
 *               <TT>mainBundle</TT>.
 * 
 * \param color <TT>UIColor</TT> for the brand color, or
 *              <TT>nil</TT> to select the default.
 *
 * \see  \link GDiOS::authorize: authorize (GDiOS)\endlink for details of which GD UI elements may be shown
 * during authorization processing.
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/"
 *     target="_blank"
 * >UIView class reference</A> in the iOS Developer Library on apple.com
 * for definitions of image adjustment modes (under <TT>UIViewContentMode</TT>).
 */

- (void)configureUIWithBlockedMessage:(NSString*)message;
/**< Customize the Good Dynamics blocked screen.
 * Call this function to configure the Good Dynamics blocked
 * screen. The blocked screen can be configured to display a custom message
 * instead of the default message that is built in to the Good Dynamics Runtime
 * user interface.
 *
 * The blocked screen is displayed if the Good Dynamics Runtime has blocked the
 * application user interface. For example:
 * - If a policy violation has been detected and the enforcement action is to
 *   block the user interface.
 * - If the password retry limit has been exceeded and the protection action is
 *   to block the user interface.
 * - If a remote container management command to block the user interface has
 *   been received.
 * .
 * Enforcement and protection actions are configured in the enterprise Good
 * Control server.
 * 
 * This function can be called prior to the completion of Good Dynamics
 * authorization processing.
 *
 * \param message <TT>NSString</TT> containing the custom message text, or <TT>nil</TT> to
 *                select the default.
 */

- (void)configureUIWithWipedMessage:(NSString*)message;
/**< Customize the Good Dynamics wiped screen.
 * Call this function to configure the Good Dynamics wiped screen.
 * The wiped screen can be configured to display a custom message instead of the
 * default message that is built in to the Good Dynamics Runtime user interface.
 *
 * The wiped screen is displayed if the Good Dynamics Runtime has wiped the
 * application. For example:
 * - If a policy violation has been detected and the enforcement action is to
 *   wipe the application.
 * - If a remote container management command to wipe the application has
 *   been received.
 * .
 * Enforcement actions are configured in the enterprise Good Control server.
 * 
 * This function can be called prior to the completion of Good Dynamics
 * authorization processing.
 *
 * \param message <TT>NSString</TT> containing the custom message text, or <TT>nil</TT> to
 *                select the default.
 */

@property (nonatomic, assign)   id<GDiOSDelegate> delegate;
/**< Delegated event-handling.
 * When authorization processing completes, or a Good Dynamics Runtime object
 * event occurs, an event is generated by the runtime, and passed to a callback
 * function in the application code.
 *
 * Set this property to an instance of a class in the application that contains
 * the code for the required callback function, i.e. a class that implements
 * the GDiOSDelegate protocol.
 */

@property (nonatomic, retain)  NSDictionary* launchOptions;
/**< Application launch options.
 * Access this property to obtain the options with which the Good Dynamics
 * application was launched. The property is a reference to an object with the
 * same semantics as the <TT>launchOptions</TT> parameter to the
 * <TT>didFinishLaunchingWithOptions:</TT> function in the
 * <TT>UIApplicationDelegate</TT> protocol.
 * 
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/Reference/Reference.html#//apple_ref/occ/intfm/UIApplicationDelegate/application:didFinishLaunchingWithOptions:"
 *     target="_blank"
 * >application:didFinishLaunchingWithOptions: method documentation</A> in the
 * <TT>UIApplicationDelegate</TT> protocol reference in the iOS Developer
 * Library on apple.com for details.
 */

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_ISUSINGDATAPLAN __attribute__((deprecated("Not Required")))
#else
#   define DEPRECATE_ISUSINGDATAPLAN __attribute__((deprecated))
#endif
+ (BOOL)isUsingDataPlan DEPRECATE_ISUSINGDATAPLAN;
/**< Check whether the application is using a data plan for split billing
 *   (deprecated).
 * \deprecated This function is deprecated and will be removed in a
 * future release. It always returns <TT>NO</TT>.
 * 
 * Call this function to check the current data plan state of the running
 * application.
 * 
 * \return <TT>YES</TT> if the application has been registered and entitled to a
 *                  data plan for split billing.
 * \return <TT>NO</TT> otherwise.
 *
 * See the <A
 *   href="http://www.good.com"
 *   target="_blank"
 * >Good Technology corporate website</A> for information about the Good Data
 * Plan split billing product, when available.
 */

@end

/** Good Dynamics entitlement version.
 * Objects of this class are used to represent Good Dynamics
 * entitlement versions.
 *
 * Good Dynamics (GD) entitlement versions are sequences of numbers. The first
 * number is the major version number and is the most significant. Numbers later
 * in the sequence are of decreasing significance. By convention, there are four
 * numbers in a GD entitlement version.
 *
 * In the Good Control console, and in other administrative user interfaces, GD
 * entitlement versions are represented by "dotted string" values, in which the
 * numbers are separated by full stops (periods).
 *
 * Objects of this class are used in the
 * \link GDiOS::getEntitlementVersionsFor:callbackBlock: getEntitlementVersionsFor: (GDiOS)\endlink
 * results list.
 *
 * 
 * <H3>Interface Usage</H3>
 * \code
 * 
 * #import <GD/GDiOS.h>
 *
 * // Initialize from dotted string representation.
 * GDVersion *gdVersionA = [[GDVersion alloc] initWithString:@"1.2.0.3"];
 * 
 * NSUInteger length = [gdVersionA numberOfVersionParts];
 *  // length == 4
 *
 * NSUInteger majorVersion = [gdVersionA versionPartAt:0];
 * // majorVersion == 1
 *
 * // Initialize from array of numbers.
 * GDVersion *gdVersionB = [[GDVersion alloc] initWithArray:@[1, 3] ];
 * 
 * length = [gdVersionB numberOfVersionParts];
 * // length == 2
 *
 * NSInteger comparison = [gdVersionA compare:gdVersionB];
 * // comparison == NSOrderedAscending
 *
 * comparison = [gdVersionB compare:gdVersionA];
 * // comparison == NSOrderedDescending
 *
 * GDVersion *gdVersionC = [[GDVersion alloc] initWithString:@"1.3"];
 *
 * comparison = [gdVersionB compare:gdVersionC];
 * // comparison == NSOrderedSame
 *
 * BOOL isOrder = [gdVersionA isEqualToVersion:gdVersionB];
 * // isOrder == NO
 *
 * isOrder = [gdVersionA isGreaterThanVersion:gdVersionB];
 * // isOrder == NO
 *
 * isOrder = [gdVersionA isLessThanVersion:gdVersionB];
 * // isOrder == YES
 *
 * NSString *dottedString = [gdVersionB stringValue];
 * // [dottedString isEqualToString:@"1.3"] == YES
 *
 * \endcode
 * The code snippet above illustrates the API.
 */
@interface GDVersion : NSObject

- (GDVersion*)initWithString:(NSString*)versionString;
/**< Initialize from a dotted string representation.
 * \return <TT>GDVersion</TT> object with constituent version numbers read from
 *         a dotted string representation.
 */

- (GDVersion*)initWithArray:(NSArray*)array;
/**< Initialize from an array of <TT>NSNumber</TT> objects.
 * \return <TT>GDVersion</TT> object with constituent version numbers
 *         initialized from an array of <TT>NSNumber</TT> objects.
 */

- (NSUInteger)numberOfVersionParts;
/**< Count of how many constituent numbers are in the version.
 * \return <TT>NSUInteger</TT> representation of the count of how many
 *         constituent numbers there are in the version.
 */

- (NSUInteger)versionPartAt:(NSUInteger)position;
/**< Get one constituent version number.
 * Call this function to get one of the constituent numbers in the version,
 * specified by a numeric position. Position zero is the major version number,
 * which is the most significant.
 * 
 * \return The constituent version number at the specified position.
 */

- (NSComparisonResult)compare:(GDVersion*)anotherVersion;
/**< Compare this version with another version.
 * \return <TT>NSComparisonResult</TT> representing the relative value of this
 *         version compared to the other version.
 */

- (BOOL)isEqualToVersion:(GDVersion*)anotherVersion;
/**< Check for equality with another version.
 * \return <TT>YES</TT> if the two versions are the same.
 * \return <TT>NO</TT> Otherwise.
 */

- (BOOL)isGreaterThanVersion:(GDVersion*)anotherVersion;
/**< Check whether this version is more than another version.
 * \return <TT>YES</TT> if this version is more than the specified version.
 * \return <TT>NO</TT> Otherwise.
 */

- (BOOL)isLessThanVersion:(GDVersion*)anotherVersion;
/**< Check whether this version is less than another version.
 * \return <TT>YES</TT> if this version is less than the specified version.
 * \return <TT>NO</TT> Otherwise.
 */

@property(readonly) NSString *stringValue;
/**< Dotted string representation.
 * \return Dotted string representation of this version.
 */
@end

#endif /* __GD_IOS_H__ */
