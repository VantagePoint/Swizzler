/*
 *     Generated by class-dump 3.1.2.
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2007 by Steve Nygard.
 */

#import "SBPageStateManagerBase.h"

@class NSTimer;

@interface SBPageStateManagerWebViewTracker : SBPageStateManagerBase
{
    NSTimer *_pageLoadingPollTimer;
    BOOL _dataIsDownloading;
    NSTimer *_dataDownloadingTimer;
    double _timeToUpdateDownloadingTimer;
}

- (void)setDataDownloadingTimer:(id)fp8;
- (id)dataDownloadingTimer;
- (BOOL)dataIsDownloading;
- (void)setPageLoadingPollTimer:(id)fp8;
- (id)pageLoadingPollTimer;
- (void)onDataDownloading;
- (void)dataDownloadingStop:(id)fp8;
- (BOOL)isWebViewLoading;
- (void)onPageLoadPollTimer:(id)fp8;
- (BOOL)hasPageFinishedLoading;
- (void)handlePageRedirection;
- (void)handlePageLoadError:(id)fp8;
- (void)handlePageLoadAbortionEnd;
- (void)handlePageLoadAbortionStart;
- (BOOL)isTimerWorking;
- (void)handlePageStartLoadingWithURL:(id)fp8;
- (void)handlePageFinishedLoading;
- (void)webViewDidFinishLoad;
- (void)resetPageLoadingTrackers;
- (void)enable:(BOOL)fp8;
- (void)dealloc;

@end

