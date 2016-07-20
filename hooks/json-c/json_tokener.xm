/*
 File Description:
  
  ***************************
  ** json-c function hooks **
  ***************************

  http://json-c.github.io
*/
void (*orig_json_object_object_add) (struct json_object *obj, const char *key, struct json_object *val);
void replaced_json_object_object_add (struct json_object *obj, const char *key, struct json_object *val)
{
    DDLogVerbose(@"json_object_object_add key: %s", key);
    orig_json_object_object_add(obj, key, val);
}


struct json_object *(*orig_json_tokener_parse) (const char *str);
struct json_object *replaced_json_tokener_parse (const char *str)
{
    DDLogVerbose(@"json_tokener_parse: %s", str);
    return orig_json_tokener_parse(str);
}


#define InstallHook_FindSymbol(funcname) if ([[plist objectForKey:@"settings_HookJSONC_"#funcname] boolValue]) { MSHookFunction(MSFindSymbol(NULL, "_"#funcname), (void *)replaced_##funcname, (void**)&orig_##funcname); }

void jsonc_function_hooks()
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];

    InstallHook_FindSymbol(json_tokener_parse);
    InstallHook_FindSymbol(json_object_object_add);
}






