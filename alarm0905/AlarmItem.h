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
}
- (instancetype)initWithAlarmTime:(NSDate *)alarmTime
                      PuzzleLevel:(NSString *)puzzleLevel;
+ (instancetype)initItem;

@property (nonatomic, copy) NSDate *AlarmTime;
@property (nonatomic, copy) NSString *PuzzleLevel;

@end