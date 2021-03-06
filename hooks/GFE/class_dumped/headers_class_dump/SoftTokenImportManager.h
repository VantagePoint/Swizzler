//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

//
// SDK Root: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/
//

#import "NSObject.h"

#import "SoftTokenImportFinishedProtocol.h"

@class SmimeAlertView, SmimeAlertViewsFactory, SmimeModuleAccessor, SoftTokenImportWorker, SoftTokenImportWorkersQueue, UINavigationController;

@interface SoftTokenImportManager : NSObject <SoftTokenImportFinishedProtocol>
{
    SoftTokenImportWorkersQueue *queue;
    SoftTokenImportWorker *currentWorker;
    SmimeModuleAccessor *smimeModuleAccessor;
    SmimeAlertViewsFactory *alertViewsFactory;
    SmimeAlertView *softTokenHowToAlertView;
    BOOL invokedFromPreferences;
    UINavigationController *navControllerForSoftTokenImportUsage;
}

@property(nonatomic) UINavigationController *navControllerForSoftTokenImportUsage; // @synthesize navControllerForSoftTokenImportUsage;
@property(nonatomic) BOOL invokedFromPreferences; // @synthesize invokedFromPreferences;
@property(retain, nonatomic) SmimeModuleAccessor *smimeModuleAccessor; // @synthesize smimeModuleAccessor;
@property(retain, nonatomic) SmimeAlertViewsFactory *alertViewsFactory; // @synthesize alertViewsFactory;
- (id)getCurrentWorkerQueue;
- (void)installCertificate:(id)arg1;
- (void)handleHowToInstallTokenNowOrLater:(id)arg1;
- (BOOL)startNewWorkerFromQueue;
- (int)areSoftTokensToBeInstalled;
- (void)dealloc;
- (void)softTokenImportFinished:(id)arg1;
- (BOOL)initImportSoftToken;
- (void)installCertificates:(id)arg1;
- (void)showInstallSoftTokenAlertViewAfterUnlock;
- (void)handleCertificatesInstallationResult:(id)arg1;
- (id)init;

@end

