/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#pragma once

#include <unistd.h>
#include <sys/mount.h>

/** \addtogroup capilist
 * @{
 */

#ifdef __cplusplus
extern "C" {
#endif
    
#ifndef GD_C_API
# define GD_C_API
#endif

    GD_C_API int GD_UNISTD_open(const char* path, int mode, ...);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_close(int fd);
    /**< C API.
     */
    GD_C_API ssize_t GD_UNISTD_read(int fd, void *buffer, size_t nbytes);
    /**< C API.
     */
    GD_C_API ssize_t GD_UNISTD_write(int fd, const void *buffer, size_t nbytes);
    /**< C API.
     */
    GD_C_API off_t GD_UNISTD_lseek(int fd, off_t offset, int whence);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_ftruncate(int fd, off_t length);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_truncate(const char* path, off_t length);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_fdatasync(int fd);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_fsync(int fd);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_fchown(int fd, uid_t owner, gid_t group);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_chown(const char* path, uid_t owner, gid_t group);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_lchown(const char* path, uid_t owner, gid_t group);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_chroot(const char* path);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_fchdir(int fd);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_chdir(const char* path);
    /**< C API.
     */
    GD_C_API char* GD_UNISTD_getcwd(char *buf, size_t size);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_rmdir(const char* path);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_access(const char* path, int mode);
    /**< C API.
     */
    GD_C_API long int GD_UNISTD_fpathconf(int fd, int name);
    /**< C API.
     */
    GD_C_API long int GD_UNISTD_pathconf(const char* path, int name);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_lockf(int fd, int function, off_t size);
    /**< C API.
     */
    GD_C_API char* GD_UNISTD_ttyname(int fd);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_ttyname_r(int fd, char* name, size_t namesize);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_pipe(int fds[2]);
    /**< C API.
     */
    GD_C_API ssize_t GD_UNISTD_pread(int fd, void* buffer, size_t nbyte, off_t offset);
    /**< C API.
     */
    GD_C_API ssize_t GD_UNISTD_pwrite(int fd, const void *buffer, size_t nbyte, off_t offset);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_dup(int oldd);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_dup2(int oldd, int newd);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_symlink(const char* file_path, const char* symlink_path);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_readlink(const char* path, char* buffer, size_t nbyte);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_link(const char* file_path, const char* link_path);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_unlink(const char* path);
    /**< C API.
     */
    GD_C_API void* GD_UNISTD_mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_munmap(void *addr, size_t length);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_fchmod(int fildes, mode_t mode);
    /**< C API.
     */
    GD_C_API int GD_UNISTD_fstatfs(int fd, struct statfs *buf);
    /**< C API.
     */

#ifdef __cplusplus
}
#endif

/** @}
 */
