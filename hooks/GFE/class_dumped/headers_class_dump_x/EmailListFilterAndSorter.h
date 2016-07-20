/*
 *     Generated by class-dump 3.1.2.
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2007 by Steve Nygard.
 */

#import "_ABAddressBookAddRecord.h"

#import "FilteredCacheFilter-Protocol.h"

@class NSPredicate, NSString;

@interface EmailListFilterAndSorter : _ABAddressBookAddRecord <FilteredCacheFilter>
{
    BOOL _shouldReEvaluate;
    BOOL _isUnreadFilter;
    NSString *_sectionTitle;
    NSPredicate *_predicate;
    id _comparator;
}

- (void)setIsUnreadFilter:(BOOL)fp8;
- (BOOL)isUnreadFilter;
- (void)setShouldReEvaluate:(BOOL)fp8;
- (BOOL)shouldReEvaluate;
- (void)setComparator:(id)fp(null);
- (id)comparator;
- (void)setPredicate:(id)fp8;
- (id)predicate;
- (void)setSectionTitle:(id)fp8;
- (id)sectionTitle;
- (BOOL)shouldReorderObjects;
- (BOOL)shouldReEvaluateObjects;
- (BOOL)insertionIndexPathOfObject:(id)fp8 indexPath:(id *)fp12 inCache:(id)fp16;
- (id)filterCache:(id)fp8;
- (id)initWithPredicate:(id)fp8 comparator:(id)fp(null) title:(void)fp12;
- (id)initFlaggedFilter;
- (id)initPriorityFilter;
- (id)initUnreadFilter;
- (id)initSenderSort:(BOOL)fp8;
- (id)initSubjectSort;
- (void)dealloc;

@end
