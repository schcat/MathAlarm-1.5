//
//  BNRItemStore.m
//  0526NMTel
//
//  Created by Zhixue Li on 5/26/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import "AlarmItemStore.h"
#import "AlarmItem.h"
#import "AppDelegate.h"

@interface AlarmItemStore()
@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation AlarmItemStore

@synthesize allItems;

+ (instancetype)sharedStore
{
    static AlarmItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}
- (NSArray *)allItems
{
    return self.privateItems;
  //  return [self.privateItems copy];
}

- (AlarmItem *)createItem
{
    AlarmItem *item = [AlarmItem initItem];
    [self.privateItems addObject:item];
    return item;
}
-(void)removeItem:(AlarmItem *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
    //删除通知
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSLog(@"Delete %@", item.AlarmTime);
    NSLog(@"Delete %@", myDelegate.note.fireDate);
    if (item.AlarmTime == myDelegate.note.fireDate) {
        [[UIApplication sharedApplication] cancelLocalNotification:myDelegate.note];
        [[UIApplication sharedApplication] cancelLocalNotification:myDelegate.note1];
        [[UIApplication sharedApplication] cancelLocalNotification:myDelegate.note2];
        [[UIApplication sharedApplication] cancelLocalNotification:myDelegate.note3];
        [[UIApplication sharedApplication] cancelLocalNotification:myDelegate.note4];
    }
}
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    AlarmItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

@end
