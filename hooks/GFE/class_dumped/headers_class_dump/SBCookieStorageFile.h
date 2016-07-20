//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

//
// SDK Root: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/
//

#import "NSObject.h"

#import "SBCookieStorageProtocol.h"

@interface SBCookieStorageFile : NSObject <SBCookieStorageProtocol>
{
}

- (void)deleteAllExpiredCookies;
- (id)cookiesForDomains:(id)arg1 isSecured:(BOOL)arg2;
- (id)cookiesForDomain:(id)arg1 isSecured:(BOOL)arg2;
- (void)deleteCookie:(id)arg1;
- (id)cookiesForURL:(id)arg1;
- (id)cookies;
- (void)setCookies:(id)arg1 forURL:(id)arg2 mainDocumentURL:(id)arg3;
- (void)setCookie:(id)arg1;

@end
