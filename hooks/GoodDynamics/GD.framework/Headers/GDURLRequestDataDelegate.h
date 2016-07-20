/*
 * (c) 2013 Good Technology Corporation. All rights reserved.
 */

#ifndef __GD_URL_REQUEST_DATA_DELEGATE_H__
#define __GD_URL_REQUEST_DATA_DELEGATE_H__

#import <Foundation/Foundation.h>

/** Delegate for managing the URL requests associated with a UIWebView control.
 * URL requests issued by a <TT>UIWebView</TT> control can be managed by
 * creating a class that implements this protocol.
 *
 *  \htmlonly <div class="bulletlists"> \endhtmlonly
 * This protocol enables a number of monitoring and control actions, including:
 * - Cancellation of a URL request before it is sent.
 * - Replacement of a URL request with a modified request.
 * - Monitoring of the receipt of headers and data in response to a URL request.
 * .
 * This protocol is similar to the native <TT>NSURLConnectionDataDelegate</TT>
 * and <TT>UIWebViewDelegate</TT> protocols. The functional differences are:
 * - Callback functions are only invoked if the Good Dynamics proxy
 *   infrastructure is enabled in the URL Loading System, i.e. only if the 
 *   \ref GDURLLoadingSystem is handling HTTP.
 * - The delegate for URL request handling is attached to the user interface
 *   control, not to an individual request. Any URL request issued from the user
 *   interface that is handled by the <TT>GDURLLoa</TT><TT>dingSystem</TT>
 *   triggers invocation of the callback functions. Note that only HTTP and
 *   HTTPS requests are handled by the <TT>GDURLLoa</TT><TT>dingSystem</TT>.
 * - The range of monitoring and control actions is different.
 * .
 *  \htmlonly </div> \endhtmlonly
 * 
 * Call the <TT>GDSetRequestDataDelegate:</TT> function in the
 * \link UIWebView(GDNET)\endlink category to set the delegate for a particular
 * <TT>UIWebView</TT> instance. The delegate callbacks will be executed on the
 * same thread in which the delegate was set.
 *
 * All the callbacks in this protocol utilize an <TT>NSURLRequest</TT> object to
 * represent the request to which the callback invocation relates. See the <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSURLRequest_Class/Reference/Reference.html"
 *     target="_blank"
 * >NSURLRequest class reference</A> in the iOS Developer Library on apple.com
 * for details of how to access its attributes.
 * 
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/DOCUMENTATION/Foundation/Reference/NSURLConnectionDataDelegate_protocol/Reference/Reference.html"
 *     target="_blank"
 * >NSURLConnectionDataDelegate protocol reference</A> in the iOS Developer
 * Library on apple.com
 * \see <A
 *     HREF="https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIWebViewDelegate_Protocol/Reference/Reference.html"
 *     target="_blank"
 * >UIWebViewDelegate protocol reference</A> in the iOS Developer
 * Library on apple.com
 */
@protocol GDURLRequestDataDelegate <NSObject>

@optional

- (BOOL)GDWillSendRequest:(NSURLRequest**)request;
/**< Invoked before a request is sent.
 * This callback is invoked when a URL request is about to be sent. The location
 * of a pointer to the request, i.e. a pointer to a pointer, is passed as a
 * parameter.
 *
 * The function that is invoked can replace the request by overwriting the
 * pointer with the address of a request of its own. The replacement request
 * will then be sent instead of the original request.
 *
 * The function that is invoked can also cancel the request by doing either
 * of the following:
 * - Overwriting the pointer with <TT>nil</TT>.
 * - Returning <TT>NO</TT>.
 * .
 *
 * \param request location of a pointer to an <TT>NSURLRequest</TT> that
 *                contains the request.
 * \return <TT>YES</TT> to send the request, original or replacement.
 * \return <TT>NO</TT> to cancel the request.
 */

- (void)GDRequest:(NSURLRequest*)request didReceiveResponse:(NSURLResponse*)response;
/**< Invoked when the initial part of a response has been received.
 * This callback is invoked when the initial part of a response has been
 * received.
 *
 * The details that have been received are made available in an
 * <TT>NSURLResponse</TT> object. See the <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSURLResponse_Class/Reference/Reference.html"
 *     target="_blank"
 * >NSURLResponse class reference</A> in the iOS Developer Library on apple.com
 * for details of what information is available and how to access it.
 * 
 * The details passed to this callback may include an expected content length of
 * the response data. This will be the transport content length, and may be
 * different to the length of the data received by subsequent
 * \ref GDRequest:didReceiveData: invocations if compression has been used.
 *
 * This callback will be invoked once for every request that receives a
 * response.
 *
 * \param request <TT>NSURLRequest</TT> representing the request for which
 *                the initial part of the response has been received.
 * \param response <TT>NSURLResponse</TT> representing the response.
 */

- (void)GDRequest:(NSURLRequest*)request didReceiveData:(NSData*)data;
/**< Invoked for every receipt of response data.
 * This callback is invoked whenever response data is received.
 *
 * The received data is made available in an <TT>NSData</TT> object. See the <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/Reference/Reference.html"
 *     target="_blank"
 * >NSData class reference</A> in the iOS Developer Library on apple.com
 * for details of how to read it.
 * 
 * The response data may have been inflated after transport and its final length
 * may be different to the expected length when
 * \ref GDRequest:didReceiveResponse: was invoked.
 * 
 * The response data for a single request may be received in multiple chunks, in
 * which case this callback will be invoked multiple times. This callback will
 * not be invoked for responses that include no data.
 *
 * \param request <TT>NSURLRequest</TT> representing the request for which
 *                response data has been received.
 * \param data <TT>NSData</TT> containing the received data.
 */

- (void)GDRequest:(NSURLRequest*)request didFailWithError:(NSError*)error;
/**< Invoked if a request fails, or if an incomplete response is received.
 * This callback is invoked when a URL request sent by the associated
 * <TT>UIWebView</TT> instance fails to send, or receives an incomplete
 * response.
 *
 * Details of the error condition are made available in an <TT>NSError</TT>
 * object. See the <A
 *     href="http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSError_Class/Reference/Reference.html"
 *     target="_blank"
 * >NSError class reference</A> in the iOS Developer Library on apple.com for
 * details of how to access its attributes.
 * 
 * \param request <TT>NSURLRequest</TT> representing the request that has failed.
 * \param error <TT>NSError</TT> object describing the error condition.
 */

- (void)GDRequestDidFinishLoading:(NSURLRequest*)request;
/**< Invoked when processing for a request has finished.
 * This callback is invoked when a URL request from the associated
 * <TT>UIWebView</TT> instance completes without errors.
 *
 * This callback will be invoked once for every request that completes without
 * errors, including requests whose responses have no data.
 * 
 * \param request <TT>NSURLRequest</TT> representing the request that has
 *                completed.
 */

@end

#endif