/*
 File Description:
  
    *********************
    ** Swizzler Common **
    *********************
*/

#import "swizzler.common.h"


NSString *NSData2Hex(NSData *data)
{
    NSString * hexStr = [NSString stringWithFormat:@"%@", data];

    for (NSString *toRemove in [NSArray arrayWithObjects:@"<", @">", @" ", nil]) 
        hexStr = [hexStr stringByReplacingOccurrencesOfString:toRemove withString:@""];

    return hexStr;
}

bool disableJBDectection()
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];
    return [[plist objectForKey:@"settings_disableJBDetection"] boolValue];
}

bool disableSSLPinning()
{
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:@PREFERENCEFILE];
    return [[plist objectForKey:@"settings_disable_sslpinning"] boolValue];
}

bool blockPath(const char *fpath) {
    NSString *path = [[NSString stringWithCString:fpath encoding:NSASCIIStringEncoding] lowercaseString];
    NSArray *denyPatterns = [[NSArray alloc] initWithObjects:
        @"Cydia",
        @"lib/apt",
        @"/private/var/lib/apt",
        @"/var/lib/apt",
        @"/var/tmp/cydia.log",
        @"/etc/apt/",
        @"/var/cache/apt",
        @"/bin/bash",
        @"/bin/sh",
        @"/Applications/Cydia.app",
        @"/Applications/Loader.app",
        @"MobileSubstrate",
        @"/stash",
        @"evasi0n",
        @"blackra1n",
        @"l1mera1n",
        @"dpkg",
        @"libhide",
        @"xCon",
        @"libactivator",
        @"libsubstrate",
        @"PreferenceLoader",
        @"sshd",
        @"ssh-key",
        @"/usr/bin/ssh",
        @"/etc/apt",
        @"cydia",
        @"cache/apt",
        @"syslog",
        @"sftp-server",
        @"/etc/ssh",
        @"/var/mobile/temp.txt",
        @"/dev/console",
        @"/bin/mv",
        @"/dev/tty",
        @"/dev/klog",
        @"/dev/pf",
        @"/dev/bpf",
        @"/dev/fsevents",
        @"/dev/uart",
        @"/dev/cu",
        @"/dev/bt",
        @"/dev/disk",
        @"/dev/rdisk",
        @"/dev/io8log",
        nil];
    BOOL matched = NO;
    for (NSString *regex in denyPatterns)
    {
        NSRange range = [path rangeOfString:regex options:NSRegularExpressionSearch|NSCaseInsensitiveSearch];
        if (range.location != NSNotFound)
        {
            NSLog(@"Jailbreak detection checked for %s matched %s in jailbreak_checks", fpath, [regex UTF8String]);
            matched = YES;
            break;
        }
    }
    return matched;
}