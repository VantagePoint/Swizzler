//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

//
// SDK Root: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/
//

#import "UITableViewController.h"

#import "GmmStatusWatcherDelegate.h"
#import "UIActionSheetDelegate.h"

@class CellWithSwitch, ContactsSyncHelper, NSMutableArray, NSMutableDictionary, PreferencesViewSecurityManager, SBBrowserSectionManager;

@interface PreferencesMenuTVC : UITableViewController <UIActionSheetDelegate, GmmStatusWatcherDelegate>
{
    _Bool isGoodUser;
    struct CSecurityManager *_securityManager;
    ContactsSyncHelper *_contactsSyncHelper;
    NSMutableArray *availableSections;
    NSMutableArray *debugSection;
    CellWithSwitch *contactSyncCell;
    NSMutableDictionary *_footers;
    BOOL m_bViewIsVisible;
    BOOL _isiOS7orAbove;
    _Bool m_bSMIMEEnabled;
    PreferencesViewSecurityManager *smimeSecurityManager;
    SBBrowserSectionManager *_browserSectionManager;
}

@property(retain, nonatomic) SBBrowserSectionManager *browserSectionManager; // @synthesize browserSectionManager=_browserSectionManager;
@property(retain, nonatomic) PreferencesViewSecurityManager *smimeSecurityManager; // @synthesize smimeSecurityManager;
@property(retain, nonatomic) CellWithSwitch *contactSyncCell; // @synthesize contactSyncCell;
@property(retain, nonatomic) NSMutableArray *availableSections; // @synthesize availableSections;
@property(nonatomic) struct CSecurityManager *securityManager; // @synthesize securityManager=_securityManager;
- (id)newDebugMenuArray;
- (void)secureBrowserTests;
- (void)runtimeTests;
- (void)showStatusView;
- (void)showDebugMenu;
- (void)onStoringCredentialsSwitchChanged:(id)arg1;
- (void)onSMIMEHTMLEnableChanged:(id)arg1;
- (void)onHTMLEnableChanged:(id)arg1;
- (void)onDefaultEncryptionChanged:(id)arg1;
- (id)tableView:(id)arg1 viewForFooterInSection:(int)arg2;
- (id)tableView:(id)arg1 viewForHeaderInSection:(int)arg2;
- (float)tableView:(id)arg1 heightForFooterInSection:(int)arg2;
- (float)tableView:(id)arg1 heightForHeaderInSection:(int)arg2;
- (float)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (void)viewDidUnload;
- (void)didReceiveMemoryWarning;
- (void)dealloc;
- (void)toggleConversationView:(id)arg1;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (void)toggleCalendarSounds:(id)arg1;
- (void)toggleContactSync:(id)arg1;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (int)shiftUnusedRowForSMIMESection:(int)arg1;
- (int)shiftUnusedRowForEmailSection:(int)arg1;
- (void)updateContactSyncSwitch;
- (int)tableView:(id)arg1 numberOfRowsInSection:(int)arg2;
- (int)numberOfSectionsInTableView:(id)arg1;
- (void)needReloadView:(id)arg1;
- (void)refreshSMIMEOptions:(id)arg1;
- (void)dismissSecurityNC:(id)arg1;
- (void)dismissSubFolderTVC:(id)arg1;
- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1;
- (unsigned int)supportedInterfaceOrientations;
- (BOOL)shouldAutorotate;
- (void)setupCell:(id)arg1 WithLabel:(id)arg2 andDetailedText:(id)arg3;
- (void)reloadGDBrowsersAvailable:(id)arg1;
- (void)lastUpdateChanged;
- (void)viewDidDisappear:(BOOL)arg1;
- (void)viewWillDisappear:(BOOL)arg1;
- (void)viewDidAppear:(BOOL)arg1;
- (void)viewWillAppear:(BOOL)arg1;
- (void)setupSectionsAndReloadView;
- (void)viewDidLoad;
- (void)notesIdPasswordSelected;
- (id)getDefaultAutomationScreenName;

@end
