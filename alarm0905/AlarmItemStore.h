//
//  BNRItemStore.h
//  0526NMTel
//
//  Created by Zhixue Li on 5/26/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlarmItem;

@interface AlarmItemStore : NSObject{
    NSArray *allItems;
}

@property (nonatomic, retain, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (AlarmItem *)createItem;
- (void)removeItem:(AlarmItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;

@end
