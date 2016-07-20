/*
 File Description:
  
  ********************************
  ** C function hooks (Man (2)) **
  ********************************
	
  The functions hooked here contains POSIX C since MacOS is a POSIX compliant system.
  Functions copied from glibc and iOS Man pages.

  Section 2 of the manual contains documentation on UNIX system calls, error codes,
  and C library routines that wrap system calls. Most of these functions are described 
  in headers that reside in /usr/include/sys.
*/
#import "../../swizzler.common.h"
#import <semaphore.h>
#import <sys/socket.h>
#import <arpa/inet.h>


#import <sys/time.h>
#import <sys/stat.h>
#import <sys/semaphore.h>
#import <sys/sem.h>
#import <sys/uio.h>
#import <sys/mman.h>
#import <sys/ioctl.h>
#import <aio.h>

// Used by mmap
#import <pthread.h>
// End

// Used by statfs
#include <sys/param.h>
#include <sys/mount.h>
// End


// task_get_exception_port
#include <mach/task.h>
//End

/*
 Basic Program / System Interface
*/

//
// glibc
//

/*
 Syscall() performs the system call whose assembly language interface has
 the specified number with the specified arguments.  Symbolic constants
 for system calls can be found in the header file <sys/syscall.h>.  The
 __syscall form should be used when one or more of the parameters is a
 64-bit argument to ensure that argument alignment is correct.  This system system
 tem call is useful for testing new system calls that do not have entries
 in the C library.

 long int syscall (long int sysno, ...);
*/
int (*orig_syscall) (int number, ...);

int replaced_syscall (int number, ...)
{
    // NSLog(@"syscall: %d", number);

	// Setting up some variables to get all the parameters from syscall
    void *foo, *params[16];
    va_list argp;
    int ret, i = 0;

    va_start(argp, number);
    while ((foo = (void *) va_arg(argp, void *))) {
        params[i++] = foo;
    }
    va_end(argp);

    if (number == 26)
    {
        DDLogVerbose(@"syscall: 26 CALLING PTRACE.....KILL!");
        return orig_syscall(26, -1);
    }

    if (i == 0)
    {
        DDLogVerbose(@"syscall: %d", number);
    	ret = orig_syscall(number);
    }
    if (i == 1)
    {
        DDLogVerbose(@"syscall (2 param): %d, %s", number, params[0]);
    	ret = orig_syscall(number, params[0]);
    }
    if (i == 2)
    {
        DDLogVerbose(@"syscall (3 param): %d, %s, %s", number, params[0], params[1]);
        ret = orig_syscall(number, params[0], params[1]);
    }
    if (i == 3)
    {
        DDLogVerbose(@"syscall (4 param): %d, %s, %s, %s", number, params[0], params[1], params[2]);
        ret = orig_syscall(number, params[0], params[1], params[2]);
    }
    if (i == 4)
    {
        DDLogVerbose(@"syscall (5 param): %d, %s, %s, %s, %s", number, params[0], params[1], params[2], params[3]);
        ret = orig_syscall(number, params[0], params[1], params[2], params[3]);
    }


    return ret;
}

/*
 terminate the calling process

 void _exit (int status);
*/
void (*orig__exit) (int status);

void replaced__exit (int status)
{
    DDLogVerbose(@"_exit: %d", status);
    orig__exit(status);
}

//
// iOS Manpage
//

/*
 Syscall() performs the system call whose assembly language interface has
 the specified number with the specified arguments.  Symbolic constants
 for system calls can be found in the header file <sys/syscall.h>.  The
 __syscall form should be used when one or more of the parameters is a
 64-bit argument to ensure that argument alignment is correct.  This sys-tem system
 tem call is useful for testing new system calls that do not have entries
 in the C library.

 int _syscall (quad_t number, ...);
*/

// int (*orig___syscall) (quad_t number, ...);

// int replaced___syscall (quad_t number, ...)
// {
// 	// Setting up some variables to get all the parameters from syscall
//     void *foo, *params[16];
//     va_list argp;
//     int ret, i = 0;

//     va_start(argp, number);
//     while ((foo = (void *) va_arg(argp, void *))) {
//         params[i++] = foo;
//     }
//     va_end(argp);

//     if (number == 26)
//     {
//         // NSLog(@"CALLING PTRACE.....KILL!");
//         return orig___syscall(26, -1);
//     }

//     if (i == 0)
//     {
//     	ret = orig___syscall(number);
//     }
//     if (i == 1)
//     {
//     	ret = orig___syscall(number, params[0]);
//     }
    
//     return ret;
// }



/*
 *****************
 * Date and Time *
 *****************
*/

//
// glibc
//

/*
 Note: timezone is no longer used; this information is kept outside the
 kernel.

 The system's notion of the current Greenwich time and the current time
 zone is obtained with the gettimeofday() call, and set with the
 settimeofday() call.  The time is expressed in seconds and microseconds
 since midnight (0 hour), January 1, 1970.  The resolution of the system
 clock is hardware dependent, and the time may be updated continuously or
 in ``ticks.''  If tp or tzp is NULL, the associated time information will
 not be returned or set.

 int gettimeofday (struct timeval *tp, struct timezone *tzp);
 int settimeofday (const struct timeval *tp, const struct timezone *tzp);
*/
int (*orig_gettimeofday) (struct timeval *tp, void *tzp);
int (*orig_settimeofday) (const struct timeval *tp, const struct timezone *tzp);

int replaced_gettimeofday(struct timeval *tp, void *tzp)
{
    DDLogVerbose(@"gettimeofday");
    int ret = orig_gettimeofday(tp, tzp);
    return ret;
}
int replaced_settimeofday(const struct timeval *tp, const struct timezone *tzp)
{
    DDLogVerbose(@"settimeofday");
    int ret = orig_settimeofday(tp, tzp);
    return ret;
}

/*
 Adjtime() makes small adjustments to the system time, as returned by
 gettimeofday(2), advancing or retarding it by the time specified by the
 timeval delta.  If delta is negative, the clock is slowed down by incrementing
 it more slowly than normal until the correction is complete.  If
 delta is positive, a larger increment than normal is used.  The skew used
 to perform the correction is generally a fraction of one percent.  Thus,
 the time is always a monotonically increasing function.  A time correction
 from an earlier call to adjtime() may not be finished when adjtime()
 is called again.  If olddelta is non-nil, the structure pointed to will
 contain, upon return, the number of microseconds still to be corrected
 from the earlier call.

 This call may be used by time servers that synchronize the clocks of computers
 in a local area network.  Such time servers would slow down the
 clocks of some machines and speed up the clocks of others to bring them
 to the average network time.

 The call adjtime() is restricted to the super-user.

 int adjtime (const struct timeval *delta, struct timeval *olddelta);
*/
int (*orig_adjtime) (const struct timeval *delta, struct timeval *olddelta);

int replaced_adjtime(const struct timeval *delta, struct timeval *olddelta)
{
    DDLogVerbose(@"adjtime");
    int ret = orig_adjtime(delta, olddelta);
    return ret;
}



/*
 *************************
 * File System Interface *
 *************************
*/

//
// glibc
//

/*
 The path argument points to the pathname of a directory.  The chdir()
 function causes the named directory to become the current working directory,
 that is, the starting point for path searches of pathnames not
 beginning with a slash, `/'.

 int chdir (const char *filename);
*/
int (*orig_chdir) (const char *path);

int replaced_chdir(const char *path)
{
    DDLogVerbose(@"chdir: %s", path);
    int ret = orig_chdir(path);
    return ret;
}

/*
 The fchdir() function causes the directory referenced by fildes to become
 the current working directory, the starting point for path searches of
 pathnames not beginning with a slash, `/'.

 int fchdir (int filedes);
*/
int (*orig_fchdir) (int fildes);

int replaced_fchdir(int fildes)
{
    DDLogVerbose(@"fchdir");
    int ret = orig_fchdir(fildes);
    return ret;
}

/*
 The link() function call atomically creates the specified directory entry
 (hard link) path2 with the attributes of the underlying object pointed at
 by path1.  If the link is successful, the link count of the underlying
 object is incremented; path1 and path2 share equal access and rights to
 the underlying object.

 int link (const char *oldname, const char *newname);
*/
int (*orig_link) (const char *path1, const char *path2);

int replaced_link(const char *path1, const char *path2)
{
    DDLogVerbose(@"link: %s -> %s", path1, path2);
    int ret = orig_link(path1, path2);
    return ret;
}

/*
 A symbolic link path2 is created to path1 (path2 is the name of the file
 created, path1 is the string used in creating the symbolic link).  Either
 name may be an arbitrary path name; the files need not be on the same
 file system.

 int symlink (const char *oldname, const char *newname);
*/
int (*orig_symlink) (const char *path1, const char *path2);

int replaced_symlink(const char *path1, const char *path2)
{
    DDLogVerbose(@"symlink: %s -> %s", path1, path2);
    int ret = orig_symlink(path1, path2);
    return ret;
}

/*
 Readlink() places the contents of the symbolic link path in the buffer
 buf, which has size bufsize.  Readlink does not append a NUL character to
 buf.
 
 ssize_t readlink (const char *filename, char *buffer, size_t size);
*/
ssize_t (*orig_readlink) (const char *path, char *buf, size_t bufsize);

ssize_t replaced_readlink(const char *path, char *buf, size_t bufsize)
{
    // NSLog(@"readlink");
    DDLogVerbose(@"readlink: %s", path);
    ssize_t ret = orig_readlink(path, buf, bufsize);
    return ret;
}

/*
 The unlink() function removes the link named by path from its directory
 and decrements the link count of the file which was referenced by the
 link.  If that decrement reduces the link count of the file to zero, and
 no process has the file open, then all resources associated with the file
 are reclaimed.  If one or more process have the file open when the last
 link is removed, the link is removed, but the removal of the file is
 delayed until all references to it have been closed.

 int unlink (const char *filename);
*/
int (*orig_unlink) (const char *path);

int replaced_unlink(const char *path)
{
    DDLogVerbose(@"unlink: %s", path);
    int ret = orig_unlink(path);
    return ret;
}

/*
 Rmdir() removes a directory file whose name is given by path.  The directory 
 must not have any entries other than `.' and `..'.
 
 int rmdir (const char *filename);
*/
int (*orig_rmdir) (const char *path);

int replaced_rmdir(const char *path)
{
    DDLogVerbose(@"rmdir: %s", path);
    int ret = orig_rmdir(path);
    return ret;
}

/*
 The rename() system call causes the link named old to be renamed as new.
 If new exists, it is first removed.  Both old and new must be of the same
 type (that is, both must be either directories or non-directories) and
 must reside on the same file system.

 The rename() system call guarantees that an instance of new will always
 exist, even if the system should crash in the middle of the operation.

 If the final component of old is a symbolic link, the symbolic link is
 renamed, not the file or directory to which it points.

 int rename (const char *oldname, const char *newname);
*/

int (*orig_rename) (const char *oldname, const char *newname);

int replaced_rename(const char *oldname, const char *newname)
{
    DDLogVerbose(@"rename: %s -> %s", oldname, newname);
    int ret = orig_rename(oldname, newname);
    return ret;
}

/*
 The directory path is created with the access permissions specified by
 mode and restricted by the umask(2) of the calling process.

 The directory's owner ID is set to the process's effective user ID.  The
 directory's group ID is set to that of the parent directory in which it
 is created.

 int mkdir (const char *filename, mode_t mode);
*/
int (*orig_mkdir) (const char *path, mode_t mode);

int replaced_mkdir(const char *path, mode_t mode)
{
    DDLogVerbose(@"mkdir: %s, %hu", path, mode);
    int ret = orig_mkdir(path, mode);
    return ret;
}

/*
 The stat() family of functions and their 64 bit variants obtain information
 about a file. The stat() function obtains information about the file
 pointed to by path.  Read, write or execute permission of the named file
 is not required, but all directories listed in the path name leading to
 the file must be searchable.

 Lstat() is like stat() except in the case where the named file is a symbolic
 link, in which case lstat() returns information about the link,
 while stat() returns information about the file the link references.
 Unlike other filesystem objects, symbolic links do not have an owner,
 group, access mode, times, etc.  Instead, these attributes are taken from
 the directory that contains the link.  The only attributes returned from
 an lstat() that refer to the symbolic link itself are the file type
 (S_IFLNK), size, blocks, and link count (always 1).

 The fstat() obtains the same information about an open file known by the
 file descriptor fildes.

 int fstat (int filedes, struct stat *buf);
 int fstat64 (int filedes, struct stat64 *buf);
 int lstat (const char *filename, struct stat *buf);
 int lstat64 (const char *filename, struct stat64 *buf);
 int stat (const char *filename, struct stat *buf);
 int stat64 (const char *filename, struct stat64 *buf);

 Some Jailbreak detections use stat and lstat to see if a file is available
*/
int (*orig_fstat) (int fildes, struct stat *buf) = fstat;
int (*orig_lstat) (const char *path, struct stat *buf) = lstat;
int (*orig_stat) (const char *path, struct stat *buf);
// int (*orig_fstat64) (int fildes, struct stat64 *buf);
// int (*orig_lstat64) (const char *path, struct stat64 *buf);
// int (*orig_stat64) (const char *path, struct stat64 *buf);

int replaced_fstat(int fildes, struct stat *buf)
{
    DDLogVerbose(@"fstat");
    return orig_fstat(fildes, buf);
}
int replaced_lstat(const char *path, struct stat *buf)
{
    DDLogVerbose(@"lstat: %s", path);

    if (blockPath(path) && disableJBDectection())
    {
        DDLogVerbose(@"Jailbreak detection lstat(%s), return -1", path);
        errno = ENOENT;
        return -1;
    }

    int ret = orig_lstat(path, buf);

    if(disableJBDectection() && strcmp(path, "/Applications") == 0)
    {
        DDLogVerbose(@"Jailbreak detection lstat(/Applications)");
        buf->st_mode &= ~S_IFLNK;
        buf->st_mode |= S_IFDIR;
    }

    return ret;
}
int replaced_stat(const char *path, struct stat *buf)
{
    DDLogVerbose(@"stat: %s", path);

    if (blockPath(path) && disableJBDectection())
    {
        DDLogVerbose(@"Jailbreak detection stat(%s), return -1", path);
        errno = ENOENT;
        return -1;
    }

    int ret = orig_stat(path, buf);

    // Some jailbreak checks check for fstab filesize
    if(strcmp(path, "/etc/fstab") == 0)
    {
        DDLogVerbose(@"Jailbreak detection stat(fstab), returning st_size=80");
        buf->st_size = 80;
    }

    return ret;
}
// int replaced_fstat64(int fildes, struct stat64 *buf)
// {
//     int ret = orig_fstat64(fildes, buf);
//     return ret;
// }
// int replaced_lstat64(const char *path, struct stat64 *buf)
// {
//     int ret = orig_lstat64(path, buf);
//     return ret;
// }
// int replaced_stat64(const char *path, struct stat64 *buf)
// {
//     int ret = orig_stat64(path, buf);
//     return ret;
// }
/*
 The chown() system call clears the set-user-id and set-group-id bits on
 the file to prevent accidental or mischievous creation of set-user-id and
 set-group-id programs if not executed by the super-user.  The chown()
 system call follows symbolic links to operate on the target of the link
 rather than the link itself.

 The fchown() system call is particularly useful when used in conjunction
 with the file locking primitives (see flock(2)).

 The lchown() system call is similar to chown() but does not follow symbolic links.

 int chown (const char *filename, uid_t owner, gid_t group);
 int fchown (int filedes, uid_t owner, gid_t group);
*/
int (*orig_chown) (const char *path, uid_t owner, gid_t group);
int (*orig_fchown) (int fildes, uid_t owner, gid_t group);

int replaced_chown(const char *path, uid_t owner, gid_t group)
{
    // NSLog(@"chown");
    DDLogVerbose(@"chown: %s, %u, %u", path, owner, group);
    int ret = orig_chown(path, owner, group);
    return ret;
}
int replaced_fchown(int fildes, uid_t owner, gid_t group)
{
    // NSLog(@"fchown");
    DDLogVerbose(@"fchown: %d, %u, %u", fildes, owner, group);
    int ret = orig_fchown(fildes, owner, group);
    return ret;
}

/*
 The function chmod() sets the file permission bits of the file specified
 by the pathname path to mode.  Fchmod() sets the permission bits of the
 specified file descriptor fildes.  Chmod() verifies that the process
 owner (user) either owns the file specified by path (or fildes), or is
 the super-user.

 int chmod (const char *filename, mode_t mode);
 int fchmod (int filedes, mode_t mode);
*/
int (*orig_chmod) (const char *path, mode_t mode);
int (*orig_fchmod) (int fildes, mode_t mode);

int replaced_chmod(const char *path, mode_t mode)
{
    DDLogVerbose(@"chmod");
    int ret = orig_chmod(path, mode);
    return ret;
}
int replaced_fchmod(int fildes, mode_t mode)
{
    DDLogVerbose(@"fchmod");
    int ret = orig_fchmod(fildes, mode);
    return ret;
}

/*
 The umask() routine sets the process's file mode creation mask to cmask
 and returns the previous value of the mask.  The 9 low-order access permission
 bits of cmask are used by system calls, including open(2),
 mkdir(2), mkfifo(2), and mknod(2) to turn off corresponding bits
 requested in file mode.  (See chmod(2)).  This clearing allows each user
 to restrict the default access to his files.

 The default mask value is S_IWGRP|S_IWOTH (022, write access for the
 owner only).  Child processes inherit the mask of the calling process.

 mode_t umask (mode_t mask);
*/
mode_t (*orig_umask) (mode_t cmask);

mode_t replaced_umask(mode_t cmask)
{
    DDLogVerbose(@"umask");
    mode_t ret = orig_umask(cmask);
    return ret;
}

/*
 The access() function checks the accessibility of the file named by path
 for the access permissions indicated by amode.  The value of amode is the
 bitwise inclusive OR of the access permissions to be checked (R_OK for
 read permission, W_OK for write permission and X_OK for execute/search
 permission) or the existence test, F_OK.  All components of the pathname
 path are checked for access permissions (including F_OK).

 int access (const char *filename, int how);

 Some Jailbreak detections use access to see if a file is available
*/
int (*orig_access) (const char *path, int amode);

int replaced_access(const char *path, int amode)
{
    if (blockPath(path))
    {
        if (disableJBDectection())
        {
            DDLogVerbose(@"Jailbreak detection access(%s), return -1", path);
            errno = ENOENT;
            return -1;
        }
    }
    // NSLog(@"access");
    DDLogVerbose(@"access: %s, %d", path, amode);
    int ret = orig_access(path, amode);
    return ret;
}

/*
 The access and modification times of the file named by path or referenced
 by fildes are changed as specified by the argument times.

 If times is NULL, the access and modification times are set to the current
 time.  The caller must be the owner of the file, have permission to
 write the file, or be the super-user.

 If times is non-NULL, it is assumed to point to an array of two timeval
 structures.  The access time is set to the value of the first element,
 and the modification time is set to the value of the second element.  The
 caller must be the owner of the file or be the super-user.

 In either case, the inode-change-time of the file is set to the current
 time.

 int futimes (int fd, const struct timeval tvp[2]);
 int utimes (const char *filename, const struct timeval tvp[2]);
*/
int (*orig_futimes) (int fildes, const struct timeval times[2]);
int (*orig_utimes) (const char *path, const struct timeval times[2]);

int replaced_futimes(int fildes, const struct timeval times[2])
{
    DDLogVerbose(@"futimes");
    int ret = orig_futimes(fildes, times);
    return ret;
}
int replaced_utimes(const char *path, const struct timeval times[2])
{
    DDLogVerbose(@"utimes");
    int ret = orig_utimes(path, times);
    return ret;
}

/*
 Truncate() causes the file named by path or referenced by fildes to be
 truncated or extended to length bytes in size.  If the file previously
 was larger than this size, the extra data is lost. If the file was
 smaller than this size, it will be extended as if by writing bytes with
 the value zero.  With ftruncate(), the file must be open for writing.

 int ftruncate (int fd, off_t length);
 int truncate (const char *filename, off_t length);
*/
int (*orig_ftruncate) (int fildes, off_t length);
int (*orig_truncate) (const char *path, off_t length);

int replaced_ftruncate(int fildes, off_t length)
{
    DDLogVerbose(@"ftruncate");
    int ret = orig_ftruncate(fildes, length);
    return ret;
}
int replaced_truncate(const char *path, off_t length)
{
    // NSLog(@"truncate");
    DDLogVerbose(@"truncate: %s, %lld", path, length);
    int ret = orig_truncate(path, length);
    return ret;
}

/*
 The device special file path is created with the major and minor device
 numbers extracted from mode.  The access permissions of path are constrained
 by the umask(2) of the parent process.

 If mode indicates a block or character special file, dev is a configuration-dependent
 specification of a character or block I/O device and the
 superblock of the device.  If mode does not indicate a block special or
 character special device, dev is ignored.

 Mknod() requires super-user privileges.

 int mknod (const char *filename, mode_t mode, dev_t dev);
*/
int (*orig_mknod) (const char *filename, mode_t mode, dev_t dev);

int replaced_mknod(const char *filename, mode_t mode, dev_t dev)
{
    DDLogVerbose(@"mknod: %s, %hu", filename, mode);
    int ret = orig_mknod(filename, mode, dev);
    return ret;
}


//
// iOS Man page
//

/*
 The lchown() system call is similar to chown() but does not follow symbolic links.

 int lchown(const char *path, uid_t owner, gid_t group);
*/
int (*orig_lchown) (const char *path, uid_t owner, gid_t group);

int replaced_lchown(const char *path, uid_t owner, gid_t group)
{
    DDLogVerbose(@"lchown: %s, %u, %u", path, owner, group);
    int ret = orig_lchown(path, owner, group);
    return ret;
}

/*
 set file flags

 int chflags (const char *path, u_int flags);
 int fchflags (int fd, u_int flags);
*/
int (*orig_chflags) (const char *path, u_int flags);
int (*orig_fchflags) (int fd, u_int flags);

int replaced_chflags(const char *path, u_int flags)
{
    DDLogVerbose(@"chflags: %s, %d", path, flags);
    int ret = orig_chflags(path, flags);
    return ret;
}
int replaced_fchflags(int fd, u_int flags)
{
    DDLogVerbose(@"fchflags: %d, %d", fd, flags);
    int ret = orig_fchflags(fd, flags);
    return ret;
}


/*
 Statfs() returns information about a mounted file system.

 int statfs(const char *path, struct statfs *buf);
 int statfs64(const char *path, struct statfs64 *buf);
 int fstatfs(int fd, struct statfs *buf);
 int fstatfs64(int fd, struct statfs64 *buf);
*/
int (*orig_statfs) (const char *path, struct statfs *buf);

int replaced_statfs(const char *path, struct statfs *buf)
{
    DDLogVerbose(@"statfs: %s", path);

    if (blockPath(path) && disableJBDectection())
    {
        DDLogVerbose(@"Jailbreak detection statfs(%s), return -1", path);
        errno = ENOENT;
        return -1;
    }

    int ret = orig_statfs(path, buf);

    if (disableJBDectection() && (strcmp(path, "/") == 0))
    {
        DDLogVerbose(@"Jailbreak detection looking at statfs: /");
        buf->f_flags = MNT_RDONLY + MNT_ROOTFS + MNT_DOVOLFS + MNT_JOURNALED + MNT_MULTILABEL;
    }

    NSString *npath = [[NSBundle mainBundle] resourcePath];
    if (disableJBDectection() && (strcmp(path, [npath UTF8String]) == 0))
    {
        DDLogVerbose(@"Jailbreak detection looking at statfs mainBundle: %@", npath);
        buf->f_flags = MNT_NOSUID + MNT_NODEV + MNT_DOVOLFS + MNT_JOURNALED + MNT_MULTILABEL;
    }
    
    return ret;
}




/*
 *******************************
 * Inter-process Communication *
 *******************************
*/

//
// glibc
//

/*
 The semctl() system call performs the operation indicated by cmd on the
 semaphore set indicated by semid.  A fourth argument, a union semun arg,
 is required for certain values of cmd.

 int semctl (int semid, int semnum, int cmd, ...);
*/
int (*orig_semctl) (int semid, int semnum, int cmd, ...);

int replaced_semctl(int semid, int semnum, int cmd, ...)
{
	// Only one additional param will be passed.
    void *foo, *params[1];
    va_list argp;
    int ret, i = 0;

    va_start(argp, cmd);
    while ((foo = (void *) va_arg(argp, void *))) {
        params[i++] = foo;
    }
    va_end(argp);

    if (i == 0)
    {
    	ret = orig_semctl(semid, semnum, cmd);
    }
    if (i == 1)
    {
    	ret = orig_semctl(semid, semnum, cmd, params[0]);
    }
    
    return ret;
}


/*
 Based on the values of key and semflg, semget() returns the identifier of
 a newly created or previously existing set of semaphores.

 int semget (key_t key, int nsems, int semflg);
*/
int (*orig_semget) (key_t key, int nsems, int semflg);

int replaced_semget(key_t key, int nsems, int semflg)
{
    int ret = orig_semget(key, nsems, semflg);
    return ret;
}

/*
 The semop() system call atomically performs the array of operations indicated
 by sops on the semaphore set indicated by semid.  The length of
 sops is indicated by nsops.

 int semop (int semid, struct sembuf *sops, size_t nsops);
*/
int (*orig_semop) (int semid, struct sembuf *sops, size_t nsops);

int replaced_semop(int semid, struct sembuf *sops, size_t nsops)
{
    int ret = orig_semop(semid, sops, nsops);
    return ret;
}

/*
 initialize and open a named semaphore

 sem_t *sem_open (const char *name, int oflag, ...);
*/
sem_t *(*orig_sem_open) (const char *name, int oflag, ...);

sem_t replaced_sem_open(const char *name, int oflag, ...)
{
	// Only two additional param will be passed.
    void *foo, *params[2];
    va_list argp;
    sem_t *ret, i = 0;

    va_start(argp, oflag);
    while ((foo = (void *) va_arg(argp, void *))) {
        params[i++] = foo;
    }
    va_end(argp);

    if (i == 0)
    {
    	ret = orig_sem_open(name, oflag);
    }
    if (i == 1)
    {
    	ret = orig_sem_open(name, oflag, params[0]);
    }
    if (i == 2)
    {
    	ret = orig_sem_open(name, oflag, params[0], params[1]);
    }
    
    return *ret;
}

/*
 close a named semaphore

 int sem_close (sem_t *sem);
*/
int (*orig_sem_close) (sem_t *sem);

int replaced_sem_close(sem_t *sem)
{
    int ret = orig_sem_close(sem);
    return ret;
}

/*
 remove a named semaphore

 int sem_unlink (const char *name);
*/
int (*orig_sem_unlink) (const char *name);

int replaced_sem_unlink(const char *name)
{
    int ret = orig_sem_unlink(name);
    return ret;
}

/*
 The semaphore referenced by sem is locked.  When calling sem_wait(), if
 the semaphore's value is zero, the calling thread will block until the
 lock is acquired or until the call is interrupted by a signal. Alternatively,
 the sem_trywait() function will fail if the semaphore is already
 locked, rather than blocking on the semaphore.

 If successful (the lock was acquired), sem_wait() and sem_trywait() will
 return 0.  Otherwise, -1 is returned and errno is set, and the state of
 the semaphore is unchanged.
*/
int (*orig_sem_wait) (sem_t *sem);
int (*orig_sem_trywait) (sem_t *sem);

int replaced_sem_wait(sem_t *sem)
{
    int ret = orig_sem_wait(sem);
    return ret;
}
int replaced_sem_trywait(sem_t *sem)
{
    int ret = orig_sem_trywait(sem);
    return ret;
}

/*
 The semaphore referenced by sem is unlocked, the value of the semaphore
 is incremented, and all threads which are waiting on the semaphore are
 awakened.

 int sem_post (sem_t *sem);
*/
int (*orig_sem_post) (sem_t *sem);

int replaced_sem_post(sem_t *sem)
{
    int ret = orig_sem_post(sem);
    return ret;
}




/*
 ***************
 * Job Control *
 ***************
*/

//
// glibc
//

/*
 The setsid function creates a new session.  The calling process is the
 session leader of the new session, is the process group leader of a new
 process group and has no controlling terminal.  The calling process is
 the only process in either the session or the process group.

 Upon successful completion, the setsid function returns the value of the
 process group ID of the new process group, which is the same as the
 process ID of the calling process.

 pid_t setsid (void);
*/
pid_t (*orig_setsid) (void);

pid_t replaced_setsid(void)
{
    pid_t ret = orig_setsid();
    return ret;
}

/*
 The session ID of the process identified by pid is returned by getsid().
 If pid is zero, getsid() returns the session ID of the current process.

 pid_t getsid (pid_t pid);
*/
pid_t (*orig_getsid) (pid_t pid);

pid_t replaced_getsid(pid_t pid)
{
    pid_t ret = orig_getsid(pid);
    return ret;
}

/*
 The process group of the current process is returned by getpgrp().  The
 process group of the process identified by pid is returned by getpgid().
 If pid is zero, getpgid() returns the process group of the current
 process.

 Process groups are used for distribution of signals, and by terminals to
 arbitrate requests for their input: processes that have the same process
 group as the terminal are foreground and may read, while others will
 block with a signal if they attempt to read.

 This call is thus used by programs such as csh(1) to create process
 groups in implementing job control.  The tcgetpgrp() and tcsetpgrp()
 calls are used to get/set the process group of the control terminal.

 int getpgid (pid_t pid);
 pid_t getpgrp (void);
*/
pid_t (*orig_getpgid) (pid_t pid);
pid_t (*orig_getpgrp) (void);

pid_t replaced_getpgid(pid_t pid)
{
    pid_t ret = orig_getpgid(pid);
    return ret;
}
pid_t replaced_getpgrp(void)
{
    pid_t ret = orig_getpgrp();
    return ret;
}

/*
 Setpgid() sets the process group of the specified process pid to the
 specified pgid.  If pid is zero, then the call applies to the current
 process.

 If the invoker is not the super-user, then the affected process must have
 the same effective user-id as the invoker or be a descendant of the
 invoking process.

 If the calling process is not already a session leader, setpgrp() sets
 the process group ID of the calling process to that of the calling
 process.  Any new session that this creates will have no controlling terminal.

 int setpgid (pid_t pid, pid_t pgid);
 int setpgrp (pid_t pid, pid_t pgid);
*/
int (*orig_setpgid) (pid_t pid, pid_t pgid);
pid_t (*orig_setpgrp) (void);

int replaced_setpgid(pid_t pid, pid_t pgid)
{
    int ret = orig_setpgid(pid, pgid);
    return ret;
}
pid_t replaced_setpgrp(void)
{
    pid_t ret = orig_setpgrp();
    return ret;
}



/*
 ****************************
 * Low-Level Input / Output *
 ****************************
*/

//
// glibc
//

/*
 The file name specified by path is opened for reading and/or writing, as
 specified by the argument oflag; the file descriptor is returned to the
 calling process.

 The oflag argument may indicate that the file is to be created if it does
 not exist (by specifying the O_CREAT flag).  In this case, open requires
 a third argument mode_t mode; the file is created with mode mode as
 described in chmod(2) and modified by the process' umask value (see
 umask(2)).

 int open (const char *filename, int flags[, mode_t mode]);
*/
int (*orig_open) (const char *path, int oflag, ...) = open;

int replaced_open(const char *path, int oflag, ...)
{
    int fd;
    va_list argp;
    mode_t mode;


    if (blockPath(path) && disableJBDectection())
    {
        DDLogVerbose(@"Jailbreak detection open(%s)", path);
        return -1;
    }

    // Make sure to handle the case where "mode" is passed as a third parameter when the O_CREAT bit is set in oflag.
    if (oflag & O_CREAT) {
        va_start(argp, oflag);
        mode = (mode_t)
        va_arg(argp, int);
        va_end(argp);
        fd = orig_open(path, oflag, mode);
    } else {
        fd = orig_open(path, oflag);
    }

    DDLogVerbose(@"open: %s", path);

    return fd;
}

/*
 Function Deprecated

 This interface is made obsolete by: open(2).
 The creat() function is the same as:

    open(path, O_CREAT | O_TRUNC | O_WRONLY, mode);

 int creat (const char *filename, mode_t mode);
*/
// int (*orig_creat) (const char *path, mode_t mode);

/*
 The close() call deletes a descriptor from the per-process object reference
 table.  If this is the last reference to the underlying object, the
 object will be deactivated.

 int close (int filedes);
*/
int (*orig_close) (int filedes);

int replaced_close(int filedes)
{
    DDLogVerbose(@"close: %d", filedes);
    int ret = orig_close(filedes);
    return ret;
}

/*
 Read() attempts to read nbyte bytes of data from the object referenced by
 the descriptor fildes into the buffer pointed to by buf.
 
 ssize_t read (int filedes, void *buffer, size_t size);
*/
ssize_t (*orig_read) (int fildes, void *buf, size_t nbyte);

ssize_t replaced_read(int fildes, void *buf, size_t nbyte)
{
    // NSLog(@"read");
    DDLogVerbose(@"read: %lu bytes from %d", nbyte, fildes);

    ssize_t ret = orig_read(fildes, buf, nbyte);
    // NSData *data = [[NSData alloc] initWithBytes:buf length: nbyte]; 

    if (nbyte > 500)
    {
        NSString *str = [[NSString alloc] initWithBytes:buf length:nbyte encoding:NSASCIIStringEncoding];
        DDLogVerbose(@"%@", str);
    }
   

    // [str release];

    // ssize_t ret = orig_read(fildes, buf, nbyte);

    return ret;

}

/*
 Pread() performs the same function, but reads from the
 specified position in the file without modifying the file pointer.
 
 ssize_t pread (int filedes, void *buffer, size_t size, off_t offset);
*/
ssize_t (*orig_pread) (int d, void *buf, size_t nbyte, off_t offset);

ssize_t replaced_pread(int d, void *buf, size_t nbyte, off_t offset)
{
    DDLogVerbose(@"pread");
    // NSLog(@"pread: %d, %@");
    ssize_t ret = orig_pread(d, buf, nbyte, offset);
    return ret;
}

/*
 Readv() performs the same action, but scatters the input data into the iovcnt
 buffers specified by the members of the iov array: iov[0], iov[1], ..., iov[iovcnt-1].

 ssize_t readv (int filedes, const struct iovec *vector, int count);
*/
ssize_t (*orig_readv) (int d, const struct iovec *iov, int iovcnt);

ssize_t replaced_readv(int d, const struct iovec *iov, int iovcnt)
{
    DDLogVerbose(@"readv");
    ssize_t ret = orig_readv(d, iov, iovcnt);
    return ret;
}

/*
 Write() attempts to write nbyte of data to the object referenced by the
 descriptor fildes from the buffer pointed to by buf.
 
 ssize_t write (int filedes, const void *buffer, size_t size);
*/
ssize_t (*orig_write) (int fildes, const void *buf, size_t nbyte);

ssize_t replaced_write(int fildes, const void *buf, size_t nbyte)
{
    DDLogVerbose(@"write");
    ssize_t ret = orig_write(fildes, buf, nbyte);
    return ret;
}
/*
 Pwrite() performs the same function, but writes to the
 specified position in the file without modifying the file pointer.
 
 ssize_t pwrite (int filedes, const void *buffer, size_t size, off_t offset);
*/
ssize_t (*orig_pwrite) (int fildes, const void *buf, size_t nbyte, off_t offset);

ssize_t replaced_pwrite(int fildes, const void *buf, size_t nbyte, off_t offset)
{
    DDLogVerbose(@"pwrite");
    ssize_t ret = orig_pwrite(fildes, buf, nbyte, offset);
    return ret;
}
/*
 Writev() performs the same action, but gathers the output data 
 from the iovcnt buffers specified by the members of the 
 iov array: iov[0], iov[1], ..., iov[iovcnt-1].

 ssize_t writev (int filedes, const struct iovec *vector, int count);
*/
ssize_t (*orig_writev) (int fildes, const struct iovec *iov, int iovcnt);

ssize_t replaced_writev(int fildes, const struct iovec *iov, int iovcnt)
{
    // NSLog(@"writev");
    ssize_t ret = orig_writev(fildes, iov, iovcnt);
    return ret;
}

/*
 The lseek() function repositions the offset of the file descriptor fildes
 to the argument offset, according to the directive whence.
 
 off_t lseek (int filedes, off_t offset, int whence);
*/
off_t (*orig_lseek) (int filedes, off_t offset, int whence);

off_t replaced_lseek(int fildes, off_t offset, int whence)
{
    DDLogVerbose(@"lseek");
    off_t ret = orig_lseek(fildes, offset, whence);
    return ret;
}

/*
 The mmap function causes the pages starting at addr and continuing for at
 most len bytes to be mapped from the object described by fildes, starting
 at byte offset offset.  If offset or len is not a multiple of the page-size, pagesize,
 size, the mapped region may extend past the specified range.

 void * mmap (void *address, size_t length, int protect, int flags, int filedes, off_t offset);
*/
static pthread_mutex_t mutex_mmap = PTHREAD_MUTEX_INITIALIZER;
void * (*orig_mmap) (void *addr, size_t len, int prot, int flags, int fildes, off_t offset);

void * replaced_mmap(void *addr, size_t len, int prot, int flags, int fildes, off_t offset)
{
    // NSLog(@"mmap");
    DDLogVerbose(@"mmap: %@, %lu, %d, %d, %d, %lld", addr, len, prot, flags, fildes, offset);
    // pthread_mutex_lock(&mutex_mmap);
    void * ret = orig_mmap(addr, len, prot, flags, fildes, offset);
    pthread_mutex_unlock(&mutex_mmap);
    return ret;
}

/*
 The munmap() system call deletes the mappings for the specified address
 range, causing further references to addresses within the range to gener-ate generate
 ate invalid memory references.
 
 int munmap (void *addr, size_t length);
*/
int (*orig_munmap) (void *addr, size_t len);

int replaced_munmap(void *addr, size_t len)
{
    int ret = orig_munmap(addr, len);
    return ret;
}

/*
 int msync (void *address, size_t length, int flags);
*/
int (*orig_msync) (void *addr, size_t len, int flags);

int replaced_msync(void *addr, size_t len, int flags)
{
    int ret = orig_msync(addr, len, flags);
    return ret;
}

/*
 int shm_open (const char *name, int oflag, mode_t mode);
*/
int (*orig_shm_open) (const char *name, int oflag, ...);

int replaced_shm_open(const char *name, int oflag, ...)
{
    int ret;
    va_list argp;
    mode_t mode;

    // Ok, we can pass through to the original function.
    // Make sure to handle the case where "mode" is passed as a third parameter when the O_CREAT bit is set in oflag.
    if (oflag & O_CREAT) {
        va_start(argp, oflag);
        mode = (mode_t)
        va_arg(argp, int);
        va_end(argp);
        ret = orig_shm_open(name, oflag, mode);
    } else {
        ret = orig_shm_open(name, oflag);
    }

    return ret;
}

/*
 int shm_unlink (const char *name);
*/
int (*orig_shm_unlink) (const char *name);

int replaced_shm_unlink(const char *name)
{
    int ret = orig_shm_unlink(name);
    return ret;
}

/*
 int select (int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout);
*/
int (*orig_select) (int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout);

int replaced_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout)
{
    int ret = orig_select(nfds, readfds, writefds, exceptfds, timeout);
    return ret;
}

/*
 The sync() function forces a write of dirty (modified) buffers in the
 block buffer cache out to disk. The kernel keeps this information in core
 to reduce the number of disk I/O transfers required by the system.  As
 information in the cache is lost after a system crash a sync() call is
 issued frequently by the user process update(8) (about every 30 seconds).

 void sync (void);
*/
void (*orig_sync) (void);

void replaced_sync(void)
{
	orig_sync();
}

/*
 Fsync() causes all modified data and attributes of fildes to be moved to
 a permanent storage device.
 
 int fsync (int fildes);
*/
int (*orig_fsync) (int fildes);

int replaced_fsync(int fildes)
{
    int ret = orig_fsync(fildes);
    return ret;
}

/*
 The aio_read() system call allows the calling process to read
 aiocbp->aio_nbytes from the descriptor aiocbp->aio_fildes, beginning at
 the offset aiocbp->aio_offset, into the buffer pointed to by
 aiocbp->aio_buf.

 int aio_read (struct aiocb *aiocbp);
*/
int (*orig_aio_read) (struct aiocb *aiocbp);

int replaced_aio_read(struct aiocb *aiocbp)
{
    int ret = orig_aio_read(aiocbp);
    return ret;
}

/*
 The aio_write() system call allows the calling process to write
 aiocbp->aio_nbytes from the buffer pointed to by aiocbp->aio_buf to the
 descriptor aiocbp->aio_fildes.

 int aio_write (struct aiocb *aiocbp);
*/
int (*orig_aio_write) (struct aiocb *aiocbp);

int replaced_aio_write(struct aiocb *aiocbp)
{
    int ret = orig_aio_write(aiocbp);
    return ret;
}

/*
 The aio_error() system call returns the error status of the asynchronous
 I/O request associated with the structure pointed to by aiocbp.
 
 int aio_error (const struct aiocb *aiocbp);
*/
int (*orig_aio_error) (const struct aiocb *aiocbp);

int replaced_aio_error(const struct aiocb *aiocbp)
{
    int ret = orig_aio_error(aiocbp);
    return ret;
}

/*
 The aio_return() system call returns the final status of the asynchronous
 I/O request associated with the structure pointed to by aiocbp.
 
 ssize_t aio_return (struct aiocb *aiocbp);
*/
ssize_t (*orig_aio_return) (struct aiocb *aiocbp);

ssize_t replaced_aio_return(struct aiocb *aiocbp)
{
    ssize_t ret = orig_aio_return(aiocbp);
    return ret;
}
/*
 The aio_suspend() system call suspends the calling process until at least
 one of the specified asynchronous I/O requests have completed, a signal
 is delivered, or the timeout has passed.

 int aio_suspend (const struct aiocb *const list[], int nent, const struct timespec *timeout);
*/
int (*orig_aio_suspend) (const struct aiocb *const list[], int nent, const struct timespec *timeout);

int replaced_aio_suspend(const struct aiocb *const list[], int nent, const struct timespec *timeout)
{
    int ret = orig_aio_suspend(list, nent, timeout);
    return ret;
}

/*
 The aio_cancel() system call cancels the outstanding asynchronous I/O
 request for the file descriptor specified in fildes.

 int aio_cancel (int fildes, struct aiocb *aiocbp);
*/
int (*orig_aio_cancel) (int fildes, struct aiocb *aiocbp);

int replaced_aio_cancel(int fildes, struct aiocb *aiocbp)
{
    int ret = orig_aio_cancel(fildes, aiocbp);
    return ret;
}

/*
 Fcntl() provides for control over descriptors.

 int fcntl (int filedes, int command, ...);
*/
int (*orig_fcntl) (int filedes, int cmd, ...);

int replaced_fcntl(int fildes, int cmd, ...)
{
	// Setting up some variables to get all the parameters from fnctl
    void *foo, *params[16];
    va_list argp;
    int ret, i = 0;

    va_start(argp, cmd);
    while ((foo = (void *) va_arg(argp, void *))) {
        params[i++] = foo;
    }
    va_end(argp);

    if (i == 0)
    {
    	ret = orig_fcntl(fildes, cmd);
    }
    if (i == 1)
    {
    	ret = orig_fcntl(fildes, cmd, params[0]);
    }
    
    return ret;
}
/*
 Dup() duplicates an existing object descriptor and returns its value to
 the calling process (fildes2 = dup(fildes)).
 
 int dup(int fildes);
*/
int (*orig_dup) (int fildes);

int replaced_dup(int fildes)
{
    int ret = orig_dup(fildes);
    return ret;
}

/*
 In dup2(), the value of the new descriptor fildes2 is specified.  If this
 descriptor is already in use, the descriptor is first deallocated as if a
 close(2) call had been done first.

 int dup2(int fildes, int fildes2);
*/
int (*orig_dup2) (int fildes, int fildes2);

int replaced_dup2(int fildes, int fildes2)
{
    int ret = orig_dup2(fildes, fildes2);
    return ret;
}

/*
 The ioctl() function manipulates the underlying device parameters of special
 files.  In particular, many operating characteristics of character
 special files (e.g. terminals) may be controlled with ioctl() requests.

 int ioctl (int filedes, int command, ...);
*/
int (*orig_ioctl) (int fildes, unsigned long request, ...);

int replaced_ioctl(int fildes, unsigned long request, ...)
{
	// Setting up some variables to get all the parameters from ioctl
    void *foo, *params[16];
    va_list argp;
    int ret, i = 0;

    va_start(argp, request);
    while ((foo = (void *) va_arg(argp, void *))) {
        params[i++] = foo;
    }
    va_end(argp);

    if (i == 0)
    {
    	ret = orig_ioctl(fildes, request);
    }
    if (i == 1)
    {
    	ret = orig_ioctl(fildes, request, params[0]);
    }
    
    return ret;
}




/*
 *****************
 * Pipe and FIFO *
 *****************
*/

//
// glibc
//

/*
 The pipe() function creates a pipe (an object that allows unidirectional
 data flow) and allocates a pair of file descriptors.  The first descriptor
 connects to the read end of the pipe; the second connects to the
 write end.

 Data written to fildes[1] appears on (i.e., can be read from) fildes[0].
 This allows the output of one program to be sent to another program: the
 source's standard output is set up to be the write end of the pipe; the
 sink's standard input is set up to be the read end of the pipe.  The pipe
 itself persists until all of its associated descriptors are closed.

 A pipe whose read or write end has been closed is considered widowed.
 Writing on such a pipe causes the writing process to receive a SIGPIPE
 signal.  Widowing a pipe is the only way to deliver end-of-file to a
 reader: after the reader consumes any buffered data, reading a widowed
 pipe returns a zero count.

 int pipe (int filedes[2]);
*/
int (*orig_pipe) (int fildes[2]);

int replaced_pipe(int fildes[2])
{
    DDLogVerbose(@"pipe");
    int ret = orig_pipe(fildes);
    return ret;
}

/*
 Mkfifo() creates a new fifo file with name path.  The access permissions
 are specified by mode and restricted by the umask(2) of the calling
 process.

 The fifo's owner ID is set to the process's effective user ID.  The
 fifo's group ID is set to that of the parent directory in which it is
 created.

 int mkfifo (const char *filename, mode_t mode);
*/
int (*orig_mkfifo) (const char *path, mode_t mode);

int replaced_mkfifo(const char *path, mode_t mode)
{
    DDLogVerbose(@"mkfifo");
    int ret = orig_mkfifo(path, mode);
    return ret;
}



/*
 *************
 * Processes *
 *************
*/

//
// glibc
//

/*
 Getpid() returns the process ID of the calling process.  The ID is guaranteed
 to be unique and is useful for constructing temporary file names.

 Getppid() returns the process ID of the parent of the calling process.

 pid_t getpid (void);
 pid_t getppid (void);
*/
pid_t (*orig_getpid) (void);
pid_t (*orig_getppid) (void);

pid_t replaced_getpid(void)
{
    DDLogVerbose(@"getpid");
    pid_t ret = orig_getpid();
    return ret;
}
pid_t replaced_getppid(void)
{
    DDLogVerbose(@"getppid");
    pid_t ret = orig_getppid();
    return ret;
}

/*
 Fork() causes creation of a new process.

 Fork() is not available on non-jailbroken devices
*/
pid_t (*orig_fork) (void);

pid_t replaced_fork(void)
{
    if (disableJBDectection())
    {
        DDLogVerbose(@"fork() call detected, returning -1");
        return -1;
    }

    pid_t ret = orig_fork();
    DDLogVerbose(@"fork(): %d", ret);
    return ret;
}

/*
 Vfork() can be used to create new processes without fully copying the
 address space of the old process, which is horrendously inefficient in a
 paged environment.  It is useful when the purpose of fork(2) would have
 been to create a new system context for an execve.  Vfork() differs from
 fork in that the child borrows the parent's memory and thread of control
 until a call to execve(2) or an exit (either by a call to exit(2) or
 abnormally.)  The parent process is suspended while the child is using
 its resources.

 pid_t vfork (void);
*/
pid_t (*orig_vfork) (void);

pid_t replaced_vfork(void)
{
    DDLogVerbose(@"vfork");
    pid_t ret = orig_vfork();
    return ret;
}

/*
 The wait() function suspends execution of its calling process until
 stat_loc information is available for a terminated child process, or a
 signal is received.  On return from a successful wait() call, the
 stat_loc area contains termination information about the process that
 exited as defined below.

 The wait4() call provides a more general interface for programs that need
 to wait for certain child processes, that need resource utilization statistics
 accumulated by child processes, or that require options.  The
 other wait functions are implemented using wait4().

 The pid parameter specifies the set of child processes for which to wait.
 If pid is -1, the call waits for any child process.  If pid is 0, the
 call waits for any child process in the process group of the caller.  If
 pid is greater than zero, the call waits for the process with process id
 pid.  If pid is less than -1, the call waits for any process whose
 process group id equals the absolute value of pid.

 The stat_loc parameter is defined below.  The options parameter contains
 the bitwise OR of any of the following options.  The WNOHANG option is
 used to indicate that the call should not block if there are no processes
 that wish to report status.  If the WUNTRACED option is set, children of
 the current process that are stopped due to a SIGTTIN, SIGTTOU, SIGTSTP,
 or SIGSTOP signal also have their status reported.

 If rusage is non-zero, a summary of the resources used by the terminated
 process and all its children is returned (this information is currently
 not available for stopped processes).

 When the WNOHANG option is specified and no processes wish to report status,
 wait4() returns a process id of 0.

 The waitpid() call is identical to wait4() with an rusage value of zero.
 The older wait3() call is the same as wait4() with a pid value of -1.

 pid_t waitpid (pid_t pid, int *status_ptr, int options);
 pid_t wait (int *status_ptr);
 pid_t wait4 (pid_t pid, int *status_ptr, int options, struct rusage *usage);
 pid_t wait3 (union wait *status_ptr, int options, struct rusage *usage);
*/
pid_t (*orig_waitpid) (pid_t pid, int *stat_loc, int options);
pid_t (*orig_wait) (int *stat_loc);
pid_t (*orig_wait4) (pid_t pid, int *stat_loc, int options, struct rusage *rusage);
pid_t (*orig_wait3) (int *stat_loc, int options, struct rusage *rusage);

pid_t replaced_waitpid(pid_t pid, int *stat_loc, int options)
{
    DDLogVerbose(@"waitpid");
    pid_t ret = orig_waitpid(pid, stat_loc, options);
    return ret;
}
pid_t replaced_wait(int *stat_loc)
{
    DDLogVerbose(@"wait");
    pid_t ret = orig_wait(stat_loc);
    return ret;
}
pid_t replaced_wait4(pid_t pid, int *stat_loc, int options, struct rusage *rusage)
{
    DDLogVerbose(@"wait4");
    pid_t ret = orig_wait4(pid, stat_loc, options, rusage);
    return ret;
}
pid_t replaced_wait3(int *stat_loc, int options, struct rusage *rusage)
{
    DDLogVerbose(@"wait3");
    pid_t ret = orig_wait3(stat_loc, options, rusage);
    return ret;
}


/*
 Execve() transforms the calling process into a new process.  The new
 process is constructed from an ordinary file, whose name is pointed to by
 path, called the new process file.  This file is either an executable
 object file, or a file of data for an interpreter.  An executable object
 file consists of an identifying header, followed by pages of data representing
 the initial program (text) and initialized data pages. Additional
 pages may be specified by the header to be initialized with zero
 data;  see a.out(5).

 int execve (const char *filename, char *const argv[], char *const env[]);
*/
int (*orig_execve) (const char *path, char *const argv[], char *const envp[]);

int replaced_execve(const char *path, char *const argv[], char *const envp[])
{
    DDLogVerbose(@"execve: %s", path);
    int ret = orig_execve(path, argv, envp);
    return ret;
}




/*
 *******************
 * Signal Handling *
 *******************
*/

//
// glibc
//

/*
 The kill() function sends the signal specified by sig to pid, a process
 or a group of processes.  Typically, Sig will be one of the signals specified
 in sigaction(2).  A value of 0, however, will cause error checking
 to be performed (with no signal being sent).  This can be used to check
 the validity of pid.
 
 int kill (pid_t pid, int signum);
*/
int (*orig_kill) (pid_t pid, int sig);

int replaced_kill(pid_t pid, int sig)
{
    DDLogVerbose(@"kill");
    int ret = orig_kill(pid, sig);
    return ret;
}

/*
 The killpg() function sends the signal sig to the process group pgrp.
 See sigaction(2) for a list of signals.  If pgrp is 0, killpg() sends the
 signal to the sending process's process group.

 The sending process and members of the process group must have the same
 effective user ID, or the sender must be the super-user.  As a single
 special case the continue signal SIGCONT may be sent to any process that
 is a descendant of the current process.

 int killpg (int pgid, int signum);
*/
int (*orig_killpg) (pid_t pgrp, int sig);

int replaced_killpg(pid_t pgrp, int sig)
{
    DDLogVerbose(@"killpg");
    int ret = orig_killpg(pgrp, sig);
    return ret;
}



/*
 ***********
 * Sockets *
 ***********
*/
struct sockaddr_ctl {
    u_char sc_len; /* depends on size of bundle ID string */
    u_char sc_family; /* AF_SYSTEM */
    u_int16_t ss_sysaddr; /* AF_SYS_KERNCONTROL */
    u_int32_t sc_id; /* Controller unique identifier */
    u_int32_t sc_unit; /* Developer private unit number */
    u_int32_t sc_reserved[5];
};
/*
 Bind() assigns a name to an unnamed socket.  When a socket is created
 with socket(2) it exists in a name space (address family) but has no name
 assigned.  Bind() requests that address be assigned to the socket.

 int bind (int socket, struct sockaddr *addr, socklen_t length);
*/
int (*orig_bind) (int socket, struct sockaddr *addr, socklen_t length);

int replaced_bind (int socket, struct sockaddr *addr, socklen_t length)
{
    int port = -1, ret;
    char host[256];

    if (addr->sa_family == AF_INET)
    {
        port = ntohs(((struct sockaddr_in *) addr)->sin_port);
        strncpy(host, inet_ntoa(((struct sockaddr_in *) addr)->sin_addr), sizeof(host));
    } else if (addr->sa_family == AF_INET6) {
        port = ntohs(((struct sockaddr_in6 *) addr)->sin6_port);
        inet_ntop(addr->sa_family,
                (void *) &(((struct sockaddr_in6 *) addr)->sin6_addr), host, 256);
    }

    ret = orig_bind(socket, addr, length);

    DDLogVerbose(@"bind: %d, %p, %d", socket, addr, length);
    DDLogVerbose(@"bind: %s:%d (%s [0x%x])", host, port,
            (addr->sa_family == AF_INET6) ? "IPv6" :
            (addr->sa_family == AF_INET) ? "IPv4" : "Unknown family",
            (unsigned int) addr->sa_family);

    return ret;
}

/*
 Getsockname() returns the current address for the specified socket.  The
 address_len parameter should be initialized to indicate the amount of
 space pointed to by address.  On return it contains the actual size of
 the name returned (in bytes).

 int getsockname (int socket, struct sockaddr *addr, socklen_t *length_ptr);
*/
int (*orig_getsockname) (int socket, struct sockaddr *addr, socklen_t *length_ptr);

int replaced_getsockname (int socket, struct sockaddr *addr, socklen_t *length_ptr)
{
    DDLogVerbose(@"getsockname");
    int ret = orig_getsockname(socket, addr, length_ptr);
    return ret;
}

/*
 Socket() creates an endpoint for communication and returns a descriptor.

 The domain parameter specifies a communications domain within which com-munication communication
 munication will take place; this selects the protocol family which should
 be used.  These families are defined in the include file <sys/socket.h>.
 The currently understood formats are

	AF_UNIX         (UNIX internal protocols),
	AF_INET         (ARPA Internet protocols),
	AF_ISO          (ISO protocols),
	AF_NS           (Xerox Network Systems protocols), and
	AF_IMPLINK      (IMP host at IMP link layer).

 The socket has the indicated type, which specifies the semantics of 
 communication. Currently defined types are:

	SOCK_STREAM
	SOCK_DGRAM
	SOCK_RAW
	SOCK_SEQPACKET
	SOCK_RDM

 A SOCK_STREAM type provides sequenced, reliable, two-way connection based
 byte streams.  An out-of-band data transmission mechanism may be sup-ported. supported.
 ported.  A SOCK_DGRAM socket supports datagrams (connectionless, unreli-able unreliable
 able messages of a fixed (typically small) maximum length).  A SOCK_SEQPACKET socket 
 may provide a sequenced, reliable, two-way connection-based data transmission path 
 for datagrams of fixed maximum length; a consumer may be required to read an entire packet 
 with each read system call.  This facility is protocol specific, and presently implemented only
 for PF_NS.  SOCK_RAW sockets provide access to internal network protocols and interfaces.
 The types SOCK_RAW, which is available only to the super-user, and SOCK_RDM, which is planned, 
 but not yet implemented, are not described here.

 int socket (int domain, int type, int protocol);
*/
int (*orig_socket) (int domain, int type, int protocol);

int replaced_socket (int domain, int type, int protocol)
{
    DDLogVerbose(@"socket");
    int ret = orig_socket(domain, type, protocol);
    return ret;
}

/*
 The socketpair() call creates an unnamed pair of connected sockets in the
 specified domain domain, of the specified type, and using the optionally
 specified protocol.  The descriptors used in referencing the new sockets
 are returned in socket_vector[0] and socket_vector[1].  The two sockets
 are indistinguishable.

 int socketpair (int domain, int type, int protocol, int socket_vector[2]);
*/
int (*orig_socketpair) (int domain, int type, int protocol, int socket_vector[2]);

int replaced_socketpair (int domain, int type, int protocol, int *socket_vector)
{
    DDLogVerbose(@"socketpair");
    int ret = orig_socketpair(domain, type, protocol, socket_vector);
    return ret;
}

/*
 The shutdown() call causes all or part of a full-duplex connection on the
 socket associated with socket to be shut down.  If how is SHUT_RD, fur-ther further
 ther receives will be disallowed.  If how is SHUT_WR, further sends will
 be disallowed.  If how is SHUT_RDWR, further sends and receives will be
 disallowed.

 int shutdown (int socket, int how);
*/
int (*orig_shutdown) (int socket, int how);

int replaced_shutdown (int socket, int how)
{
    DDLogVerbose(@"shutdown");
    int ret = orig_shutdown(socket, how);
    return ret;
}

/*
 initiate a connection on a socket

 int connect (int socket, struct sockaddr *addr, socklen_t length);
*/
int (*orig_connect) (int socket, struct sockaddr *addr, socklen_t length);

int replaced_connect (int socket, struct sockaddr *addr, socklen_t length)
{
    int port = -1;
    char host[1024];

    DDLogVerbose(@"connect(%d, %p, %d)", socket, addr, length);

    if (addr->sa_family == AF_INET)
    {
        port = ntohs(((struct sockaddr_in *) addr)->sin_port);
        strncpy(host, inet_ntoa(((struct sockaddr_in *) addr)->sin_addr), sizeof(host));
        DDLogVerbose(@"    IPv4 to %s:%d", host, port);

    } else if (addr->sa_family == AF_INET6) {
        port = ntohs(((struct sockaddr_in6 *) addr)->sin6_port);
        inet_ntop(addr->sa_family, (void *) &(((struct sockaddr_in6 *) addr)->sin6_addr), host, 128);
        DDLogVerbose(@"    IPv6 to %s:%d", host, port);

    } else if (addr->sa_family == AF_SYSTEM) {
        DDLogVerbose(@"    AF_SYSTEM: ss_sysaddr=%d, sc_id=%d, sc_unit=%d",
                ((struct sockaddr_ctl *) addr)->ss_sysaddr,
                ((struct sockaddr_ctl *) addr)->sc_id,
                ((struct sockaddr_ctl *) addr)->sc_unit);
    } else {
        DDLogVerbose(@"    addr family unknown: %d", addr->sa_family);
    }

   
    int ret = orig_connect(socket, addr, length);
    return ret;
}

/*
 listen for connections on a socket

 int listen (int socket, int n);
*/
int (*orig_listen) (int socket, int n);

int replaced_listen (int socket, int n)
{
    DDLogVerbose(@"listen");
    int ret = orig_listen(socket, n);
    return ret;
}

/*
 accept a connection on a socket

 int accept (int socket, struct sockaddr *addr, socklen_t *length_ptr);
*/
int (*orig_accept) (int socket, struct sockaddr *addr, socklen_t *length_ptr);

int replaced_accept (int socket, struct sockaddr *addr, socklen_t *length_ptr)
{
    int port = -1;
    char host[128]; // overflow me, baby

    int ret = orig_accept(socket, addr, length_ptr);
    NSLog(@"accept(%d, %p)", socket, addr);

    if (addr->sa_family == AF_INET)
    {
        port = ntohs(((struct sockaddr_in *) addr)->sin_port);
        strncpy(host, inet_ntoa(((struct sockaddr_in *) addr)->sin_addr), sizeof(host));
        DDLogVerbose(@"    accept: IPv4 to %s: %d", host, port);

    } else if (addr->sa_family == AF_INET6) {
        port = ntohs(((struct sockaddr_in6 *) addr)->sin6_port);
        inet_ntop(addr->sa_family,
                (void *) &(((struct sockaddr_in6 *) addr)->sin6_addr), host, 128);
        DDLogVerbose(@"    accept: IPv6 to %s: %d", host, port);

    } else if (addr->sa_family == AF_SYSTEM) {
        DDLogVerbose(@"    accept: AF_SYSTEM: ss_sysaddr= %d, sc_id=%d, sc_unit=%d",
                ((struct sockaddr_ctl *) addr)->ss_sysaddr,
                ((struct sockaddr_ctl *) addr)->sc_id,
                ((struct sockaddr_ctl *) addr)->sc_unit);
    } else {
        DDLogVerbose(@"    accept: address family unknown: %d", addr->sa_family);
    }

    return ret;
}

/*
 Getpeername() returns the name of the peer connected to socket socket.
 The address_len parameter should be initialized to indicate the amount of
 space pointed to by name.  On return it contains the actual size of the
 name returned (in bytes).  The name is truncated if the buffer provided
 is too small.

 int getpeername (int socket, struct sockaddr *addr, socklen_t *length_ptr);
*/
int (*orig_getpeername) (int socket, struct sockaddr *addr, socklen_t *length_ptr);

int replaced_getpeername (int socket, struct sockaddr *addr, socklen_t *length_ptr)
{
    DDLogVerbose(@"getpeername");
    int ret = orig_getpeername(socket, addr, length_ptr);
    return ret;
}

/* 
 Send(), sendto(), and sendmsg() are used to transmit a message to another
 socket.  Send() may be used only when the socket is in a connected state,
 while sendto() and sendmsg() may be used at any time.

 ssize_t send (int socket, const void *buffer, size_t size, int flags);
 ssize_t sendto (int socket, const void *buffer, size_t size, int flags, struct sockaddr *addr, socklen_t length);
*/
ssize_t (*orig_send) (int socket, const void *buffer, size_t size, int flags);
ssize_t (*orig_sendto) (int socket, const void *buffer, size_t size, int flags, struct sockaddr *addr, socklen_t length);

ssize_t replaced_send (int socket, const void *buffer, size_t size, int flags)
{
    DDLogVerbose(@"send");
    ssize_t ret = orig_send(socket, buffer, size, flags);
    return ret;
}

ssize_t replaced_sendto (int socket, const void *buffer, size_t size, int flags, struct sockaddr *addr, socklen_t length)
{
    DDLogVerbose(@"sendto");
    ssize_t ret = orig_sendto(socket, buffer, size, flags, addr, length);
    return ret;
}

/*
 The recvfrom() and recvmsg() system calls are used to receive messages
 from a socket, and may be used to receive data on a socket whether or not
 it is connection-oriented.

 The recv() function is normally used only on a connected socket (see connect(2)) 
 and is identical to recvfrom() with a null pointer passed as
 its address argument.  As it is redundant, it may not be supported in future releases.

 ssize_t recv (int socket, void *buffer, size_t size, int flags);
 ssize_t recvfrom (int socket, void *buffer, size_t size, int flags, struct sockaddr *addr, socklen_t *length_ptr);
*/
ssize_t (*orig_recv) (int socket, void *buffer, size_t size, int flags);
ssize_t (*orig_recvfrom) (int socket, void *buffer, size_t size, int flags, struct sockaddr *addr, socklen_t *length_ptr);

ssize_t replaced_recv (int socket, void *buffer, size_t size, int flags)
{
    // NSLog(@"recv: %d, %@, %lu, %d", socket, buffer, size, flags);
    ssize_t ret = orig_recv(socket, buffer, size, flags);
    return ret;
}

ssize_t replaced_recvfrom (int socket, void *buffer, size_t size, int flags, struct sockaddr *addr, socklen_t *length_ptr)
{
    DDLogVerbose(@"recvfrom");
    // NSLog(@"recvfrom: %d, %@, %lu, %d", socket, buffer, size, flags);
    ssize_t ret = orig_recvfrom(socket, buffer, size, flags, addr, length_ptr);
    return ret;
}

/*
 Getsockopt() and setsockopt() manipulate the options associated with a
 socket.  Options may exist at multiple protocol levels; they are always
 present at the uppermost ``socket'' level.

 int getsockopt (int socket, int level, int optname, void *optval, socklen_t *optlen_ptr);
 int setsockopt (int socket, int level, int optname, const void *optval, socklen_t optlen);
*/
int (*orig_getsockopt) (int socket, int level, int optname, void *optval, socklen_t *optlen_ptr);
int (*orig_setsockopt) (int socket, int level, int optname, const void *optval, socklen_t optlen);

int replaced_getsockopt (int socket, int level, int optname, void *optval, socklen_t *optlen_ptr)
{
    DDLogVerbose(@"getsocketopt");
    int ret = orig_getsockopt(socket, level, optname, optval, optlen_ptr);
    return ret;
}

int replaced_setsockopt (int socket, int level, int optname, const void *optval, socklen_t optlen)
{
    DDLogVerbose(@"setsocketop");
    int ret = orig_setsockopt(socket, level, optname, optval, optlen);
    return ret;
}


//
// iOS Man page
//

/* 
 Send(), sendto(), and sendmsg() are used to transmit a message to another
 socket.  Send() may be used only when the socket is in a connected state,
 while sendto() and sendmsg() may be used at any time.

 ssize_t sendmsg (int socket, const struct msghdr *buffer, int flags);
*/
ssize_t (*orig_sendmsg) (int socket, const struct msghdr *buffer, int flags);

ssize_t replaced_sendmsg (int socket, const struct msghdr *buffer, int flags)
{
    DDLogVerbose(@"sendmsg");
    ssize_t ret = orig_sendmsg(socket, buffer, flags);
    return ret;
}

/*
 The recvfrom() and recvmsg() system calls are used to receive messages
 from a socket, and may be used to receive data on a socket whether or not
 it is connection-oriented.

 ssize_t recvmsg (int socket, struct msghdr *message, int flags);
*/
ssize_t (*orig_recvmsg) (int socket, struct msghdr *message, int flags);

ssize_t replaced_recvmsg (int socket, struct msghdr *message, int flags)
{
    DDLogVerbose(@"recvmsg");
    ssize_t ret = orig_recvmsg(socket, message, flags);
    return ret;
}



/*
 ********************
 * Users and Groups *
 ********************
*/

//
// glibc
//

/*
 The getuid() function returns the real user ID of the calling process.
 The geteuid() function returns the effective user ID of the calling process.

 uid_t geteuid(void);
 uid_t getuid(void);
*/
uid_t (*orig_geteuid)(void);
uid_t (*orig_getuid)(void);

uid_t replaced_geteuid(void)
{
    uid_t ret = orig_geteuid();
    DDLogVerbose(@"geteuid: %u", ret);
    return ret;
};
uid_t replaced_getuid(void)
{
    uid_t ret = orig_getuid();
    DDLogVerbose(@"getuid: %u", ret);
    return ret;
};

/*
 The getgid() function returns the real group ID of the calling process,
 getegid() returns the effective group ID of the calling process.

 gid_t getegid(void);
 gid_t getgid(void);
*/
gid_t (*orig_getegid)(void);
gid_t (*orig_getgid)(void);

gid_t replaced_getegid(void)
{
    gid_t ret = orig_getegid();
    DDLogVerbose(@"getegid: %u", ret);
    return ret;
};
gid_t replaced_getgid(void)
{
    gid_t ret = orig_getgid();
    DDLogVerbose(@"getgid: %u", ret);
    return ret;
};






int (*orig_ptrace) (int request, pid_t pid, caddr_t addr, int data);

int replaced_ptrace (int request, pid_t pid, caddr_t addr, int data)
{
    DDLogVerbose(@"ptrace: %d", request);

    if (request == 31)
    {
        DDLogVerbose(@"ptrace calling PT_DENY_ATTACH... Killing it...");
        request = -1; 
    }
    return orig_ptrace(request, pid, addr, data);  
}






kern_return_t (*orig_task_get_exception_ports) (
    task_t task,
    exception_mask_t exception_mask,
    exception_mask_array_t masks,
    mach_msg_type_number_t *masksCnt,
    exception_handler_array_t old_handlers,
    exception_behavior_array_t old_behaviors,
    exception_flavor_array_t old_flavors
);
kern_return_t replaced_task_get_exception_ports (
    task_t task,
    exception_mask_t exception_mask,
    exception_mask_array_t masks,
    mach_msg_type_number_t *masksCnt,
    exception_handler_array_t old_handlers,
    exception_behavior_array_t old_behaviors,
    exception_flavor_array_t old_flavors
)
{
    NSLog(@"task_get_exception_ports");
    // return orig_task_get_exception_ports(task, exception_mask, masks, masksCnt, old_handlers, old_behaviors, old_flavors);
    // kern_return_t ret = orig_task_get_exception_ports(task, 0, masks, masksCnt, 0, old_behaviors, 0);
    // NSLog(@"%d", ret);
    return 1;
}






#define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookCFunctions2_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic(funcname) MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname)
#define InstallHook_FindSymbol(funcname) if ([[plist objectForKey:@"settings_HookCFunctions2_"#funcname] boolValue]) { MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic_FindSymbol(funcname) MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname)

void C_function_hooks_section2()
{
    @autoreleasepool
    {
        NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

        InstallHook(syscall);
        InstallHook(_exit);
        // InstallHook(__syscall);
        
        // Date and Time
        InstallHook(gettimeofday);
        InstallHook(settimeofday);
        InstallHook(adjtime);

        // File System Interface
        InstallHook(chdir);
        InstallHook(fchdir);
        InstallHook(link);
        InstallHook(symlink);
        InstallHook(readlink);
        InstallHook(unlink);
        InstallHook(rmdir);
        InstallHook(rename);
        InstallHook(mkdir);
        InstallHook(fstat);
        InstallHook(lstat);
        InstallHook(stat);
        // InstallHook(fstat64);
        // InstallHook(lstat64);
        // InstallHook(stat64);
        InstallHook(chown);
        InstallHook(fchown);
        InstallHook(chmod);
        InstallHook(fchmod);
        InstallHook(umask);
        InstallHook(access);
        InstallHook(futimes);
        InstallHook(utimes);
        InstallHook(ftruncate);
        InstallHook(truncate);
        InstallHook(mknod);
        InstallHook(lchown);
        InstallHook(chflags);
        InstallHook(fchflags);
        InstallHook(statfs);

        // Inter-process Communication
        InstallHook(semctl);
        InstallHook(semget);
        InstallHook(semop);
        InstallHook(sem_open);
        InstallHook(sem_close);
        InstallHook(sem_unlink);
        InstallHook(sem_wait);
        InstallHook(sem_trywait);
        InstallHook(sem_post);

        // Job Control
        InstallHook(setsid);
        InstallHook(getsid);
        InstallHook(getpgid);
        InstallHook(getpgrp);
        InstallHook(setpgid);
        InstallHook(setpgrp);

        // Low-Level Input / Output
        InstallHook(open);
        InstallHook(close);
        InstallHook(read);
        InstallHook(pread);
        InstallHook(readv);
        InstallHook(write);
        InstallHook(pwrite);
        InstallHook(writev);
        InstallHook(lseek);
        InstallHook(mmap);
        InstallHook(munmap);
        InstallHook(msync);
        InstallHook(shm_open);
        InstallHook(shm_unlink);
        InstallHook(select);
        InstallHook(sync);
        InstallHook(fsync);
        InstallHook(aio_read);
        InstallHook(aio_write);
        InstallHook(aio_error);
        InstallHook(aio_return);
        InstallHook(aio_suspend);
        InstallHook(aio_cancel);
        InstallHook(fcntl);
        InstallHook(dup);
        InstallHook(dup2);
        InstallHook(ioctl);

        // Pipe and FIFO
        InstallHook(pipe);
        InstallHook(mkfifo);

        // Processes
        InstallHook(getpid);
        InstallHook(getppid);
        InstallHook(fork);
        InstallHook(vfork);
        InstallHook(waitpid);
        InstallHook(wait);
        InstallHook(wait4);
        InstallHook(wait3);
        InstallHook(execve);

        // Signal Handling
        InstallHook(kill);
        InstallHook(killpg);

        // Sockets
        InstallHook(bind);
        InstallHook(getsockname);
        InstallHook(socket);
        InstallHook(socketpair);
        InstallHook(shutdown);
        InstallHook(connect);
        InstallHook(listen);
        InstallHook(accept);
        InstallHook(getpeername);
        InstallHook(send);
        InstallHook(sendto);
        InstallHook(recv);
        InstallHook(recvfrom);
        InstallHook(getsockopt);
        InstallHook(setsockopt);
        InstallHook(sendmsg);
        InstallHook(recvmsg);

        // Users and Groups
        InstallHook(geteuid);
        InstallHook(getuid);
        InstallHook(getegid);
        InstallHook(getgid);


        InstallHook_FindSymbol(ptrace);

        InstallHook(task_get_exception_ports);



        if ([[plist objectForKey:@"settings_disable_antidebugging"] boolValue])
        {
            NSLog(@"Disabled Anti-Debugging Turned On");
            InstallHook_basic_FindSymbol(ptrace);
            InstallHook_basic(syscall);
            InstallHook_basic(task_get_exception_ports);
            // InstallHook_basic(ioctl);
        }


        if ([[plist objectForKey:@"settings_disableJBDetection"] boolValue])
        {
            // InstallHook_basic(lstat);
            // InstallHook_basic(stat);
            // InstallHook_basic(open);
            // InstallHook_basic(statfs);
            // InstallHook_basic(access);
            // InstallHook_basic(fork);
        }

    }
}// C_function_hooks_section2()


















