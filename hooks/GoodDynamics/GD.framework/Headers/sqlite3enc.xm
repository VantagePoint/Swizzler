/*
 *  Copyright (c) Visto Corporation dba Good Technology, 2011. All rights reserved.
 */

// #include "sqlite3.h"

// #ifdef __cplusplus
// extern "C" {
// #endif

int (*orig_sqlite3enc_open) (const char* filename, sqlite3** ppDb);
int (*orig_sqlite3enc_open_v2) (const char *zFilename, sqlite3 **ppDb, int flags, const char *zVfs);
int (*orig_sqlite3enc_import) (const char* srcFilename, const char* destFilename);

// #ifdef __cplusplus
// }
// #endif


int replaced_sqlite3enc_open(const char* filename, sqlite3** ppDb)
{
	DDLogVerbose(@"GD sqlite3enc sqlite3enc_open filename: %s", filename);
	return orig_sqlite3enc_open(filename, ppDb);
}
int replaced_sqlite3enc_open_v2(const char *zFilename, sqlite3 **ppDb, int flags, const char *zVfs)
{
	DDLogVerbose(@"GD sqlite3enc sqlite3enc_open_v2 filename: %s", zFilename);
	return orig_sqlite3enc_open_v2(zFilename, ppDb, flags, zVfs);
}
int replaced_sqlite3enc_import(const char* srcFilename, const char* destFilename)
{
	DDLogVerbose(@"GD sqlite3enc sqlite3enc_import filename: %s", srcFilename);
	return orig_sqlite3enc_import(srcFilename, destFilename);
}


#define InstallHook_FindSymbol(funcname) if ([[plist objectForKey:@"settings_sqlite3_"#funcname] boolValue]) { MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname); }
#define InstallHook_basic_FindSymbol(funcname) MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname)
void GD_sqlite3enc_hooks()
{
	InstallHook_FindSymbol(sqlite3enc_open);
	InstallHook_FindSymbol(sqlite3enc_open_v2);
	InstallHook_FindSymbol(sqlite3enc_import);
}