/*
 * (c) 2013 Good Technology Corporation. All rights reserved.
 */

#ifndef __GD_PUSH_IOS_H__
#define __GD_PUSH_IOS_H__

#import <Foundation/Foundation.h>

/** Delegate for handling GDPushConnection state transition.
 * Errors and state changes that occur when using
 * \link GDPushConnection GDPushConnection\endlink are handled by creating a class that implements
 * this protocol.
 *
 *  <H2>Code Snippets</H2> The following code snippets illustrate some common tasks.
 * <H3>Print State-Change</H3>
 * \code
 * @interface BasicHandler : NSObject <GDPushConnectionDelegate> {}
 * @end
 *
 * @implementation BasicHandler
 * -(void)onStatus:(int)status
 * {
 *     if ( [[GDPushConnection sharedConnection] isConnected] ) {
 *         NSLog( @"Connected OK. Push Channel service available.");
 *     }
 *     else {
 *         NSLog( @"Push Channel service not available.");
 *     }
 * }
 * @end
 * \endcode
 * The above snippet shows a very simple handler for \link GDPushConnection GDPushConnection\endlink
 * state-change. The availability of the Push Channel service is written to the
 * system log.
 *
 * <H3>Set Event Handler</H3>
 * \code
 * basicDelegate = [[BasicHandler alloc] init];
 * connection.delegate = basicDelegate;
 * \endcode
 * The above snippet shows how the above handler could be associated with the
 * Push Connection.
 */
@protocol GDPushConnectionDelegate

- (void)onStatus:(int)status;
/**< Callback for all status changes.
 * The callback is invoked when the Push Connection changes state, or
 * when an error occurs.
 *
 * The function that is invoked could call
 *  \link GDPushConnection::isConnected isConnected\endlink to determine the availability of the
 * following features:
 * - Push Channel service
 * - Communication through the Good Dynamics proxy infrastructure
 * .
 * If the features are available (i.e. <TT>isConnected</TT> returns <TT>YES</TT>),
 * then any of the following actions that were waiting could now proceed:
 * - Establishing a Push Channel, see \link GDPushChannel::connect connect\endlink
 * - Opening a socket connection to an enterprise server, see
 * \ref GDSocket::connect
 * - Sending an HTTP request to an enterprise server, see
 * \ref GDHttpRequest::send
 * .
 * If the features are not available (i.e. <TT>isConnected</TT> returns
 * <TT>NO</TT>) then the function that is invoked could alert the user, or
 * display this as an ongoing state.
 * In this state, Push Channel notifications would not be received.
 *
 * \param status Internal numeric code for the new status.
 * Specific values are not documented, and should not be relied upon.
 *
 * During establishment or termination of the Push Connection with the Good
 * Dynamics proxy infrastructure, see <TT>GDPush</TT><TT>Connection</TT>
 *  \link GDPushConnection::connect connect\endlink and  \link GDPushConnection::disconnect disconnect\endlink,
 * the callback will be invoked a number of times, as the action progresses.
 *
 * Events that have an impact on the state of the Push Connection also
 * result in the callback being invoked. This would include loss of
 * network coverage and other losses of data connection, as well as the
 * subsequent automatic re-establishment of the connection.
 */
@end


/** Manage Push Channel connection.
 * This API is part of the Good Dynamics Push Channel feature.
 * For an overall description of how to use the feature, see under
 * \link GDPushChannel GDPushChannel\endlink.
 *
 * The Push Connection is the container and conduit for the device's Push
 * Channels. An application may open multiple Push Channels; all will be
 * managed within a single Push Connection.
 *
 * The Push Connection is automatically established during Good Dynamics
 * authorization processing, and then maintained by the Good Dynamics
 * Runtime under application control.
 * The application can instruct the runtime to switch the Push Connection
 * off and on.
 *
 * When instructed to switch off, the GD Runtime will terminate the Push
 * Connection, and suspend its maintenance. When instructed to switch
 * back on, the GD Runtime will re-establish the Push Connection, and
 * resume maintenance.
 *
 * Switching off the Push Connection might be an option that the application
 * offers to the end user, for example, allowing them to
 * reduce power consumption on the device.
 *
 * Push Connection functions cannot be called until Good Dynamics
 * authorization processing is complete.
 * \see \link GDPushChannel GDPushChannel\endlink
 * \see \link GDiOS\endlink, for Good Dynamics authorization
 * \see \ref threads
 * \see \ref background_execution
 *
 * <H3>Push Channel Network</H3>
 * The Push Connection is a link between the mobile application and the Good
 * Dynamics proxy infrastructure Network Operation Center (NOC).
 * The Push Channel is a link between the mobile application and its application
 * server (App Server). There can be more than one Push Channel; the mobile
 * application can receive push communications from more than one App Server.
 * Push Channels are mediated by the NOC, and sometimes other proxy
 * infrastructure elements.
 *
 * This is shown in the following diagram.
 *  \image html "Push Channel network.png"
 \image rtf "Push Channel network.png"

 *
 * <H3>API Overview</H3>
 * The GD Push Connection API consists of a small number of functions that must
 * be used in a particular order. Whilst some other APIs are general-purpose
 * toolkits, the Push Connection API has only a single purpose: to enable
 * the Push Channel API.
 *
 * The normal sequence of operations is as follows.
 * -# Application started.
 * -# Good Dynamics initialization and authorization, see under \link GDiOS\endlink.
 * -# When the application needs a Push Channel...
 * -# Call
 *  \link GDPushConnection::sharedConnection sharedConnection\endlink 
 * to access the Push Connection object,
 * -# Call  \link GDPushConnection::isConnected isConnected\endlink to check the connection state,
 * -# If the state is not connected:
 *   -# Set a  \link GDPushConnectionDelegate GDPushConnectionDelegate\endlink to handle connection state changes
 *   -# Call  \link GDPushConnection::connect connect\endlink to ensure that connection is
 *      being attempted,
 *   -# When the  \link GDPushConnectionDelegate::onStatus: onStatus\endlink callback in the
 *      handler is invoked, go back and check the connection state again.
 * -# If the state is connected, proceed to setting up a Push Channel.
 * .
 * For details of Push Channel set-up, see under \link GDPushChannel GDPushChannel\endlink.
 *
 *  <H2>Code Snippets</H2> The following code snippets illustrate some common tasks.
 * <H3>Terminate Push Connection</H3>
 * \code
 * [[GDPushConnection sharedConnection] disconnect];
 * \endcode
 * After the disconnect, the connection can be re-opened later.
 *
 * <H3>Re-open Push Connection</H3>
 * \code
 * if ( ! [[GDPushConnection sharedConnection] isConnected] ) {
 *     myHandler = [[AppHandler alloc] init];
 *     myConnection.delegate = myHandler;
 *     [myConnection connect];
 * }
 * \endcode
 * The above snippet shows a check for whether the Push Channel service is
 * already available. If it is not, then a connection is initiated.
 * The connection attempt is asynchronous. The <TT>onStatus</TT>
 * callback would be invoked, with <TT>isConnected</TT> returning <TT>YES</TT>,
 * when the attempt succeeds (not shown). See  \link GDPushConnectionDelegate GDPushConnectionDelegate\endlink.
 */
@interface GDPushConnection : NSObject {
    id<GDPushConnectionDelegate> delegate;
    @private
    void* m_pushConnectionInternal;
}

+ (id)sharedConnection;
/**< Get a reference to the Push Connection object.
 * This function returns a reference to the Push Connection object.
 *
 * The Push Connection object is a "singleton class".
 *
 * \return Reference that can be used to call, for example,
 * the <TT>isConnected</TT> function.
 */

- (void)connect;
/**< Initiate connection to the overall Push Channel service.
 * Call this function to establish, or re-establish, the Push
 * Channel connection with the Good Dynamics proxy infrastructure Network
 * Operation Center (NOC).
 *
 * Establishing the connection involves a number of messages being
 * exchanged with the NOC. The <TT>onStatus</TT> callback in the
 * delegate will be invoked as this progresses.
 *
 * If mobile data coverage is lost after this function has been called,
 * the Push Channel connection will stop operating.
 * The Good Dynamics Runtime will automatically attempt to re-establish
 * the Push Channel connection when coverage is regained.
 * The Good Dynamics Runtime uses the native
 * System Configuration feature to
 * be notified of coverage status.
 * 
 */

- (void)disconnect;
/**< Terminate the connection to the Push Channel service.
 * Call this function to terminate the Push Channel connection with
 * the Good Dynamics proxy infrastructure Network Operation Center (NOC).
 *
 * If the connection was open and operating, termination will result in the
 * <TT>onStatus</TT> callback in the delegate being
 * invoked.
 * 
 */

- (BOOL)isConnected;
/**< Get state of the connection to the Push Channel service.
 * This function returns the current status of the Push
 * Channel connection.
 * \return <TT>YES</TT> if the Push Channel connection is open and operating, and
 * the Push Channel service is available.
 * \return <TT>NO</TT> otherwise.
 * 
 */

@property (nonatomic, assign) id<GDPushConnectionDelegate> delegate;
/**< Delegated event-handling.
 * The Push Connection object works asynchronously.
 * When its state changes, an event is generated by the Good Dynamics Runtime,
 * and passed to a callback function in the application.
 *
 * Set this property to an instance of a class that contains the code for the
 * required callback function, i.e. a class that implements the
 *  \link GDPushConnectionDelegate GDPushConnectionDelegate\endlink protocol.
 */
@end


/** Delegate for handling GDPushChannel state transitions and received Push Channel notifications.
 * State changes that occur when using \link GDPushChannel GDPushChannel\endlink
 * are handled by creating a class that implements this protocol.
 * The callback for handling received Push Channel notifications is also part
 * of this protocol.
 * \see \ref st01pushchannel
 *
 *  <H2>Code Snippets</H2> The following code snippets illustrate some common tasks.
 * <H3>Receive Push Channel Token</H3>
 * \code
 * -(void)onChannelOpen:(NSString*)token
 * {
 *     NSLog(@"onChannelOpen token: %@", token);
 *     myApp.pushIsOpen = YES;
 *     myApp.pushToken = token;
 *     [myApp sendPushToken];
 * }
 * \endcode
 * The above snippet shows a simple <TT>onChannelOpen</TT> handler. The
 * following takes place when the Push Channel is opened:
 * - The token is logged to the system monitor
 * - The application's channel state is flagged as connected
 * - The token is stored in the application
 * - The application's <TT>sendPushToken</TT> function is called
 *
 * The <TT>sendPushToken</TT> function, which would be written by the
 * application developer, would send the token to the
 * application server. This could use a socket, an HTTP
 * request, or another means of communication. From the Push Channel
 * point of view, this is an out-of-band communication.
 *
 * The server will use the token to address Push Channel notification messages
 * back to the mobile application. These would be received by the mobile
 * application's onChannelMessage handler.
 *
 * <H3>Receive Push Channel notification</H3>
 * \code
 * -(void)onChannelMessage:(NSString*)data
 * {
 *     NSLog(@"onChannelMessage: %@", data);
 *     [myApp processPush:data];
 * }
 * \endcode
 * The above snippet shows a simple <TT>onChannelMessage</TT> handler.
 *
 * The handler logs the received data to the system monitor, then calls the
 * application <TT>processPush</TT> function. The "payload" of the notification
 * is passed as a parameter to the <TT>processPush</TT> function.
 *
 * The <TT>processPush</TT> function, which would be written by the
 * application developer, could initiate any of the following actions:
 * - Alert the user that new data is available.
 * - Connect to the application server to retrieve the data. (Connection
 * could use a socket, an HTTP
 * request, or another means of communication. From the Push Channel
 * point of view, this is an out-of-band communication.)
 *
 * <H3>Handle Channel Closure</H3>
 * \code
 * -(void)onChannelClose:(NSString*)data
 * {
 *     NSLog(@"onChannelClose: %@", data);
 *     myApp.pushIsOpen = NO;
 *     [myApp discardPushToken:data];
 * }
 * \endcode
 * The above snippet shows a simple <TT>onChannelClose</TT> handler. The
 * following takes place when the Push Channel is closed:
 * - The token is logged to the system monitor
 * - The application's channel state is flagged as not connected
 * - The application <TT>discardPushToken</TT> function is called. The
 * token of the closed channel is passed as a parameter.
 *
 * The <TT>discardPushToken</TT> function would delete the application's
 * copy of the token, possibly after checking that it matches the
 * <TT>whichWas</TT> parameter.
 * The function could also initiate connection of a new Push Channel, which
 * would have a new token. See \link GDPushChannel::connect connect\endlink.
 *
 * <H3>Handle Channel Error</H3>
 * \code
 * -(void)onChannelError:(int)error
 * {
 *     NSLog(@"onChannelError: %d", error);
 *     myApp.pushIsOpen = NO;
 *     myApp.pushErr = error;
 *     [myApp discardPushToken];
 * }
 * \endcode
 * The above snippet shows a simple <TT>onChannelError</TT> handler.
 *
 * The handler logs the error code to the system monitor, flags
 * the channel's state as not connected, records the error code in
 * the application, then calls the application <TT>discardPushToken</TT>
 * function.
 *
 * The <TT>discardPushToken</TT> function could do any of the following:
 * - Delete the application's copy of the token.
 * - Set the error state in an ongoing status display.
 * - Depending on the error code, initiate connection of a new
 * Push Channel, which would have a new token. See \link GDPushChannel::connect connect\endlink.
 *
 * <H3>Handle Ping Failure</H3>
 * See under  \link GDPushChannelDelegate::onChannelPingFail: onChannelPingFail\endlink
 * for an explanation of the Ping Failure feature.

 * \code
 * -(void)onChannelPingFail:(int)error
 * {
 *     NSLog(@"onChannelPingFail %d", error);
 *     if ( error == 605 ) {
 *         [myApp resendPushToken];
 *     }
 * }
 * \endcode
 * The above snippet shows a simple <TT>onChannelPingFail</TT> handler.
 *
 * The handler logs the error code to the system monitor,
 * then calls the application <TT>resendPushToken</TT> function if the
 * token was lost.
 *
 * The <TT>resendPushToken</TT> function, which would be written by the
 * application developer, would send the application's stored token to the
 * application server. This could use a socket, an HTTP
 * request, or another means of communication. From the Push Channel
 * point of view, this is an out-of-band communication.
 *
 * The <TT>resendPushToken</TT> function should expect that the server is
 * not immediately available, perhaps employing a retry policy.
 */
@protocol GDPushChannelDelegate

- (void)onChannelOpen:(NSString*)token;
/**< Channel opened callback.
 * This callback will be invoked when the associated Push Channel is
 * opened in the Good Dynamics proxy infrastructure. See 
 * \link GDPushChannel::connect connect\endlink. At this point, a Push
 * Channel token will have been issued by the Good Dynamics proxy
 * infrastructure Network Operation Center (NOC).
 *
 * The function that is invoked must initiate sending of the token to
 * the application server, out of band.
 * The application server will then be able to use the token to address
 * Push Channel notifications back to the application on the device,
 * via the NOC.
 *
 * \see \ref GNP
 *
 * Invocation of this callback also notifies the application on the device
 * that any of the following callbacks could now be invoked:
 * <TT>onChannelMessage</TT>, <TT>onChannelPingFail</TT>, <TT>onChannelClose</TT>.
 *
 * \param token <TT>NSString</TT> containing the
 * Push Channel token issued by the NOC.
 */

- (void)onChannelMessage:(NSString*)data;
/**< Push Channel notification callback.
 * This callback will be invoked when a Push Channel notification is
 * received on the associated Push Channel. The message will have been sent by the
 * application server, using the Push Channel notify service, which is hosted
 * by the Good Dynamics Network Operation Center (NOC).
 *
 * The service supports a "payload" of data to be included in the notification.
 * The data could be in any format chosen by the application developer.
 * The payload could also be empty.
 *
 * Note that Push Channel notifications can be received at any time when
 * the channel is open, and the Push Connection is open and operating.
 * This includes the interval between the request for disconnection
 * (<TT>disconnect</TT> called) and channel disconnection being finalized
 * (<TT>onChannelClose</TT> received).
 *
 * The function that is invoked could initiate the following actions:
 * - Alert the user that new data is available.
 * - Connect to the application server to retrieve the data.
 * .
 *
 * \param data <TT>NSString</TT> containing the data
 * payload included by the application server, encoded in UTF-8.
 *
 * \note
 * Because of this callback, the mobile application code does not need to
 * maintain a constant connection with the server. This is an important benefit
 * of using the Good Dynamics Push Channel framework.
 * \see \link GDPushConnection GDPushConnection\endlink
 * \see \ref GNP
 */

- (void)onChannelClose:(NSString*)data;
/**< Channel closed callback.
 * This callback will be invoked when the associated Push Channel is
 * closed.
 * This means closed by the remote end, or by the application having
 * called \link GDPushChannel::disconnect disconnect\endlink.
 *
 * Invocation of this callback notifies the application on the device
 * that:
 * - The associated Push Channel token cannot be used any more
 * - No more Push Channel notifications will be received on this channel
 *
 * If the <TT>onChannelClose</TT> was not expected, the function that is
 * invoked could alert the user that Push Channel notifications will not be
 * received, or cause this to be displayed as an ongoing state.
 * The function could also initiate release of the Push Channel object.
 * Alternatively, reconnection could be initiated, see
 * \link GDPushChannel::connect connect\endlink.
 *
 * \param data Token for the Push Channel that was closed.
 *
 * Note that this callback is only invoked for permanent Push Channel closure.
 * This callback is not invoked for transient losses of channel communication.
 * For example, this callback is not invoked when the mobile device loses
 * packet data coverage or otherwise cannot connect to the Good Dynamics proxy
 * infrastructure.
 * Losses of connection, which affect all Push Channels, can be monitored
 * by the GD Push Connection event handler. See  \link GDPushConnectionDelegate GDPushConnectionDelegate\endlink.
 */

- (void)onChannelError:(int)error;
/**< Generic channel error callback.
 * This callback is invoked when a permanent error condition is encountered on
 * the associated Push Channel.
 *
 * Invocation of this callback notifies the application that the Push
 * Channel token cannot be used any more, or that the channel could not
 * be connected in the first place. Furthermore, no (more) Push Channel
 * notifications will be received on this channel.
 *
 * The function that is invoked could alert the user that Push Channel
 * notifications will not be received, or cause this to be displayed as an
 * ongoing state.
 * The function that is invoked should initiate reconnection, see
 * \link GDPushChannel::connect connect\endlink, after checking that the Push Channel service is
 * available, see  \link GDPushConnection::isConnected isConnected\endlink.
 *
 * \param error Reason code for the condition encountered,
 * as follows.<TABLE
 *     ><TR><TH>error</TH><TH>Channel Error reason</TH
 *     ></TR><TR><TD
 *         >0</TD
 *     ><TD
 *         >Push is not currently connected.</TD
 *     ></TR><TR><TD
 *         >200-499</TD
 *     ><TD
 *         >Internal error.</TD
 *     ></TR><TR><TD
 *         >500-599</TD
 *     ><TD
 *         >Internal server error.</TD
 *     ></TR
 * ></TABLE>
 */

- (void)onChannelPingFail:(int)error;
/**< Specific Ping Failure callback.
 * This callback is invoked when Ping Failure is encountered on
 * the associated Push Channel.
 *
 * \par Ping Failure
 * Ping Failure is an optional feature of the Push Channel
 * framework.
 * The application server registers for ping after receiving the Push Channel
 * token from the mobile application.\n
 * If an application server registers for ping, then the
 * server will be periodically checked ("pinged") by the Good Dynamics
 * Network Operation Center (NOC).
 * If the server does not respond to a ping, then the NOC notifies the mobile
 * application.\n
 * The purpose of this feature is to support servers that lose the Push Channel
 * token when they are restarted.
 *
 * The function that is invoked should initiate resending of the Push
 * Channel token to the application server, if the token has been lost. This is
 * similar to the processing when the channel is initially opened, see
 *  \link GDPushChannelDelegate::onChannelOpen: onChannelOpen\endlink. If the application server is
 * able to accept the token, then Push Channel notification can resume.
 *
 * \see \ref GNP
 *
 * Note that Ping Fail notifications can be received at any time when
 * the channel is open.
 * This includes the interval between the request for disconnection
 * (<TT>disconnect</TT> called) and channel disconnection being finalized
 * (<TT>onChannelClose</TT> received).
 *
 * \param error Reason code for the condition encountered,
 * as follows.<TABLE>
 *     <TR><TH>error</TH><TH>Ping Failure reason</TH
 *     ></TR><TR><TD
 *         >600</TD
 *     ><TD
 *         >Application server address could not be resolved via DNS</TD
 *     ></TR><TR><TD
 *         >601</TD
 *     ><TD
 *         >Could not connect to application server address</TD
 *     ></TR><TR><TD
 *         >602</TD
 *     ><TD
 *         >Application server TLS/SSL certificate invalid</TD
 *     ></TR><TR><TD
 *         >603</TD
 *     ><TD
 *         >Timed out waiting for application server HTTP response</TD
 *     ></TR><TR><TD
 *         >604</TD
 *     ><TD
 *         >Application server returned an invalid response</TD
 *     ></TR><TR><TD
 *         >605</TD
 *     ><TD
 *         >Application server indicated that token is unknown</TD
 *     ></TR>
 * </TABLE>
 * Note that only error 605 means that the token has been lost and must be
 * resent.
 */

@end


/** Manage Push Channel tokens and notifications.
 * The Push Channel framework is a Good Dynamics (GD) feature
 * used to receive notifications from an application server.
 *
 * Note that the GD Push Channel feature is not part of the native iOS
 * notification feature set.
 *
 * Push Channels cannot be established until Good Dynamics authorization
 * processing is complete.
 * In addition, Push Channels are dependent on the Push Connection.
 * Push Channels can only be established when the Push Connection is open and
 * operating.
 *
 * Push Channel data communication does not go via the proxy specified in the
 * device's native settings, if any.
 *
 * \see \link GDPushConnection GDPushConnection\endlink
 * \see <A HREF="https://community.good.com/docs/DOC-1061" target="_blank" >Good Dynamics Administrator and Developer Overview</A > for an introduction to Good Dynamics.
 * \see \ref threads
 * \see \ref background_execution
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Introduction/Introduction.html"
 *     target="_blank"
 * >Local and Push Notification Programming Guide</A> in the iOS Developer
 * Library on apple.com
 *
 * <H3>Push Channel Usage</H3>
 * Push Channels are established by the mobile application, then used by the
 * server when needed. The sequence of events is as follows:
 * -# The mobile application sets an event handler for Push Channel
 *    notifications.
 * -# The mobile application requests a Push Channel token from the Good
 *    Dynamics proxy infrastructure.
 * -# The mobile application sends the token to its server using, for example, a
 *    socket or HTTP request.
 * -# The mobile application can now wait for a Push Channel notification.\n\n
 * Later, when the server has data for the user, the following steps take
 * place:\n\n
 * -# The server sends a Push Channel notification message through the Good
 *    Dynamics proxy infrastructure. The message is addressed using the token.
 * -# The message is sent on, to the device, and the waiting application's event
 *    handler is invoked.\n\n
 * Later, when the server has more data for the user, the following steps
 * take place:\n\n
 * -# The server sends another Push Channel notification message through the
 *    Good Dynamics proxy infrastructure. The message is addressed using the
 *    same token.
 * -# The message is sent on, to the device, and the waiting mobile
 *    application's event handler is invoked again.
 * .
 * (The above is also shown in the \ref sq01pushchannel.)
 *
 * The Good Dynamics platform keeps data communications between mobile
 * application and server alive while the mobile application is waiting for a
 * Push Channel notification. This is achieved by sending "heartbeat" messages
 * at an interval that is dynamically optimized for battery and network
 * performance.
 *
 * <H3>API Overview</H3>
 * The Push Channel API is asynchronous and state-based.
 * The application attaches its own event-handler callbacks to the
 * Push Channel object.
 * The callbacks are invoked when channel events occur, or when the channel
 * changes state.
 * Which API functions can be called by the application at any time also
 * depend on the channel's state.
 *
 * Callbacks are attached through a delegate class.
 * The states in which each callback may be expected to be invoked are
 * detailed in the delegate class's documentation, see 
 *  \link GDPushConnectionDelegate GDPushConnectionDelegate\endlink.
 *
 * The availability of API functions, and what actions take place,
 * are detailed below, and summarized in the following table.
 * The table also summarizes which callbacks may expect to be invoked
 * in each state.
 * <TABLE>
 *     <TR><TH>State</TH><TH>Functions / Actions</TH><TH>Expected callbacks</TH
 *
 *     ></TR><TR><TD
 *         >Prepared</TD
 *     ><TD
 *         >Application can call <TT>connect</TT>: state becomes Connecting</TD
 *     ><TD
 *         >None</TD
 *
 *     ></TR><TR><TD
 *         >Connecting</TD
 *     ><TD
 *         >Good Dynamics Runtime requests a new channel from the
 *         Good Dynamics proxy infrastructure</TD
 *     ><TD
 *         ><TT>onChannelError</TT>: new state is Failed\n
 *         <TT>onChannelOpen</TT>: new state is Open</TD
 *
 *     ></TR><TR><TD
 *         >Open</TD
 *     ><TD
 *         >Application can call <TT>disconnect</TT>: state becomes
 *         Disconnecting</TD
 *     ><TD
 *         ><TT>onChannelMessage</TT>: no state change\n
 *         <TT>onChannelPingFail</TT>: no state change\n
 *         <TT>onChannelClose</TT>: new state is Disconnected</TD
 *
 *     ></TR><TR><TD
 *         >Disconnecting</TD
 *     ><TD
 *         >Good Dynamics Runtime requests the Good Dynamics proxy
 *         infrastructure to close the channel</TD
 *     ><TD
 *         ><TT>onChannelMessage</TT>: no state change\n
 *         <TT>onChannelPingFail</TT>: no state change\n
 *         <TT>onChannelClose</TT>:&nbsp;new&nbsp;state&nbsp;is&nbsp;Disconnected</TD
 *
 *     ></TR><TR><TD
 *         >Disconnected</TD
 *     ><TD
 *         >Application can call <TT>connect</TT>: state becomes Connecting</TD
 *     ><TD
 *         >None</TD
 *
 *     ></TR><TR><TD
 *         >Failed</TD
 *     ><TD
 *         >Application can call <TT>connect</TT>: state becomes Connecting</TD
 *     ><TD
 *         >None</TD
 *     ></TR
 * ></TABLE
 * >The transitions in the above table are also shown in the
 * \ref st01pushchannel.
 * Note that an individual Push Channel might or might not be closed when the
 * overall Push Connection is terminated.
 *
 * \see \ref GNP
 * 
 * <H3>Notification feature differences</H3>
 * The capabilities of the GD Push Channel feature are different to the
 * capabilities of the native iOS notification features in the following ways.
 *
 * Only native notifications can be received when the application is in
 * background. This might change in a future release of iOS.
 *
 * In principle, native notifications alert the user, not the application.
 * Having been alerted, the user may choose to open the application.
 * GD Push Channel notifications alert the application, which in turn may alert
 * the user.
 *
 * GD Push Channel notification messages can include a "payload" of application
 * data from the server. The application data is conveyed by the proxy
 * infrastructure from the server to the mobile application.
 *
 * Native push notifications are sent through the Apple Push Notification
 * service (APNs). Native notifications may therefore be received whenever the
 * device has a connection to the APNs.
 * GD Push Channel notification messages are sent through the GD Push
 * Connection, which is the mobile application's connection to the Good Dynamics
 * proxy infrastructure. GD notifications may therefore be received whenever the
 * Push Connection is open and operating.
 *
 *  <H2>Code Snippets</H2> The following code snippets illustrate some common tasks.
 * <H3>Create Push Channel</H3>
 * The following snippet shows a Push Channel being created as soon as the
 * Push Connection is ready. In this case, the code to create the Push Channel
 * is in the Push Connection's state-change handler, see also
 *  \link GDPushConnectionDelegate GDPushConnectionDelegate\endlink
 * \code
 * -(void)onStatus:(int)status
 * {
 *     NSLog( @"onStatus %d!", status );
 *     if ([[GDPushConnection sharedConnection] isConnected]) {
 *         NSLog( @"Push Channel service available");
 *         myChannel = [[GDPushChannel alloc] init];
 *         myHandler = [[AppChannelHandler alloc] init]
 *         myChannel.delegate = myHandler;
 *         [myChannel connect];
 *     }
 * }
 * \endcode
 * The above snippet shows the following taking place when the Push Channel
 * service becomes available:
 * - Availability logged to the system monitor
 * - Allocation and preparation of a Push Channel object
 * - Allocation and preparation of a Push Channel event handler
 * - Association of the handler with the new Push Channel object
 * - Initiation of Push Channel connection
 * .
 * The attempt to connect is asynchronous, with the associated
 *  \link GDPushChannelDelegate::onChannelOpen: onChannelOpen\endlink
 * callback being invoked when the attempt succeeds (not shown).
 *
 * <H3>Close Push Channel</H3>
 * \code
 * [myChannel disconnect];
 * \endcode
 * The request to disconnect is asynchronous, with the associated
 *  \link GDPushChannelDelegate::onChannelClose: onChannelClose\endlink
 * callback being invoked when the attempt succeeds (not shown).
 */
@interface GDPushChannel : NSObject {
    id<GDPushChannelDelegate> delegate;
    @private
    void* m_pushChannelInternal;
}

- (id)init;
/**< Constructor that prepares a new Push Channel.
 * Call this function to construct a new Push Channel object. This
 * function does not initiate data communication.
 * See \link GDPushChannel::connect connect\endlink.
 * 
 */

- (void)connect;
/**< Connect Push Channel.
 * Call this function to open the Push Channel.
 * This function can only be called when the channel is not open.
 *
 * This function causes a request for a Push Channel to be sent to the
 * Good Dynamics proxy infrastructure Network Operation Center (NOC).
 * The NOC will create the channel, and issue a Push Channel token, which can
 * then be used to identify the channel.
 *
 * The connection attempt is asynchronous. If the attempt succeeds, the Push
 * Channel token will be passed to the
 *  \link GDPushChannelDelegate::onChannelOpen: onChannelOpen\endlink callback in the
 * delegate.
 * If the attempt fails, an error code will be passed to the 
 *  \link GDPushChannelDelegate::onChannelError: onChannelError\endlink callback in the
 * delegate instead.
 *
 * Logically, Push Channels exist within the Push Connection.
 * Opening a Push Channel will not succeed if the Push Connection is not open
 * and operating.
 * \see \link GDPushConnection GDPushConnection\endlink
 * 
 */

- (void)disconnect;
/**< Disconnect Push Channel.
 * Call this function to initiate permanent disconnection of the
 * Push Channel. This function can only be called when the channel is open.
 *
 * This function causes a request for Push Channel termination to be sent to
 * the Good Dynamics proxy infrastructure Network Operation Center (NOC).
 * The NOC will delete the channel, and invalidate the Push Channel token that
 * was issued when the channel was initially opened, see
 * \link GDPushChannel::connect connect\endlink.
 *
 * Disconnection is asynchronous. Once disconnection is complete, the
 *  \link GDPushChannelDelegate::onChannelClose: onChannelClose\endlink callback in the 
 * delegate will be invoked.
 *
 * Note. This function is for permanent closure of the channel. Transient
 * suspension of Push Channel notifications may be more easily accomplished
 * out-of-band, by direct communication with the application server.
 *
 * If the connection with the NOC is open and operating, and the
 * application server that was sent the token registered for
 * <TT>isDisconnected</TT>, then a disconnect notification will be sent to the
 * application server, by the NOC. See the \ref GNP.
 * 
 */

@property (nonatomic, assign) id<GDPushChannelDelegate> delegate;
/**< Delegated event-handling.
 * The Push Channel object works asynchronously. When its state changes, or a
 * Push Channel notification is received, an event is generated by the Good
 * Dynamics Runtime, and passed to a callback function in the application code.
 *
 * Set this property to an instance of a class that contains the code for the
 * required callback functions, i.e. a class that implements
 * the  \link GDPushChannelDelegate GDPushChannelDelegate\endlink protocol.
 */

@end

#endif /* __GD_PUSH_IOS_H__ */

