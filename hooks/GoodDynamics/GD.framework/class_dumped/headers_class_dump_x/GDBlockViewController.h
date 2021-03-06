/*
 *     Generated by class-dump 3.1.2.
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2007 by Steve Nygard.
 */

#import "GDViewController.h"

#import "UIAlertViewDelegate-Protocol.h"

@class NSString, UIButton, UILabel, UITextView, gdui_button;

@interface GDBlockViewController : GDViewController <UIAlertViewDelegate>
{
    UILabel *blockTitleView;
    UITextView *blockMessageView;
    NSString *blockMessage;
    BOOL retry;
    BOOL willUpdate;
    BOOL offerRemoteUnlock;
    BOOL waitingMDMCallback;
    int reason;
    gdui_button *_unlockButton;
    gdui_button *_initiateMDMButton;
    UIButton *setupAccessKeyButton;
    NSString *_blockTitle;
}

- (void)setBlockTitle:(id)fp8;
- (id)blockTitle;
- (void)setSetupAccessKeyButton:(id)fp8;
- (id)setupAccessKeyButton;
- (void)setInitiateMDMButton:(id)fp8;
- (void)setUnlockButton:(id)fp8;
- (void)setWaitingMDMCallback:(BOOL)fp8;
- (BOOL)waitingMDMCallback;
- (void)setOfferRemoteUnlock:(BOOL)fp8;
- (BOOL)offerRemoteUnlock;
- (void)setWillUpdate:(BOOL)fp8;
- (BOOL)willUpdate;
- (void)setRetry:(BOOL)fp8;
- (BOOL)retry;
- (void)setReason:(int)fp8;
- (int)reason;
- (void)setBlockMessage:(id)fp8;
- (id)blockMessage;
- (void)setBlockMessageView:(id)fp8;
- (id)blockMessageView;
- (void)setBlockTitleView:(id)fp8;
- (id)blockTitleView;
- (void)bottomInfoButtonAction;
- (BOOL)updateUI2:(id)fp8;
- (BOOL)updateUI:(BOOL)fp8;
- (void)moveButton:(id)fp8 belowTexView:(id)fp12;
- (void)updateUIToOrientation:(int)fp8;
- (void)positionMDMButton:(int)fp8;
- (void)showInitiateMDMButton;
- (void)loadViewForAll;
- (void)loadViewForiPhone;
- (void)loadViewForiPad;
- (void)positionSpinner:(int)fp8;
- (void)hideSpinner;
- (void)showSpinner;
- (void)becameActivate;
- (void)initiateMDMButtonPressed:(id)fp8;
- (void)unlockButtonPressed:(id)fp8;
- (void)dealloc;
- (id)initiateMDMButton;
- (id)unlockButton;
- (id)setupAccessKeyButtonCreate;
- (id)buttonWithTypeAccordingToVersion;
- (void)setupUsingYourAccessKeyButtonAction:(id)fp8;
- (void)alertView:(id)fp8 didDismissWithButtonIndex:(int)fp12;
- (void)viewDidAppear:(BOOL)fp8;
- (void)viewDidLoad;
- (id)initWithNibName:(id)fp8 bundle:(id)fp12;

@end

