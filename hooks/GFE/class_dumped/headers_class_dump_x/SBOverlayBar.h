/*
 *     Generated by class-dump 3.1.2.
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2007 by Steve Nygard.
 */

#import "_ABAddressBookAddRecord.h"

@class NSArray, NSTimer, UIButton;

@interface SBOverlayBar : _ABAddressBookAddRecord
{
    BOOL _isFullScreen;
    UIButton *_fullscreenButton;
    NSTimer *_hidingTimer;
    NSArray *_childrenArray;
}

+ (id)fullscreenExpandActiveImage;
+ (id)fullscreenCollapseActiveImage;
+ (id)fullscreenExpandImage;
+ (id)fullscreenCollapseImage;
- (void)setChildrenArray:(id)fp8;
- (id)childrenArray;
- (void)setHidingTimer:(id)fp8;
- (id)hidingTimer;
- (void)setIsFullScreen:(BOOL)fp8;
- (BOOL)isFullScreen;
- (id)fullscreenButton;
- (void)show:(BOOL)fp8 animated:(BOOL)fp12;
- (void)hideOverlayBar;
- (void)disableAutoHide;
- (void)scheduleAutoHide;
- (void)updateLayoutForOrientation:(int)fp8;
- (void)onFullScreenTouched:(id)fp8;
- (void)setupLayout;
- (void)setFrame:(struct CGRect)fp8;
- (void)dealloc;
- (id)init;

@end

