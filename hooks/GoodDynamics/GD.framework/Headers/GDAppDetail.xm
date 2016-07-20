/*
 * (c) 2014 Good Technology Corporation. All rights reserved.
 */

#ifndef __GD_APP_DETAIL_H__
#define __GD_APP_DETAIL_H__


#import <Foundation/Foundation.h>
#import <GD/GDiOS.h>

/** Service provider details (deprecated).
 * \deprecated This class is deprecated and will be removed in a future release.
 * This class is used to return information about a service provider in the
 * deprecated service discovery API. The replacement service discovery API uses
 * a different class to return information. See  \link GDiOS::getServiceProvidersFor:andVersion:andType:  getServiceProvidersFor:  (GDiOS)\endlink.
 * 
 * This class is used to return information about a service provider. An
 * instance of this class either represents an application or a server.
 *
 * The information returned for an application could be used to send a service
 * request to the service provider using Good Inter-Container Communication. See
 * the   \link GDService GDService class reference\endlink for details of the API.
 *
 * The information returned for a server could be used to establish
 * HTTP or TCP socket communications with an instance of the server.
 */
@interface GDAppDetail : NSObject

{
    @public NSString* applicationId;
    /**< Good Dynamics Application ID of the service provider.
     */

    @public NSString* applicationVersion;
    /**< Good Dynamics Application Version of the service provider.
     */

    @public NSString* name;
    /**< Display name of the service provider.
     */

    @public NSString* address;
    /**< Native application identifier of the service provider, if it is an
     * application.\ This is the value that would be passed as the
     * <TT>application</TT> parameter in a call to
     *  \link GDServiceClient::sendTo:withService:withVersion:withMethod:withParams:withAttachments:bringServiceToFront:requestID:error: sendTo (GDServiceClient)\endlink.
     */

    @public UIImage* icon;
    /**< Application icon of the service provider, if it is an application and 
     * an icon has been uploaded by the developer.\ Otherwise, <TT>nil</TT>.
     */

    @public NSString* versionId;
    /**< Version of the service that the application provides.\ Note that
     * services have versions, in the same way that applications have
     * versions.\ The details of a service's API, as declared in its schema may
     * change from version to version.
     */
    
    @public GDServiceProviderType providerType;
    /**< Indicator of the type of the service provider, either application-based
      * or server-based.\ This is provided for diagnostic purposes only; the
      * original call to the service discovery API will have specified the type
      * of service provider.
     */
    
    @public NSMutableArray* serverList;
    /**< Collection of <TT>GDAppServer</TT> objects, each representing an
     * instance of a server that provides the service.\ If there is more than
     * one then the application should use a server selection algorithm, such as
     * that outlined under the Application Server Selection heading in the
     * \link GDiOS::getApplicationConfig getApplicationConfig (GDiOS)\endlink documentation.
     */
}

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_GDAPPDETAIL __attribute__((deprecated("No longer required.")))
#else
#   define DEPRECATE_GDAPPDETAIL __attribute__((deprecated))
#endif

@property (nonatomic, retain) NSString* applicationId DEPRECATE_GDAPPDETAIL;
/* GD Application ID. */
@property (nonatomic, retain) NSString* applicationVersion DEPRECATE_GDAPPDETAIL;
/* GD Application Version. */
@property (nonatomic, retain) NSString* name DEPRECATE_GDAPPDETAIL;
/* Display name. */
@property (nonatomic, retain) NSString* address DEPRECATE_GDAPPDETAIL;
/* Native application identifier, if an application. */
@property (nonatomic, retain) UIImage* icon DEPRECATE_GDAPPDETAIL;
/* Application icon. */
@property (nonatomic, retain) NSString* versionId DEPRECATE_GDAPPDETAIL;
/* Version of the service provided. */
@property (nonatomic) GDServiceProviderType providerType DEPRECATE_GDAPPDETAIL;
/* Indicator of application-based or server-based provider. */
@property (nonatomic, retain) NSMutableArray* serverList DEPRECATE_GDAPPDETAIL;
/* Details of server instances. */
@end

#undef DEPRECATE_GDAPPDETAIL

/** Details of a provided service.
 * This class is used to return information about a provided service. The
 * <TT>services</TT> property of a \link GDServiceProvider GDServiceProvider\endlink object is a
 * collection of instances of this class.
 */
@interface GDServiceDetail : NSObject

{
    @public NSString* identifier;
    /**< Good Dynamics Service Identifier.
     */
    
    @public NSString* version;
    /**< Good Dynamics Service Version.
     */
    
    @public GDServiceProviderType type;
    /**< Indicator of the type of the provided service, either application-based
     * or server-based.
     */
}

- (id)initWithService:(NSString*)identifier andVersion:(NSString*)version andType:(GDServiceProviderType)type;

/** GD Service ID. */
@property (nonatomic, retain, readonly) NSString* identifier;
/** GD Service Version. */
@property (nonatomic, retain, readonly) NSString* version;
/** Indicator of application-based or server-based service. */
@property (nonatomic, readonly) GDServiceProviderType type;
@end

/** Service provider details.
 * This class is used to return information about a service provider. See
 *  \link GDiOS::getServiceProvidersFor:andVersion:andType:  getServiceProvidersFor:  (GDiOS)\endlink. An instance of this class either represents an
 * application or a server.
 *
 * The information returned for an application could be used to send a service
 * request to the service provider using Good Inter-Container Communication. See
 * the   \link GDService GDService class reference\endlink for details of the API.
 *
 * The information returned for a server could be used to establish
 * HTTP or TCP socket communications with an instance of the server.
 */
@interface GDServiceProvider : NSObject

{
    @public NSString* identifier;
    /**< Good Dynamics Application ID of the service provider.
     */

    @public NSString* version;
    /**< Good Dynamics Application Version of the service provider.
     */

    @public NSString* name;
    /**< Display name of the service provider.
     */

    @public NSString* address;
    /**< Native application identifier of the service provider, if it is an
     * application.\ This is the value that would be passed as the
     * <TT>application</TT> parameter in a call to
     *  \link GDServiceClient::sendTo:withService:withVersion:withMethod:withParams:withAttachments:bringServiceToFront:requestID:error: sendTo (GDServiceClient)\endlink.
     */

    @public UIImage* icon;
    /**< Application icon of the service provider, if it is an application and 
     * an icon has been uploaded by the developer.\ Otherwise, <TT>nil</TT>.
     */

    @public NSArray* serverCluster;
    /**< Collection of <TT>GDAppServer</TT> objects, each representing an
     * instance of a server that provides the service.\ If there is more than
     * one then the application should use a server selection algorithm, such as
     * that outlined under the Application Server Selection heading in the
     * \link GDiOS::getApplicationConfig getApplicationConfig (GDiOS)\endlink documentation.
     */

    @public NSArray* services;
    /**< Collection of <TT>GDServiceDetail</TT> objects, each representing a
     * provided shared service.
     */
}

/** GD Application ID. */
@property (nonatomic, retain) NSString* identifier;
/** GD Application Version. */
@property (nonatomic, retain) NSString* version;
/** Display name. */
@property (nonatomic, retain) NSString* name;
/** Native application identifier, if an application. */
@property (nonatomic, retain) NSString* address;
/** Application icon. */
@property (nonatomic, retain) UIImage* icon;
/** Details of server instances. */
@property (nonatomic, retain) NSArray* serverCluster;
/** Details of provided services. */
@property (nonatomic, retain) NSArray* services;
@end

#endif
