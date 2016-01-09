//
//  BNRItem.h
//  NMTelInfo
//
//  Created by Zhixue Li on 5/27/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmItem : NSObject
{
    NSDate *_AlarmTime;
    NSString *_PuzzleLevel;
    BOOL _EveryDay;
    int _AlarmFrequency;
    BOOL _OnOrOff;
}
- (instancetype)initWithAlarmTime:(NSDate *)alarmTime
                      PuzzleLevel:(NSString *)puzzleLevel
                          OnOrOff:(BOOL *)onoroff;
+ (instancetype)initItem;

@property (nonatomic, copy) NSDate *AlarmTime;
@property (nonatomic, copy) NSString *PuzzleLevel;
@property (nonatomic) BOOL EveryDay;
@property (nonatomic) int AlarmFrequency;
@property (nonatomic) BOOL OnOrOff;

@end