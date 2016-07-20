/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */
#import <Foundation/Foundation.h>

#ifndef ios_GDConnectivityManager_h
#define ios_GDConnectivityManager_h

/** Good Dynamics infrastructure connection management.
 * Use this class to control the connection from the mobile application
 * to the Good Dynamics (GD) infrastructure.
 *
 * \see \link GDReachability GDReachability\endlink class reference.
 */
@interface GDConnectivityManager : NSObject

/** Reset the Good Dynamics infrastructure connection.
 * Call this function to request reset of all the application's
 * connections to the GD infrastructure. The GD Runtime generally connects and
 * reconnects to the GD infrastructure as needed and so there should be no need
 * to call this function in normal operation.
 *
 * \return <TT>YES</TT> if the reset request was accepted and put in progress.
 * \return <TT>NO</TT> otherwise.
 */
+ (BOOL)forceResetAllConnections;

@end

#endif
