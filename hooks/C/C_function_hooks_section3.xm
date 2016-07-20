/*
 File Description:
  
  ********************************
  ** C function hooks (Man (3)) **
  ********************************
	
  The functions hooked here contains POSIX C since MacOS is a POSIX compliant system.
  Functions copied from glibc and iOS Man pages.

  Section 3 of the manual contains documentation on C library routines. 
  This section excludes library routines that merely wrap UNIX system calls. 
  Most of these functions are described in headers that reside in /usr/include or 
  subdirectories therein.
*/
#import "../../swizzler.common.h"

// Needed by opendir
// #import <sys/types.h>
#import <dirent.h>
// #include <sys/stat.h>

// Needed by sysctl
#import <sys/sysctl.h>

// Needed by regex
#import <regex.h>

// dlopen
#import <dlfcn.h>

// dyld
#import <mach-o/dyld.h>

// isatty, ttyname, ttyslot
#include <unistd.h>



#define InstallHook(funcname) if ([[plist objectForKey:@"settings_HookCFunctions3_hookall"] boolValue] || [[plist objectForKey:@"settings_HookCFunctions3_"#funcname] boolValue]) { MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic(funcname) MSHookFunction((void*)funcname, (void *)replaced_##funcname, (void**)&orig_##funcname)


/*
 Mathematics
*/



/*
 The rand() function computes a sequence of pseudo-random integers in the
 range of 0 to RAND_MAX (as defined by the header file <stdlib.h>).

 The srand() function sets its argument seed as the seed for a new
 sequence of pseudo-random numbers to be returned by rand().  These
 sequences are repeatable by calling srand() with the same seed value.

 If no seed value is provided, the functions are automatically seeded with
 a value of 1.

 The sranddev() function initializes a seed, using the random(4) random
 number device which returns good random numbers, suitable for cryptographic
 use.

 The rand_r() function provides the same functionality as rand().  A
 pointer to the context value seed must be supplied by the caller.

 int rand (void)
 int rand_r (unsigned int *seed)
 void srand (unsigned int seed)
*/
int (*orig_rand) (void);
int (*orig_rand_r) (unsigned int *seed);
void (*orig_srand) (unsigned int seed);

int replaced_rand(void)
{
    // DDLogVerbose(@"rand");
    int ret = orig_rand();
    DDLogVerbose(@"rand: %d", ret);
    return ret;
}
int replaced_rand_r(unsigned int *seed)
{
    // DDLogVerbose(@"rand_r");
    int ret = orig_rand_r(seed);
    return ret;
}
void replaced_srand(unsigned int seed)
{
    // DDLogVerbose(@"srand");
    DDLogVerbose(@"srand: %d", seed);
    orig_srand(seed);
}


/*
 pseudo random number generators and initialization routines
 
 double drand48 (void);
 double erand48 (unsigned short int xsubi[3]);
 long int jrand48 (unsigned short int xsubi[3]);
 void lcong48 (unsigned short int param[7]);
 long int lrand48 (void);
 long int mrand48 (void);
 long int nrand48 (unsigned short int xsubi[3]);
 unsigned short int * seed48 (unsigned short int seed16v[3]);
 void srand48 (long int seedval);
*/
double (*orig_drand48) (void);
double (*orig_erand48) (unsigned short xsubi[3]);
long (*orig_jrand48) (unsigned short xsubi[3]);
void (*orig_lcong48) (unsigned short param[7]);
long (*orig_lrand48) (void);
long (*orig_mrand48) (void);
long (*orig_nrand48) (unsigned short xsubi[3]);
unsigned short * (*orig_seed48) (unsigned short seed16v[3]);
void (*orig_srand48) (long seedval);

double replaced_drand48(void)
{
    DDLogVerbose(@"drand48");
    double ret = orig_drand48();
    return ret;
}
double replaced_erand48(unsigned short *xsubi[3])
{
    DDLogVerbose(@"erand48");
    double ret = orig_erand48(xsubi[3]);
    return ret;
}
long replaced_jrand48(unsigned short *xsubi[3])
{
    DDLogVerbose(@"jrand48");
    long ret = orig_jrand48(xsubi[3]);
    return ret;
}
void replaced_lcong48(unsigned short *param[7])
{
    DDLogVerbose(@"lcong48");
    orig_lcong48(param[7]);
}
long replaced_lrand48(void)
{
    DDLogVerbose(@"lrand48");
    long ret = orig_lrand48();
    return ret;
}
long replaced_mrand48(void)
{
    DDLogVerbose(@"mrand48");
    long ret = orig_mrand48();
    return ret;
}
long replaced_nrand48(unsigned short *xsubi[3])
{
    DDLogVerbose(@"nrand48");
    long ret = orig_nrand48(xsubi[3]);
    return ret;
}
unsigned short *replaced_seed48(unsigned short *seed16v[3])
{
    DDLogVerbose(@"seed48");
    unsigned short *ret = orig_seed48(seed16v[3]);
    return ret;
}
void replaced_srand48(long seedval)
{
    DDLogVerbose(@"srand48");
    orig_srand48(seedval);
}


/*
 better random number generator; routines for changing generators

 char * initstate (unsigned int seed, char *state, size_t size)
 long int random (void)
 char * setstate (char *state)
 void srandom (unsigned int seed)
*/
char * (*orig_initstate) (unsigned seed, char *state, size_t size);
long (*orig_random) (void);
char * (*orig_setstate) (const char *state);
void (*orig_srandom) (unsigned seed);

char * replaced_initstate(unsigned seed, char *state, size_t size)
{
    DDLogVerbose(@"initstate");
    char *ret = orig_initstate(seed, state, size);
    return ret;
}
long replaced_random(void)
{
    DDLogVerbose(@"random");
    long ret = orig_random();
    return ret;
}
char * replaced_setstate(const char *state)
{
    DDLogVerbose(@"setstate");
    char *ret = orig_setstate(state);
    return ret;
}
void replaced_srandom(unsigned seed)
{
    DDLogVerbose(@"srandom");
    orig_srandom(seed);
}




//
// iOS Manpage
//

/*
 The sranddev() function initializes a seed, using the random(4) random
 number device which returns good random numbers, suitable for cryptographic
 use.
*/
void (*orig_sranddev) (void);
void replaced_sranddev(void)
{
    DDLogVerbose(@"sranddev");
    orig_sranddev();
}

/*
 better random number generator; routines for changing generators
    
 void srandomdev (void);
*/
void (*orig_srandomdev) (void);

void replaced_srandomdev(void)
{
    DDLogVerbose(@"srandomdev");
    orig_srandomdev();
}















/*
 String Specfic Fuctions
*/
char * (*orig_index) (const char *string, int c);
char * (*orig_rindex) (const char *string, int c);
int (*orig_strcasecmp) (const char *s1, const char *s2);
int (*orig_strncasecmp) (const char *s1, const char *s2, size_t n);
char * (*orig_stpcpy) (char * to, const char * from);
char * (*orig_strcat) (char * to, const char * from);
char * (*orig_strchr) (const char *string, int c);
int (*orig_strcmp) (const char *s1, const char *s2);
char * (*orig_strcpy) (char * to, const char * from);
size_t (*orig_strcspn) (const char *string, const char *stopset);
size_t (*orig_strlen) (const char *s);
char * (*orig_strncat) (char * to, const char * from, size_t size);
int (*orig_strncmp) (const char *s1, const char *s2, size_t size);
char * (*orig_strncpy) (char * to, const char * from, size_t size);
char * (*orig_strpbrk) (const char *string, const char *stopset);
char * (*orig_strrchr) (const char *string, int c);
char * (*orig_strsep) (char **string_ptr, const char *delimiter);
size_t (*orig_strspn) (const char *string, const char *skipset);
char * (*orig_strstr) (const char *haystack, const char *needle);
char * (*orig_strtok) (char * newstring, const char * delimiters);

char * replaced_index(const char *string, int c)
{
    DDLogVerbose(@"index");
    char * ret = orig_index(string, c);
    return ret;
}
char * replaced_rindex (const char *string, int c)
{
    DDLogVerbose(@"rindex");
    char * ret = orig_rindex(string, c);
    return ret;
}
int replaced_strcasecmp (const char *s1, const char *s2)
{
    DDLogVerbose(@"strcasecmp");
    int ret = orig_strcasecmp(s1, s2);
    return ret;
}
int replaced_strncasecmp (const char *s1, const char *s2, size_t n)
{
    DDLogVerbose(@"strncasecmp");
    int ret = orig_strncasecmp(s1, s2, n);
    return ret;
}
char * replaced_stpcpy (char * to, const char * from)
{
    DDLogVerbose(@"stpcpy");
    char * ret = orig_stpcpy(to, from);
    return ret;
}
char * replaced_strcat (char * to, const char * from)
{
    DDLogVerbose(@"strcat");
    char * ret = orig_strcat(to, from);
    return ret;
}
char * replaced_strchr (const char *string, int c)
{
    // NSLog(@"strchr");
    DDLogVerbose(@"strchr: %s, %d", string, c);
    char * ret = orig_strchr(string, c);
    return ret;
}
int replaced_strcmp (const char *s1, const char *s2)
{
    // NSLog(@"strcmp");
    DDLogVerbose(@"strcmp: %s, %s", s1, s2);
    int ret = orig_strcmp(s1, s2);
    return ret;
}
char * replaced_strcpy (char * to, const char * from)
{
    // NSLog(@"strcpy");
    DDLogVerbose(@"strcpy: %s, %s", to, from);
    char * ret = orig_strcpy(to, from);
    return ret;
}
size_t replaced_strcspn (const char *string, const char *stopset)
{
    DDLogVerbose(@"strcspn");
    size_t ret = orig_strcspn(string, stopset);
    return ret;
}
size_t replaced_strlen (const char *s)
{
    DDLogVerbose(@"strlen");
    size_t ret = orig_strlen(s);
    return ret;
}
char * replaced_strncat (char * to, const char * from, size_t size)
{
    DDLogVerbose(@"strncat");
    char * ret = orig_strncat(to, from, size);
    return ret;
}
int replaced_strncmp (const char *s1, const char *s2, size_t size)
{
    DDLogVerbose(@"strncmp: %s, %s", s1, s2);
    int ret = orig_strncmp(s1, s2, size);
    return ret;
}
char * replaced_strncpy (char * to, const char * from, size_t size)
{
    DDLogVerbose(@"strncpy");
    char * ret = orig_strncpy(to, from, size);
    return ret;
}
char * replaced_strpbrk (const char *string, const char *stopset)
{
    DDLogVerbose(@"strpbrk");
    char * ret = orig_strpbrk(string, stopset);
    return ret;
}
char * replaced_strrchr (const char *string, int c)
{
    DDLogVerbose(@"strrchr");
    char * ret = orig_strrchr(string, c);
    return ret;
}
char * replaced_strsep (char **string_ptr, const char *delimiter)
{
    DDLogVerbose(@"strsep");
    char * ret = orig_strsep(string_ptr, delimiter);
    return ret;
}
size_t replaced_strspn (const char *string, const char *skipset)
{
    DDLogVerbose(@"strspn");
    size_t ret = orig_strspn(string, skipset);
    return ret;
}
char * replaced_strstr (const char *haystack, const char *needle)
{
    DDLogVerbose(@"strstr");
    char * ret = orig_strstr(haystack, needle);
    return ret;
}
char * replaced_strtok (char * newstring, const char * delimiters)
{
    DDLogVerbose(@"strtok");
    char * ret = orig_strtok(newstring, delimiters);
    return ret;
}







/*
 memory allocation

 void * calloc (size_t count, size_t eltsize);
 void free (void *ptr);
 void * malloc (size_t size);
 void * realloc (void *ptr, size_t newsize);
 void * valloc (size_t size);
*/
void * (*orig_calloc) (size_t count, size_t size);
void (*orig_free) (void *ptr);
void * (*orig_malloc) (size_t size);
void * (*orig_realloc) (void *ptr, size_t size);
void * (*orig_reallocf) (void *ptr, size_t size);
void * (*orig_valloc) (size_t size);

void *replaced_calloc(size_t count, size_t size)
{
    DDLogVerbose(@"calloc");
    return orig_calloc(count, size);
}
void replaced_free(void *ptr)
{
    DDLogVerbose(@"free");
    orig_free(ptr);
}
void *replaced_malloc(size_t size)
{
    DDLogVerbose(@"malloc");
    return orig_malloc(size);
}
void *replaced_realloc(void *ptr, size_t size)
{
    DDLogVerbose(@"realloc");
    return orig_realloc(ptr, size);
}
void *replaced_reallocf(void *ptr, size_t size)
{
    DDLogVerbose(@"reallocf");
    return orig_reallocf(ptr, size);
}
void *replaced_valloc(size_t size)
{
    DDLogVerbose(@"valloc");
    return orig_valloc(size);
}








/*
 *****************
 * Pipe and FIFO *
 *****************
*/

/*
 The popen() function ``opens'' a process by creating a bidirectional
 pipe, forking, and invoking the shell.  Any streams opened by previous
 popen() calls in the parent process are closed in the new child process.
 Historically, popen() was implemented with a unidirectional pipe; hence,
 many implementations of popen() only allow the mode argument to specify
 reading or writing, not both.  Because popen() is now implemented using a
 bidirectional pipe, the mode argument may request a bidirectional data
 flow.  The mode argument is a pointer to a null-terminated string which
 must be `r' for reading, `w' for writing, or `r+' for reading and writing.

 The command argument is a pointer to a null-terminated string containing
 a shell command line.  This command is passed to /bin/sh, using the -c
 flag; interpretation, if any, is performed by the shell.

 The return value from popen() is a normal standard I/O stream in all
 respects, save that it must be closed with pclose() rather than fclose().
 Writing to such a stream writes to the standard input of the command; the
 command's standard output is the same as that of the process that called
 popen(), unless this is altered by the command itself.  Conversely, reading
 from a ``popened'' stream reads the command's standard output, and
 the command's standard input is the same as that of the process that
 called popen().

 Note that output popen() streams are fully buffered, by default.

 The pclose() function waits for the associated process to terminate; it
 returns the exit status of the command, as returned by wait4(2).

 FILE *popen(const char *command, const char *mode);
 int pclose(FILE *stream);
*/
FILE *(*orig_popen) (const char *command, const char *mode);
FILE *replaced_popen (const char *command, const char *mode)
{
    DDLogVerbose(@"popen(%s, %s)", command, mode);
    return orig_popen(command, mode);
}




/*
 stream open functions

 FILE *fdopen(int fildes, const char *mode);
 FILE *fopen(const char *restrict filename, const char *restrict mode);
 FILE *freopen(const char *restrict filename, const char *restrict mode, FILE *restrict stream);
*/
FILE *(*orig_fdopen) (int fildes, const char *mode);
FILE *(*orig_fopen) (const char *filename, const char *mode);
FILE *(*orig_freopen) (const char *filename, const char *mode, FILE *stream);

FILE *replaced_fdopen (int fildes, const char *mode)
{
    DDLogVerbose(@"fdopen");
    return orig_fdopen(fildes, mode);
};
FILE *replaced_fopen (const char *filename, const char *mode)
{
    if (blockPath(filename) && disableJBDectection())
    { 
        DDLogVerbose(@"Jailbreak detection fopen(%s)", filename);
        errno = ENOENT;
        return NULL;
    }
    DDLogVerbose(@"fopen: %s, %s", filename, mode);
    return orig_fopen(filename, mode);
};
FILE *replaced_freopen (const char *filename, const char *mode, FILE *stream)
{
    DDLogVerbose(@"freopen");
    return orig_freopen(filename, mode, stream);
};



/*
 *************
 * Processes *
 *************
*/

/*
 system -- pass a command to the shell

 int system(const char *command);
*/
int (*orig_system) (const char *command);
int replaced_system(const char *command)
{
    if (disableJBDectection())
    {
        NSLog(@"system() call detected, returning 0");
        return 0;
    }

    DDLogVerbose(@"system(%s)", command);

    return orig_system(command);
}



/*
 *************************
 * File System Interface *
 *************************
*/

/*
 directory operations

 The opendir() function opens the directory named by dirname, associates a
 directory stream with it, and returns a pointer to be used to identify
 the directory stream in subsequent operations.  The pointer NULL is
 returned if dirname cannot be accessed or if it cannot malloc(3) enough
 memory to hold the whole thing.

 The readdir() function returns a pointer to the next directory entry.  It
 returns NULL upon reaching the end of the directory or detecting an
 invalid seekdir() operation.

 readdir_r() provides the same functionality as readdir(), but the caller
 must provide a directory entry buffer to store the results in.  If the
 read succeeds, result is pointed at the entry; upon reaching the end of
 the directory, result is set to NULL.  readdir_r() returns 0 on success
 or an error number to indicate failure.

 The telldir() function returns the current location associated with the
 named directory stream.  Values returned by telldir() are good only for
 the lifetime of the DIR pointer (e.g., dirp) from which they are derived.
 If the directory is closed and then reopened, prior values returned by
 telldir() will no longer be valid.

 The seekdir() function sets the position of the next readdir() operation
 on the directory stream.  The new position reverts to the one associated
 with the directory stream when the telldir() operation was performed.

 The rewinddir() function resets the position of the named directory
 stream to the beginning of the directory.

 The closedir() function closes the named directory stream and frees the
 structure associated with the dirp pointer, returning 0 on success.  On
 failure, -1 is returned and the global variable errno is set to indicate
 the error.

 The dirfd() function returns the integer file descriptor associated with
 the named directory stream, see open(2).


 int closedir(DIR *dirp);
 int dirfd(DIR *dirp);
 DIR *opendir(const char *dirname);
 struct dirent *readdir(DIR *dirp);
 int readdir_r(DIR *restrict dirp, struct dirent *restrict entry, struct dirent **restrict result);
 void rewinddir(DIR *dirp);
 void seekdir(DIR *dirp, long loc);
 long telldir(DIR *dirp);
*/

// opendir hook seems to be crashing for some reason. Can't figure our why.
// A jailbreak check that is used is opendir("/dev"). Until this can be resolved,
// a good way to bypass that would be to set permissions for /dev to 751
// InstallHook_basic(opendir);
// DIR *(*orig_opendir) (const char *dirname) = opendir;
// DIR *replaced_opendir (const char *dirname)
// {
//     if(strcmp(dirname, "/dev") == 0)
//     {
//         DDLogVerbose(@"Jailbreak detection opendir(/dev), returning NULL");
//         return NULL;
//     }

//     DDLogVerbose(@"opendir: %s", dirname);

//     return orig_opendir(dirname);
// };
// As it turns out opendir is short function to opendir2
DIR *(*orig___opendir2) (const char *dirname, size_t bufsize);
DIR *replaced___opendir2 (const char *dirname, size_t bufsize)
{
    if(strcmp(dirname, "/dev") == 0)
    {
        DDLogVerbose(@"Jailbreak detection opendir(/dev), returning NULL");
        return NULL;
    }

    DDLogVerbose(@"opendir: %s", dirname);

    return orig___opendir2(dirname, bufsize);
};


/*
 *********************
 * System Management *
 *********************
*/

/*
 get or set system information

 The sysctl() function retrieves system information and allows processes
 with appropriate privileges to set system information.  The information
 available from sysctl() consists of integers, strings, and tables.
 Information may be retrieved and set from the command interface using the
 sysctl(8) utility.

 The sysctlbyname() function accepts an ASCII representation of the name
 and internally looks up the integer name vector.  Apart from that, it
 behaves the same as the standard sysctl() function.

 The sysctlnametomib() function accepts an ASCII representation of the
 name, looks up the integer name vector, and returns the numeric representation
 in the mib array pointed to by mibp.  The number of elements in
 the mib array is given by the location specified by sizep before the
 call, and that location gives the number of entries copied after a successful
 call.

 int sysctl(int *name, u_int namelen, void *oldp, size_t *oldlenp, void *newp, size_t newlen);
 int sysctlbyname(const char *name, void *oldp, size_t *oldlenp, void *newp, size_t newlen);
 int sysctlnametomib(const char *name, int *mibp, size_t *sizep);
*/
int (*orig_sysctl) (int *name, u_int namelen, void *oldp, size_t *oldlenp, void *newp, size_t newlen);
int (*orig_sysctlbyname) (const char *name, void *oldp, size_t *oldlenp, void *newp, size_t newlen);
int (*orig_sysctlnametomib) (const char *name, int *mibp, size_t *sizep);

int replaced_sysctl (int *name, u_int namelen, void *oldp, size_t *oldlenp, void *newp, size_t newlen)
{
    DDLogVerbose(@"sysctl");
    int ret = orig_sysctl(name, namelen, oldp, oldlenp, newp, newlen);
    
    if (oldp)
    {
        // Try to cast oldp as a kinfo_proc struct
        kinfo_proc *ptr = (kinfo_proc *)oldp;

        // Check if P_TRACED is set in p_flag. If set means the executable is being traced.
        // Ref: /usr/include/sys/proc.h
        if ((ptr->kp_proc.p_flag & P_TRACED))
        {
            DDLogVerbose(@"sysctl ptrace flag was set, removing it...");
            
            // Since we want to remove traces that we are debugging application, remove P_TRACED
            // Ref: https://developer.apple.com/library/mac/qa/qa1361/_index.html
            // Ref: http://www.coredump.gr/articles/ios-anti-debugging-protections-part-2/
            ptr->kp_proc.p_flag = ptr->kp_proc.p_flag - P_TRACED;
            // NSLog(@"sysctl: %02x, %02x", (ptr->kp_proc.p_flag & P_TRACED), (ptr->kp_proc.p_flag));
        }
    }
    
    return ret;
};
int replaced_sysctlbyname (const char *name, void *oldp, size_t *oldlenp, void *newp, size_t newlen)
{   
    if(strcmp(name, "security.mac.proc_enforce") == 0)
    {
        DDLogVerbose(@"Jailbreak detection sysctlbyname(security.mac.proc_enforce), returning 1");

        // Somehow return 1; doesn't work. I'm guessing it is because the value is returned into &oldp.
        // Need to figure out how to modify &oldp to return 1.
        // Using security.mac.system_enforce as a cheat now beause that always returns 1.
        // Help anyone?
        return orig_sysctlbyname("security.mac.system_enforce", oldp, oldlenp, newp, newlen);
    }

    if(strcmp(name, "security.mac.vnode_enforce") == 0)
    {
        DDLogVerbose(@"Jailbreak detection sysctlbyname(security.mac.vnode_enforce), returning 1");
        return orig_sysctlbyname("security.mac.system_enforce", oldp, oldlenp, newp, newlen);
    }

    int ret = orig_sysctlbyname(name, oldp, oldlenp, newp, newlen);
    DDLogVerbose(@"sysctlbyname: %s", name);
    return ret;
};
int replaced_sysctlnametomib (const char *name, int *mibp, size_t *sizep)
{
    int ret = orig_sysctlnametomib(name, mibp, sizep);
    DDLogVerbose(@"sysctlnametomib");
    return ret;
};





/*
 ********************
 * Pattern Matching *
 ********************
*/

/*
 These routines implement IEEE Std 1003.2 (``POSIX.2'') regular expressions
 (``RE''s); see re_format(7).  The regcomp() function compiles an
 RE, written as a string, into an internal form.  regexec() matches that
 internal form against a string and reports results.  regerror() transforms
 error codes from either into human-readable messages.  regfree()
 frees any dynamically-allocated storage used by the internal form of an
 RE.

int regcomp(regex_t *restrict preg, const char *restrict pattern, int cflags);
size_t regerror(int errcode, const regex_t *restrict preg, char *restrict errbuf, size_t errbuf_size);
int regexec(const regex_t *restrict preg, const char *restrict string, size_t nmatch, regmatch_t pmatch[restrict], int eflags);
void regfree(regex_t *preg);
*/
int (*orig_regcomp) (regex_t *preg, const char *pattern, int cflags);
int (*orig_regexec) (const regex_t *preg, const char *string, size_t nmatch, regmatch_t pmatch[], int eflags);

int replaced_regcomp (regex_t *preg, const char *pattern, int cflags)
{
    DDLogVerbose(@"regcomp: %@, %s", preg, pattern);
    int ret = replaced_regcomp(preg, pattern, cflags);
    return ret;
};
int replaced_regexec (const regex_t *preg, const char *string, size_t nmatch, regmatch_t pmatch[], int eflags)
{
    DDLogVerbose(@"regexec: %@, %s", preg, string);
    int ret = replaced_regexec(preg, string, nmatch, pmatch, eflags);
    return ret;
};





/*
 dlopen_preflight

 dlopen_preflight() examines the mach-o file specified by path.  It checks
 if the file and libraries it depends on are all compatible with the current
 process.  That is, they contain the correct architecture and are not
 otherwise ABI incompatible.

 bool dlopen_preflight(const char* path);
*/
bool (*orig_dlopen_preflight) (const char* path);

bool replaced_dlopen_preflight (const char* path)
{
    DDLogVerbose(@"dlopen_preflight: %s", path);

    if (disableJBDectection())
    {
        return 0;
    }

    bool ret = orig_dlopen_preflight(path);
    return ret;
}



/*
 dyld

 These routines provide additional introspection of dyld beyond that provided
 by dlopen() and dladdr()

 _dyld_image_count() returns the current number of images mapped in by
 dyld. Note that using this count to iterate all images is not thread
 safe, because another thread may be adding or removing images during the
 iteration.

 _dyld_get_image_header() returns a pointer to the mach header of the
 image indexed by image_index.  If image_index isout of range, NULL is
 returned.

 _dyld_get_image_vmaddr_slide() returns the virtural memory address slide
 amount of the image indexed by image_index. If image_index is out of
 range zero is returned.

 _dyld_get_image_name() returns the name of the image indexed by
 image_index. The C-string continues to be owned by dyld and should not
 deleted.  If image_index is out of range NULL is returned.

 _dyld_register_func_for_add_image() registers the specified function to
 be called when a new image is added (a bundle or a dynamic shared
 library) to the program.  When this function is first registered it is
 called for once for each image that is currently part of the process.

 _dyld_register_func_for_remove_image() registers the specified function
 to be called when an image is removed (a bundle or a dynamic shared
 library) from the process.

 NSVersionOfRunTimeLibrary() returns the current_version number of the
 currently loaded dylib specifed by the libraryName.  The libraryName
 parameter would be "bar" for /path/libbar.3.dylib and "Foo" for
 /path/Foo.framework/Versions/A/Foo.  This function returns -1 if no such
 library is loaded.

 NSVersionOfLinkTimeLibrary() returns the current_version number that the
 main executable was linked against at build time.  The libraryName parameter
 would be "bar" for /path/libbar.3.dylib and "Foo" for
 /path/Foo.framework/Versions/A/Foo.  This function returns -1 if the main
 executable did not link against the specified library.

 _NSGetExecutablePath() copies the path of the main executable into the
 buffer buf.  The bufsize parameter should initially be the size of the
 buffer.  This function returns 0 if the path was successfully copied.  It
 returns -1 if the buffer is not large enough, and * bufsize is set to the
 size required.  Note that _NSGetExecutablePath() will return "a path" to
 the executable not a "real path" to the executable.  That is, the path
 may be a symbolic link and not the real file. With deep directories the
 total bufsize needed could be more than MAXPATHLEN.

 uint32_t _dyld_image_count(void);

 const struct mach_header* _dyld_get_image_header(uint32_t image_index);

 intptr_t _dyld_get_image_vmaddr_slide(uint32_t image_index);

 const char* _dyld_get_image_name(uint32_t image_index);

 void _dyld_register_func_for_add_image(void (*func)(const struct mach_header* mh, intptr_t vmaddr_slide));

 void _dyld_register_func_for_remove_image(void (*func)(const struct mach_header* mh, intptr_t vmaddr_slide));

 int32_t NSVersionOfRunTimeLibrary(const char* libraryName);

 int32_t NSVersionOfLinkTimeLibrary(const char* libraryName);

 int _NSGetExecutablePath(char* buf, uint32_t* bufsize);

*/
uint32_t (*orig__dyld_image_count)(void) = _dyld_image_count;
const char *(*orig__dyld_get_image_name)(uint32_t id) = _dyld_get_image_name;

uint32_t replaced__dyld_image_count(void)
{
    NSString* preferenceFilePath = @PREFERENCEFILE;
    NSMutableDictionary* plist = [[NSMutableDictionary alloc]initWithContentsOfFile:preferenceFilePath];
    int userCount = [[plist objectForKey:@"dyld_image_countValue"] intValue];

    uint32_t count;
    uint32_t realCount = orig__dyld_image_count();

    if (userCount > 0 && userCount < 31337) {
        count = (uint32_t) userCount;
    } else {
        count = realCount;
    }
    DDLogVerbose(@"_dyld_image_count() actual return value was %d. We are returning %d.", realCount, count);
    
    return count;
}   

const char* replaced__dyld_get_image_name(uint32_t id)
{
    const char* realName = (const char *) orig__dyld_get_image_name(id);
    const char *fakeName = (const char *) orig__dyld_get_image_name(0); // returns the name of the app
    char *returnedName = (char *)realName;

    if (blockPath(realName))
    {
        returnedName = (char *)fakeName;
    }

    DDLogVerbose(@"_dyld_get_image_name(%d) would normally return '%s'. Actually returning '%s'", id, realName, returnedName);
    return returnedName;
}








/*
TTYNAME

isatty, ttyname, ttyslot -- get name of associated terminal (tty) from file descriptor
#include <unistd.h>

int isatty(int fildes);

char *ttyname(int fildes);

int ttyslot(void);
*/
int (*orig_isatty) (int fildes);
char *(*orig_ttyname) (int fildes);
int (*orig_ttyslot) (void);

int replaced_isatty (int fildes)
{
    DDLogVerbose(@"isatty antidebugging check returning 0");
    return orig_isatty(0);
    // return orig_isatty(fildes);
};

char *replaced_ttyname (int fildes)
{
    DDLogVerbose(@"ttyname");
    return orig_ttyname(fildes);
};

int replaced_ttyslot (void)
{
    DDLogVerbose(@"ttyslot");
    return orig_ttyslot();
};







/*
 CRYPT
 
 crypt, encrypt, setkey -- DES encryption
 
 char * crypt(const char *key, const char *salt);
 void encrypt(char *block, int edflag);
 void setkey(const char *key);
*/
char * (*orig_crypt) (const char *key, const char *salt);
void (*orig_encrypt) (char *block, int edflag);
void (*orig_setkey) (const char *key);

char * replaced_crypt (const char *key, const char *salt)
{
    DDLogVerbose(@"crypt: %s    salt: %s", key, salt);
    return orig_crypt(key, salt);
}

void replaced_encrypt (char *block, int edflag)
{
    DDLogVerbose(@"encrypt: %s", block);
    orig_encrypt(block, edflag);
}

void replaced_setkey (const char* key)
{
    DDLogVerbose(@"setkey: %s", key);
    orig_setkey(key);
}











// extern bool MSDebug;

void C_function_hooks_section3()
{
    @autoreleasepool
    {
        NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

        // Random Number Generator
        // rand, rand_r, srand, sranddev
        if ([[plist objectForKey:@"settings_HookCFunctions3_badrandgen"] boolValue])
        {
            InstallHook(rand);
            InstallHook(rand_r);
            InstallHook(srand);
            InstallHook(sranddev);
        }
        // initstate, random, setstate, srandom, srandomdev
        if ([[plist objectForKey:@"settings_HookCFunctions3_betterrandgen"] boolValue])
        {
            InstallHook(initstate);
            InstallHook(random);
            InstallHook(setstate);
            InstallHook(srandom);
            InstallHook(srandomdev);
        }

        InstallHook(drand48);
        InstallHook(erand48);
        InstallHook(jrand48);
        InstallHook(lcong48);
        InstallHook(lrand48);
        InstallHook(mrand48);
        InstallHook(nrand48);
        InstallHook(srand48);


        // String Specific Functions
        InstallHook(index);
        InstallHook(rindex);
        InstallHook(strcasecmp);
        InstallHook(strncasecmp);
        InstallHook(stpcpy);
        InstallHook(strcat);
        InstallHook(strchr);
        InstallHook(strcmp);
        InstallHook(strcpy);
        InstallHook(strcspn);
        InstallHook(strlen);
        InstallHook(strncat);
        InstallHook(strncmp);
        InstallHook(strncpy);
        InstallHook(strpbrk);
        InstallHook(strrchr);
        InstallHook(strsep);
        InstallHook(strspn);
        InstallHook(strstr);
        InstallHook(strtok);

        // Memory Allocation
        InstallHook(calloc);
        InstallHook(free);
        InstallHook(malloc);
        InstallHook(realloc);
        InstallHook(reallocf);
        InstallHook(valloc);

        // Pipes and FIFOs
        InstallHook(popen);

        // Input/Output on Streams
        InstallHook(fdopen);
        InstallHook(fopen);
        InstallHook(freopen);

        // Processes
        InstallHook(system);

        // File System Interface
        // MSDebug = true;
        // InstallHook(opendir);
        // MSDebug = false;
        InstallHook(__opendir2);



        // System Management
        InstallHook(sysctl);
        InstallHook(sysctlbyname);
        InstallHook(sysctlnametomib);

        // Pattern Matching
        InstallHook(regcomp);
        InstallHook(regexec);

        // dl
        InstallHook(dlopen_preflight);

        // dyld
        InstallHook(_dyld_image_count);
        InstallHook(_dyld_get_image_name);


        // Crypt
        InstallHook(crypt);
        InstallHook(encrypt);
        InstallHook(setkey);


        InstallHook(isatty);
        InstallHook(ttyname);
        InstallHook(ttyslot);



        if ([[plist objectForKey:@"settings_disable_antidebugging"] boolValue])
        {
            InstallHook_basic(sysctl);
            InstallHook_basic(isatty);
        }
        
        if ([[plist objectForKey:@"settings_disableJBDetection"] boolValue])
        {
            // InstallHook_basic(system);
            // InstallHook_basic(__opendir2);
            // InstallHook_basic(sysctlbyname);
            // InstallHook_basic(dlopen_preflight);
            // InstallHook_basic(_dyld_image_count);
            // InstallHook_basic(_dyld_get_image_name);
        }
    }
}


