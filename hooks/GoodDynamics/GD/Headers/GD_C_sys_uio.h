/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#pragma once

#include <sys/uio.h>

/** \addtogroup capilist
 * @{
 */

#ifdef __cplusplus
extern "C" {
#endif
    
#ifndef GD_C_API
# define GD_C_API
#endif
    
    GD_C_API ssize_t	GD_readv(int, const struct iovec *, int);
    /**< C API.
     */
    GD_C_API ssize_t	GD_writev(int, const struct iovec *, int);
    /**< C API.
     */

#ifdef __cplusplus
}
#endif

/** @}
 */
