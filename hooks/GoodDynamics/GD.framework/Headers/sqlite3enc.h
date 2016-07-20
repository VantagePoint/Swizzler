/*
 *  Copyright (c) Visto Corporation dba Good Technology, 2011. All rights reserved.
 */

#include "sqlite3.h"

#ifdef __cplusplus
extern "C" {
#endif

SQLITE_API int sqlite3enc_open(const char* filename, sqlite3** ppDb);
SQLITE_API int sqlite3enc_open_v2(const char *zFilename, sqlite3 **ppDb, int flags, const char *zVfs);
SQLITE_API int sqlite3enc_import(const char* srcFilename, const char* destFilename);

#ifdef __cplusplus
}
#endif