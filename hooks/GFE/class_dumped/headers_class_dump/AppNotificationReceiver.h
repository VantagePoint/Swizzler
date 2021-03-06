//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

//
// SDK Root: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/
//

#import "UIWindow.h"

@class UIView;

@interface AppNotificationReceiver : UIWindow
{
    UIView *viewToObserve;
    id <TapDetectingWindowDelegate> controllerThatObserves;
}

@property(nonatomic) id <TapDetectingWindowDelegate> controllerThatObserves; // @synthesize controllerThatObserves;
@property(retain, nonatomic) UIView *viewToObserve; // @synthesize viewToObserve;
- (void)touchesMoved:(id)arg1 withEvent:(id)arg2;
- (void)broadcastNotificationWithEvent:(id)arg1;
- (void)sendEvent:(id)arg1;
- (void)doubleTap:(id)arg1;
- (void)forwardTap:(id)arg1;
- (void)dealloc;
- (id)initWithViewToObserver:(id)arg1 andDelegate:(id)arg2;

@end

