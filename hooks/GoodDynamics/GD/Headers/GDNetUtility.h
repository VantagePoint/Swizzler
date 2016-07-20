/*
 * (c) 2014 Good Technology Corporation. All rights reserved.
 */

#ifndef ios_GDNetUtility_h
#define ios_GDNetUtility_h

#import <Foundation/Foundation.h>

// See: http://clang.llvm.org/docs/LanguageExtensions.html
#ifndef __has_extension
#define __has_extension(x) 0  // Compatibility with non-clang compilers.
#endif

/** Enumerated constants for use with the Good Dynamics name service.
 * Use these constants to specify the type of results required for a Good
 * Dynamics name service lookup. The type parameter of the
 * \link GDNetUtility::nslookup:type:completion: nslookup\endlink function
 * always takes one of these values.
 */
typedef NS_ENUM(NSInteger, GDNslookupType)
{
    GDNslookupCNAME			 = 0,
    /**< Specify a CNAME lookup.
     */

    GDNslookupARECORD,
    /**< Specify an A record lookup.
     */
};

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_ERRORHOSTNOTLISTED __attribute__((deprecated("No longer required")))
#else
#   define DEPRECATE_ERRORHOSTNOTLISTED __attribute__((deprecated))
#endif

/**
 * \defgroup gdnslookupdomain Good Dynamics Name Service Error Domain
 * These constants can be used when handling Good Dynamics name service lookup
 * errors, in the results handling block of an
 * \link GDNetUtility::nslookup:type:completion: nslookup\endlink call.
 *
 * \{
 */

extern NSString* const GDNetUtilityErrorDomain;
/**< The error domain for Good Dynamics proxy infrastructure utility errors.
 */

typedef NS_ENUM(NSInteger, GDNslookupErr)
{
    GDNslookupErrTimeout                = 100,
    /**< A time out occurred.
     */
    
    GDNslookupErrHostNotListed DEPRECATE_ERRORHOSTNOTLISTED,
    /**< \deprecated This code was for the following condition: The host looked
     * up is not listed for client connection in the enterprise Good Control
     * server.\ Unlisted hosts can now be looked up so this code is no longer
     * required.
     */
    
    GDNslookupErrNetworkError           = 102,
    /**< A network error occurred, for example the enterprise deployment could
     *   not be reached or the mobile data or Wi-Fi connection was lost.
     */
    
    GDNslookupErrParsingResponseError   = 103,
    /**< The name service response could not be parsed.
     */

    GDNslookupErrInternalError          = 104,
    /**< An internal error occured.
     */

    GDNslookupErrParameterError         = 105,
    /**< One or more parameters to the lookup was invalid.
     */

    GDNetUtilityErrCouldNotPerformService = 500
    /**< A general error occurred.
     */
};

/** \}
 */

/** Good Dynamics name service lookup completion block.
 * Pass a code block of this type as the <TT>completion</TT> parameter to the
 * \link GDNetUtility::nslookup:type:completion: nslookup\endlink function.
 *
 * The block receives two parameters.
 * \param response <TT>NSDictionary</TT> containing the results if the lookup
 *                 succeeded, or <TT>nil</TT> otherwise.
 * \param error <TT>NSError</TT> containing a descriptiont of the error
 *              condition if the lookup failed, or <TT>nil</TT> otherwise.
 */
typedef void (^GDNslookupCompletion)(NSDictionary *response, NSError *error);


/** Good Dynamics proxy infrastructure network utilities.
 * This class contains the API for a network utility provided by the Good
 * Dynamics proxy infrastructure.
 *
 * The API is accessed as a static method on a "singleton class" instance.
 */
@interface GDNetUtility : NSObject

+ (void)nslookup:(NSString*)host type:(GDNslookupType)type completion:(GDNslookupCompletion)completion;
/**< Execute a Good Dynamics name service lookup.
 * Call this function to execute a Good Dynamics name service lookup. The
 * lookup can be for canonical name (CNAME) or address record (A record).
 * 
 * The lookup is asynchronous. When the lookup completes, a completion block
 * will be executed. The block will be passed the results, if the lookup was
 * successful, or an error code otherwise.
 *
 * \param host <TT>NSString</TT> containing the name to look up.
 *
 * \param type <TT>GDNslookupType</TT> specifying the type of result required,
 *             either CNAME or A record.
 *
 * \param completion Block to execute when the lookup completes. The block
 *                   receives two parameters:\n
 *                   <TT>NSDictionary</TT> containing the results if the lookup
 *                   succeeded, or <TT>nil</TT> otherwise.\n
 *                   <TT>NSError</TT> containing a description of the error
 *                   condition if the lookup failed, see \ref gdnslookupdomain,
 *                   or <TT>nil</TT> otherwise.
 */
@end


#endif
