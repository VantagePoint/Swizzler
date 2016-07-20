/*
 *  Copyright (c) Visto Corporation dba Good Technology, 2011. All rights reserved.
 */

// XXX
// Note that the inline documentation for this module is specific to iOS.
// That's okay because iOS is the only platform for which we currently expose
// a C-language API. Android/Java has a separate definition of these codes,
// with its own inline documentation, in
//  platform/android/Library/src/com/good/gd/GDAppResultCode.java.
// If you change this file, you need to change that one too.
// XXX

#ifndef __GD_APP_RESULT_CODE_H__
#define __GD_APP_RESULT_CODE_H__

/** Constants for GDAppEvent result code.
 * This enumeration represents the result code of a \ref GDAppEvent that is
 * being notified.
 * The \ref GDAppEvent.code property will always take one of these values.
 *
 * The code can be interpreted in conjunction with the event type,
 * see \ref GDAppEventType.
 * \ingroup gdappevent
 */
typedef enum
{
    GDErrorNone = 0,
    /**< Used for all non-failure events. */

    GDErrorActivationFailed = -101,
    /**< Device activation failed.\ Device activation is part of authorization
     * processing.\ This code notifies the application
     * that processing did not succeed this time, but may succeed if another
     * <TT>authorize</TT> call is made.\ See under  \link GDiOS::authorize: authorize (GDiOS)\endlink.
     */

    GDErrorProvisioningFailed = -102,
    /**< Enterprise activation failed.\ Enterprise activation is part of
     * authorization processing.\ This code notifies
     * the application that processing did not succeed this time, but may
     * succeed if another <TT>authorize</TT> call is made.\ See under  \link GDiOS::authorize: authorize (GDiOS)\endlink.
     * This code is set in the scenario that the user keyed and sent
     * credentials that were rejected, and then cancelled authorization.
     */

    GDErrorPushConnectionTimeout = -103,
    /**< Push Connection failed to open but is required to complete
     * authorization.\ This code notifies
     * the application that authorization processing did not succeed this time,
     * but may succeed if another <TT>authorize</TT> call is made.
     * See  \link GDiOS::authorize: authorize (GDiOS)\endlink and \ref GDPushConnection.
     */

    GDErrorAppDenied = -104,
    /**< User not entitled.\ Authorization processing has completed, but the
     * user is not entitled to use this version of this application.\ This
     * code notifies the application that the Good Dynamics container
     * has been wiped of all application data and authentication credentials.
     *
     * (If entitlement was withdrawn in error then, after reinstating
     * entitlement, the following steps must be taken.
     * The user must terminate the application on the device using the
     * native task manager, and then restart the application.
     * The application will then open as if being started for the first time.
     * The user will then have to enter a new activation key.)
     *
     * See also the \ref GC.
     */

    GDErrorIdleLockout = -300,
    /**< User inactive.\ The enterprise's security policies specify a time after
     * which the application is to be locked, and the user has now been inactive
     * for a period that exceeds this time.\ In effect, the user's authorization
     * to access the application data has been withdrawn.\ This code
     * notifies the application that the Good Dynamics lock screen is active
     * and therefore the application's own user interface must not be made
     * active.
     *
     * The locked condition will be cleared when the user enters their
     * password, at which point the application will be notified with a new
     * event.
     */

    GDErrorBlocked = -301,
    /**< Policy violation block.\ The enterprise's security policies specify a
     * condition under which access is to be blocked, and that condition
     * has occurred.\ In effect, the user's authorization to access the
     * application data has been withdrawn.\ This code
     * notifies the application that its user interface must not be made
     * active. (Compare <TT>GDErrorWiped</TT>, below.)
     *
     * This code may be set when, for example, connection to the Good Dynamics
     * infrastructure has not been made for a specified interval. If the
     * condition is cleared, the application will be notified with a new event.
     */

    GDErrorWiped = -302,
    /**< Policy violation wipe.\ The enterprise's security policies specify a
     * condition under which the secure container is to be wiped, and that
     * condition has occurred.\ This code notifies the application that the
     * container has been wiped of all application data and authentication
     * credentials. (Compare <TT>GDErrorBlocked</TT>, above, which also gives
     * an example of a policy condition.)
     *
     * After a device wipe, the application cannot be run until the following
     * steps have been taken.
     * The user must terminate the application on the device using the
     * native task manager, and then restart the application.
     * The application will then open as if being started for the first time.
     * The user will then have to enter a new activation key.
     */

    GDErrorRemoteLockout = -303,
    /**< Remote lock-out.\ Either an enterprise administrator has locked the
     * user out of the application,\n
     * or the security password has been retried too often.\ In effect, the
     * user's authorization to access the application data has been
     * withdrawn.\ This code notifies the application that its user interface
     * must not be made active.
     *
     * The user's authorization will remain withdrawn until an enterprise
     * administrator removes the lock, and the end user has entered a special
     * unlock code at the device.
     */

    GDErrorPasswordChangeRequired = -304,
    /**< Password change required.\ The user's security password has expired,
     * or no longer complies with enterprise security policy.\ In effect, the
     * user's authorization to access the application data has been
     * withdrawn.\ This code
     * notifies the application that the Good Dynamics password change screen
     * is active and therefore the application's own user interface must not
     * be made active.
     */

    GDErrorSecurityError = -100,
    /**< Internal error: Secure store could not be unlocked.
     */
    
    GDErrorProgrammaticActivationNoNetwork = -601,
    /**< Programmatic activation connection failed.\ It was not possible to
     * establish a data connection for programmatic activation.\ This code
     * notifies the application that programmatic activation did not succeed
     * this time, but may succeed if another <TT>programmaticAuthorize</TT> call
     * is made when a data connection can be established from the mobile
     * device.\ See under  \link GDiOS::authorize: authorize (GDiOS)\endlink.
     */
    
    GDErrorProgrammaticActivationCredentialsFailed = -602,
    /**< Programmatic activation credentials failed.\ The credential values
     * supplied to the programmatic activation API were rejected during some
     * stage of activation processing.\ This code notifies the application that
     * programmatic activation did not succeed this time, but could succeed if
     * another <TT>programmaticAuthorize</TT> call is made with different
     * credential values.\ See under  \link GDiOS::authorize: authorize (GDiOS)\endlink.
     */
    
    GDErrorProgrammaticActivationServerCommsFailed = -603,
    /**< Programmatic activation server communication failed.\ A data connection
     * was established but communication with a required server resource
     * subsequently failed.\ This code notifies the application that
     * programmatic activation did not succeed this time, but could succeed if
     * another <TT>programmaticAuthorize</TT> call is made later.\ See under
     *  \link GDiOS::authorize: authorize (GDiOS)\endlink.
     *
     * It is recommended not to make repeated attempts at programmatic
     * activation with no delay between attempts. Instead, an exponential
     * back-off algorithm should be used to calculate a delay.
     */
    
    GDErrorProgrammaticActivationUnknown = -600
    /**< Programmatic activation failed.\ A general failure occurred during
     * programmatic activation processing.\ This code notifies the application
     * that programmatic activation did not succeed this time, but could succeed
     * if another <TT>programmaticAuthorize</TT> call is made.\ See under
     *  \link GDiOS::authorize: authorize (GDiOS)\endlink.
     */
} GDAppResultCode;

#endif /* __GD_APP_RESULT_CODE_H__ */
