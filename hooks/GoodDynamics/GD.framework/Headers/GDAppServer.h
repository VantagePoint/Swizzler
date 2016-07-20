/*
 * (c) 2014 Good Technology Corporation. All rights reserved.
 */

#ifndef __GD_APP_SERVER_H__
#define __GD_APP_SERVER_H__

#import <Foundation/Foundation.h>

/** Application server configuration.
 * This class is used to return the details of application server configuration.
 * A collection of instances of this class will be in the
 * <TT>GDAppConfigKeyServers</TT> value returned by the
 * \link GDiOS::getApplicationConfig getApplicationConfig (GDiOS)\endlink function, or in the
 * <TT>serverCluster</TT> property of a <TT>GDServiceProvider</TT> object.
 */
@interface GDAppServer : NSObject

{}

- (id)initWithServer:(NSString*)server andPort:(NSNumber*)port andPriority:(NSNumber*)priority;

@property (nonatomic, retain, readonly) NSString* server;
/**< Server address. */

@property (nonatomic, retain, readonly) NSNumber* port;
/**< Server port number. */

@property (nonatomic, retain, readonly) NSNumber* priority;
/**< Server priority.\ Lower numbers represent higher server priority, with 1
 * representing the highest.
 */

@end

#endif