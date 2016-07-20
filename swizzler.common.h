/*
 File Description:
  
    *********************
    ** Swizzler Common **
    *********************
*/
#import <substrate.h>
#define PREFERENCEFILE "/private/var/mobile/Library/Preferences/me.vtky.swizzler.plist"
#import "CocoaLumberjack/CocoaLumberjack.h"

NSString *NSData2Hex(NSData *data);
bool disableJBDectection();
bool disableSSLPinning();
bool blockPath(const char *path);

