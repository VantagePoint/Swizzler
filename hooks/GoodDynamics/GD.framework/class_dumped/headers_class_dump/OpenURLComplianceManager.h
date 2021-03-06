//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "UIAlertViewDelegate.h"

@class GDMail, GDMailComposeViewController, NSArray, NSDictionary, NSString, NSURL;

@interface OpenURLComplianceManager : NSObject <UIAlertViewDelegate>
{
    BOOL _isRestrictedToGFEOnly;
    CDUnknownBlockType _presentationCompletionBlock;
    CDUnknownBlockType _presentationBlockOriginal;
    GDMailComposeViewController *_mailComposeViewController;
    GDMail *_mail;
    NSURL *_mailtoURL;
    NSArray *_mailAttachmentPaths;
    NSDictionary *_mailAttachmentData;
}

+ (id)stringByDecodingURLFormatString:(id)arg1;
+ (id)emailListToArray:(id)arg1;
+ (id)extractMailToParamsFromUrlParamString:(id)arg1;
+ (id)parseMailto:(id)arg1;
+ (int)dummyRequestId;
+ (BOOL)instructGFEToHandleEmail:(id)arg1 withError:(id *)arg2;
+ (BOOL)instructGFEToHandleEmail:(id)arg1 withMail:(id)arg2 andAttachmentPaths:(id)arg3 andAttachmentData:(id)arg4 withError:(id *)arg5;
+ (void)instructGFEToHandleMailTo:(id)arg1;
+ (void)handlePresentOfMailViewController:(id)arg1 withCompletion:(CDUnknownBlockType)arg2 andOriginalPresentationRequest:(CDUnknownBlockType)arg3;
+ (id)sharedManager;
@property(retain, nonatomic) NSDictionary *mailAttachmentData; // @synthesize mailAttachmentData=_mailAttachmentData;
@property(retain, nonatomic) NSArray *mailAttachmentPaths; // @synthesize mailAttachmentPaths=_mailAttachmentPaths;
@property(retain, nonatomic) NSURL *mailtoURL; // @synthesize mailtoURL=_mailtoURL;
@property(retain, nonatomic) GDMail *mail; // @synthesize mail=_mail;
@property(retain, nonatomic) GDMailComposeViewController *mailComposeViewController; // @synthesize mailComposeViewController=_mailComposeViewController;
@property(copy) CDUnknownBlockType presentationBlockOriginal; // @synthesize presentationBlockOriginal=_presentationBlockOriginal;
@property(copy) CDUnknownBlockType presentationCompletionBlock; // @synthesize presentationCompletionBlock=_presentationCompletionBlock;
@property(nonatomic) BOOL isRestrictedToGFEOnly; // @synthesize isRestrictedToGFEOnly=_isRestrictedToGFEOnly;
- (void)swizzleMailToMethods;
- (id)initForMailComposeViewController;
- (void)removeLimitToGFE;
- (void)limitToGFE;
- (void)displayGFERestrictionNotAllowed;
- (void)displayGFERestrictionUnavailable;
- (void)displayGFERestrictionIfAppropriateFromError:(id)arg1;
- (void)informMailDelegate:(id)arg1 ofEmailRequestAcceptanceStatus:(BOOL)arg2 withError:(id)arg3;
- (BOOL)instructGFEToHandleEmailWithParams:(id)arg1 andAttachmentsWithPaths:(id)arg2 andAttachmentData:(id)arg3 withError:(id *)arg4;
- (void)alertView:(id)arg1 clickedButtonAtIndex:(int)arg2;
- (void)sendEmailOnBehalfOfMailComposeViewController:(id)arg1 withCompletion:(CDUnknownBlockType)arg2;
- (void)sendEmailOnBehalfOfMailComposeViewController:(id)arg1 withMail:(id)arg2 andAttachmentPaths:(id)arg3 andAttachmentData:(id)arg4 withCompletion:(CDUnknownBlockType)arg5;
- (void)presentMailChoiceAlert;
- (void)presentMailChoiceAlertForURL:(id)arg1 andOriginalPresentationRequest:(CDUnknownBlockType)arg2;
- (void)clearLocalVariables;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned int hash;
@property(readonly) Class superclass;

@end

