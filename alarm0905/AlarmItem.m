//
//  BNRItem.m
//  NMTelInfo
//
//  Created by Zhixue Li on 5/27/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import "AlarmItem.h"

@implementation AlarmItem

- (NSString *)description
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"hh:mm a";
//        dateFormatter.dateStyle = NSDateFormatterNoStyle;
//        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    }
    NSString *string = [dateFormatter stringFromDate:self.AlarmTime];
    
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@", string];
    
    return descriptionString;
}
- (instancetype)initWithAlarmTime:(NSDate *)alarmTime
                      PuzzleLevel:(NSString *)puzzleLevel
                         EveryDay:(BOOL)everyDay
                   AlarmFrequency:(int)alarmFrequency
                          OnOrOff:(BOOL)onoroff
{
    self = [super init];
    if (self) {
        _AlarmTime = alarmTime;
        _PuzzleLevel = puzzleLevel;
        _EveryDay = everyDay;
        _AlarmFrequency = alarmFrequency;
        _OnOrOff = onoroff;
    }
    return self;
}

+ (instancetype)initItem
{
    NSDate *date = [NSDate date];
    AlarmItem *newItem = [[self alloc] initWithAlarmTime:date
                                             PuzzleLevel:@"Level: 9*9"
                                                EveryDay:YES
                                          AlarmFrequency:5
                                                 OnOrOff:YES];
    return newItem;
}

@end