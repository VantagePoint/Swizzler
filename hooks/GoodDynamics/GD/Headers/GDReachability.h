/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

/** Constants for GDReachability network status.
 * This enumeration represents the different possible statuses of the connection
 * to the Good Dynamics (GD) infrastructure. The <TT>status</TT> property of a
 * \ref GDReachability object always takes one of these values.
 */
typedef NS_ENUM(NSInteger, GDReachabilityStatus) {
    GDReachabilityNotReachable = 0,
    /**< The GD infrastructure isn't reachable.
     */
    
    GDReachabilityViaWiFi,
    /**< The GD infrastructure is reachable via a Wi-Fi connection.
     */

    GDReachabilityViaCellular,
    /**< The GD infrastructure is reachable via a mobile data (cellular)
     *  connection.
     */
};

extern NSString *GDReachabilityChangedNotification;
/**< Notification name for changes to Good Dynamics infrastructure reachability.
 * Use this value to add an observer of changes to Good Dynamics infrastructure
 * reachability. See the \ref GDReachability class reference for details.
 */

/** Good Dynamics infrastructure connection status.
 * This class represents the status of the connection from the mobile
 * application to the Good Dynamics (GD) infrastructure.
 * 
 * Every GD application connects to the GD infrastructure whenever possible. The
 * connection is maintained by the Good Dynamics (GD) Runtime in the mobile
 * application. The GD infrastructure includes the GD Network Operation Center
 * (NOC) as well as a number of other components that can be installed by the
 * enterprise.
 *  \htmlonly <div class="bulletlists"> \endhtmlonly
 * The current status can be obtained synchronously. It is also possible to
 * receive notifications whenever the status changes. Use the native
 * <TT>NSNotificationCenter</TT> API, with the following parameters:
 * - Set the notification name to the \ref GDReachabilityChangedNotification
 *   value.
 * - Set the notification object to the GD Runtime interface object, obtained by
 *   <TT>[GD<TT></TT>iOS sharedInstance]</TT>.
 * .
 *  \htmlonly </div> \endhtmlonly
 *
 * \see \ref GDConnectivityManager class reference.
 * \see <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSNotificationCenter_Class"
 *     target="_blank"
 * >NSNotificationCenter class reference</A> in the iOS Developer Library on the
 * apple.com website.
 *
 *  <H2>Code Snippets</H2> The following code snippets illustrate some common tasks.
 * <H3>Register for notification</H3>
 * \code
 *
 * - (void)addChangeConnectionStatusObserver {
 *  [[NSNotificationCenter defaultCenter] addObserver:self
 *                                           selector:@selector(reachabilityChanged:)
 *                                               name:GDReachabilityChangedNotification
 *                                             object:[GDiOS sharedInstance]];
 * }
 *
 * - (void)reachabilityChanged:(NSNotification *)notification {
 *  GDReachability *reachability = [GDReachability sharedInstance];
 *
 *  if (reachability.status == GDReachabilityNotReachable) {
 *
 *      UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
 *                                                      message:@"Network NOT Available"
 *                                                     delegate:nil
 *                                            cancelButtonTitle:@"OK"
 *                                            otherButtonTitles:nil, nil];
 *      [alert show];
 *
 *  } else {
 *
 *      UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Success"
 *                                                      message:@"Network Available"
 *                                                     delegate:nil
 *                                            cancelButtonTitle:@"OK"
 *                                            otherButtonTitles:nil, nil];
 *      [alert show];
 *
 *  }
 *
 * }
 * \endcode
 *  \htmlonly <div class="bulletlists"> \endhtmlonly
 * The above snippet shows:
 * - Registration for notification of changes in connection status. The observer
 *   code is specified by a selector.
 * - Implementation of the selector, which displays a message to the user.
 * .
 *  \htmlonly </div> \endhtmlonly
 */
@interface GDReachability : NSObject

+ (instancetype) sharedInstance;
/**< Get a reference to the GD infrastructure connection status object.
 * This function returns a reference to the GD infrastructure connection status
 * object, which is a "singleton class".
 *
 * \return Reference that can be used, for example, to access the
 *         <TT>status</TT> property.
 */

@property (nonatomic, readonly) GDReachabilityStatus status;
/**< Connection status and medium.
 * The value of this property represents the type of connection through which
 * the GD infrastructure is reachable. It always takes a value from the
 * \ref GDReachabilityStatus enumeration:
 * - <TT>GDReachabilityViaCellular</TT> if the GD infrastructure is reachable
 *   via a mobile data (cellular) connection.
 * - <TT>GDReachabilityViaWiFi</TT> if the GD infrastructure is reachable
 *   via a Wi-Fi connection.
 * - <TT>GDReachabilityNotReachable</TT> if the GD infrastructure isn't
 *   reachable.
 * .
 */

+ (BOOL) isNetworkAvailable;
/**< Connection availability.
 * \return <TT>YES</TT> if there is a current connection to the GD infrastructure.
 * \return <TT>NO</TT> otherwise.
 */

@end