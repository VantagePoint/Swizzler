/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#pragma once

#import <Foundation/Foundation.h>

/** NSURLCredential category with additional features.
 * This class is a category of the Foundation <TT>NSURLCredential</TT> class
 * that can be used when the Good Dynamics (GD) proxy infrastructure is enabled in
 * the URL Loading System (see \ref GDURLLoadingSystem). This class provides the
 * ability to set the persistence of credentials.
 *
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSURLCredential_Class"
 *     target="_blank"
 * >NSURLCredential class reference</A> in the iOS Developer Library on the
 * apple.com website.
 */
@interface NSURLCredential (GDNET)

@property (readwrite) NSUInteger gdPersistence;
/**< Credential persistence.
 * Set this property of an <TT>NSURLCredential</TT> object to specify the
 * persistence for the credential that it represents. This property can be set
 * on a server trust credential that is created as part of the processing of an
 * <TT>NSURLAuthenticationMethodServerTrust</TT> authentication challenge.
 *
 * The property can be set to one of the following values:
 * - <TT>NSURLCredentialPersistenceNone</TT> Credential will not be stored
 *   persistently.
 * - <TT>NSURLCredentialPersistencePermanent</TT> Credential will be stored
 *   persistently in the GD secure store on the mobile device.
 * .
 * 
 * If the credential is stored persistently then it will be reused automatically
 * every time an authentication challenge for the same protection space is
 * received. This means that the following callbacks will not be invoked:
 * - <TT>NSURLConnectionDelegate willSendRequestForAuthenticationChallenge</TT>
 * - <TT>GDURLRequestConnectionDelegate willSendRequestForAuthenticationChallenge</TT>
 * .
 * 
 * Automatic reuse continues until one of the following occurs:
 * - The server presents different certificate details.
 * - The application cancels persistence, by calling the
 *   <TT>undoPriorTrustDecision</TT> function.
 * .
 *
 * See the class reference of the \ref NSMutableURLRequest(GDNET) category for
 * details of the <TT>undoPriorTrustDecision</TT> function.
 */

@end
