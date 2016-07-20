/*
 * (c) 2014 Good Technology Corporation. All rights reserved.
 */

#ifndef GD_C_PACUTILITIES_H
#define GD_C_PACUTILITIES_H

/** \addtogroup capilist
 * @{
 */

/** Good Proxy IP address retrieval completion callback.
 * Pass a reference to a function of this type as the <TT>callback</TT>
 * parameter to the GD_myipaddress() function.
 *
 * The callback receives one parameter.
 * \param myIP <TT>char *</TT> containing an IP address, or an empty string, or
 *             NULL. See GD_myipaddress() for details.
 */
typedef void (*completionCallback)(const char *myIP);

/** Good Proxy IP address retrieval completion extended callback.
 * Pass a reference to a function of this type as the <TT>callback</TT>
 * parameter to the GD_myipaddressEx() function.
 *
 * The callback receives two parameters.
 * 
 * \param myIP <TT>char *</TT> containing an IP address, or an empty string, or
 *             NULL. See GD_myipaddress() for details.
 *                     
 * \param data <TT>void *</TT> pointer to the extended data that was passed to
 *             the original function call.
 */
typedef void (*completionCallbackEx)(const char *myIP, const void *data);

#ifdef __cplusplus
extern "C" {
#endif
    
#ifndef GD_C_API
# define GD_C_API
#endif
    
#ifndef GD_C_API_EXT
# define GD_C_API_EXT
#endif
    
        
GD_C_API void GD_myipaddress(const char* host, unsigned int port, completionCallback callback);
/**< Get the IP address of the Good Proxy for a specified host.
 * Call this function to retrieve the IP address of the Good Proxy for a
 * specified host.
 *
 * Only hosts that are listed for client connection in the enterprise Good
 * Control server will have a Good Proxy.
 * 
 * Retrieval is asynchronous. When retrieval completes, a completion callback
 * will be invoked.\n
 * The callback will be passed a <TT>char *</TT> pointing to a buffer containing
 * the IP address if retrieval was successful. The callback must copy the
 * contents of the buffer if the IP address is to be used later. The memory for
 * the passed buffer will be released when the callback completes.\n
 * If the specified host is not listed for client connection in the enterprise
 * Good Control server then an empty string is passed to the callback instead.
 * If an error occurred then <TT>NULL</TT> is passed.
 *
 * \param host <TT>char *</TT> containing the server address of the host.
 *
 * \param port <TT>unsigned int</TT> containing the port number of the host.
 *
 * \param callback Function to execute when the retrieval completes. The
 *                 function receives one parameter as described above.
 */
    
GD_C_API void GD_myipaddressEx(const char* host, unsigned int port, completionCallbackEx callback, const void* data);
/**< Get the IP address of the Good Proxy for a specified host.
 * Call this function to retrieve the IP address of the Good Proxy for a
 * specified host and supply extended data to the results callback. This
 * function does the same retrieval as the \ref GD_myipaddress()
 * function, see above.
 *
 * The completion callback will receive extended data, which is passed as a
 * parameter to this function.
 * 
 * \param host <TT>char *</TT> containing the server address of the host.
 *
 * \param port <TT>unsigned int</TT> containing the port number of the host.
 *
 * \param callback Function to execute when the retrieval completes. The function
 *                 receives a results parameter, as described above under
 *                 \ref GD_myipaddress(), and extended data, as passed in the
 *                 <TT>data</TT> parameter, below.
 *
 * \param data <TT>void *</TT> pointer to the extended data for the callback.
 */

#ifdef __cplusplus
}
#endif

/** @}
 */

#endif
