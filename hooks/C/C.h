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

void C_function_hooks_section2();
void C_function_hooks_section3();
void C_function_hooks_section3ssl();
void CommonCrypto_function_hooks();