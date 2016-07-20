/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#pragma once

/** \addtogroup capilist
 * @{
 */

#ifdef __cplusplus
extern "C" {
#endif

#ifndef GD_C_API
# define GD_C_API
#endif

#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>

#define GD_ROUTE_INFO_IS_PRESENT    1
#define GD_ROUTE_INFO_OFFSET_FLAG   12
#define GD_ROUTE_INFO_OFFSET_VALUE  13

enum GD_ROUTE
{
    GD_ROUTE_UNKNOWN,
    GD_ROUTE_INTERNET,
    GD_ROUTE_GOOD_PROXY
};

GD_C_API struct hostent* GD_gethostbyname(const char* name);
/**< C API.
 */

GD_C_API int GD_getaddrinfo(const char* node,
                            const char* service,
                            const struct addrinfo* hints,
                            struct addrinfo** addresses);
/**< C API.
 */

GD_C_API int GD_getnameinfo(const struct sockaddr* address, socklen_t addressLength,
                            char* node, size_t nodeLength,
                            char* service, size_t serviceLength,
                            int flags);
/**< C API.
 */

#ifdef __cplusplus
}
#endif

/** @}
 */
