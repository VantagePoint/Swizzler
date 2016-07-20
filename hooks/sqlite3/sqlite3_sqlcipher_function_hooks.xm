/*
 File Description:
  
    ************************************
    ** sqlite3 & sqlcipher Functions  **
    ************************************

    https://www.zetetic.net/sqlcipher/sqlcipher-api/

    Last referenced: 08 Feb 2016
*/
#import "../../swizzler.common.h"
#import <sqlite3.h>



int (*orig_sqlite3_open) (
  const char *filename,   /* Database filename (UTF-8) */
  sqlite3 **ppDb          /* OUT: SQLite db handle */
);
int (*orig_sqlite3_open16) (
  const void *filename,   /* Database filename (UTF-16) */
  sqlite3 **ppDb          /* OUT: SQLite db handle */
);
int (*orig_sqlite3_open_v2) (
  const char *filename,   /* Database filename (UTF-8) */
  sqlite3 **ppDb,         /* OUT: SQLite db handle */
  int flags,              /* Flags */
  const char *zVfs        /* Name of VFS module to use */
);
int replaced_sqlite3_open (const char *filename, sqlite3 **ppDb)
{
    DDLogVerbose(@"sqlite3_open filename: %s", filename);
    return orig_sqlite3_open(filename, ppDb);
}
int replaced_sqlite3_open16 (const char *filename, sqlite3 **ppDb)
{
    DDLogVerbose(@"sqlite3_open16 filename: %s", filename);
    return orig_sqlite3_open16(filename, ppDb);
}
int replaced_sqlite3_open_v2 (const char *filename, sqlite3 **ppDb, int flags, const char *zVfs)
{
    DDLogVerbose(@"sqlite3_open_v2 filename: %s", filename);
    return orig_sqlite3_open_v2(filename, ppDb, flags, zVfs);
}

/*
    sqlite3_key() and sqlite3_key_v2()

    It is possible to set the key for use with a database handle programmatically without invoking the SQL PRAGMA key interface. 
    This is often desirable when linking SQLCipher in with a C/C++ application. 
    sqlite3_key() is actually called internally by the PRAGMA interface. 
    The sqlite3_key_v2 call performs the same way as sqlite3_key, but sets the encryption key on a named database instead of the 
    main database.
*/
int (*orig_sqlite3_key) (
  sqlite3 *db,                   /* Database to be rekeyed */
  const void *pKey, int nKey     /* The key, and the length of the key in bytes */
);
int (*orig_sqlite3_key_v2) (
  sqlite3 *db,                   /* Database to be rekeyed */
  const char *zDbName,           /* Name of the database */
  const void *pKey, int nKey     /* The key */
);

int replaced_sqlite3_key (sqlite3 *db, const void *pKey, int nKey)
{
    DDLogVerbose(@"sqlcipher sqlite3_key key: %@", NSData2Hex([NSData dataWithBytes:pKey length:nKey]));
    return orig_sqlite3_key(db, pKey, nKey);
}
int replaced_sqlite3_key_v2 (sqlite3 *db, const char *zDbName, const void *pKey, int nKey)
{
    return orig_sqlite3_key_v2(db, zDbName, pKey, nKey);
}




#define InstallHook_FindSymbol(funcname) if ([[plist objectForKey:@"settings_sqlite3_"#funcname] boolValue]) { MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic_FindSymbol(funcname) MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname)
void sqlite3_sqlcipher_function_hooks()
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

    InstallHook_FindSymbol(sqlite3_open);
    InstallHook_FindSymbol(sqlite3_open16);
    InstallHook_FindSymbol(sqlite3_open_v2);

    InstallHook_FindSymbol(sqlite3_key);
    InstallHook_FindSymbol(sqlite3_key_v2);
}





