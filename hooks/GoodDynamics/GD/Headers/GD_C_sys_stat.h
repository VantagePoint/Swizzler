/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#pragma once

#include <sys/stat.h>

/** \addtogroup capilist
 * @{
 */

#ifdef __cplusplus
extern "C" {
#endif
    
#ifndef GD_C_API
# define GD_C_API
#endif
    
    GD_C_API int GD_UNISTD_fstat(int fd, struct stat *s);
    /**< C API.
     */

#ifdef __cplusplus
}
#endif

/** @}
 */
