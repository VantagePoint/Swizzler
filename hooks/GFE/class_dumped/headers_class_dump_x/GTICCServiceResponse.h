/*
 *     Generated by class-dump 3.1.2.
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2007 by Steve Nygard.
 */

#import "_ABAddressBookAddRecord.h"

@class NSNumber, NSString;

@interface GTICCServiceResponse : _ABAddressBookAddRecord
{
    NSString *respB64Data;
    int respType;
    NSNumber *respError;
}

- (void)setRespError:(id)fp8;
- (id)respError;
- (void)setRespType:(int)fp8;
- (int)respType;
- (void)setRespB64Data:(id)fp8;
- (id)respB64Data;
- (void)dealloc;

@end

