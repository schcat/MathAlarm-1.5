//
//  AppDelegate.h
//  alarm0905
//
//  Created by Zhixue Li on 9/5/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AlarmViewController.h"
#import "ListViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
//    NSNumber *alarmIsOverOrNot;
//    NSString *degreeOfThisAlarm;
}
@property (nonatomic, retain) NSNumber *alarmIsOverOrNot;
@property (nonatomic, retain) NSString *degreeOfThisAlarm;
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UILocalNotification *note;
@property (nonatomic, strong) UILocalNotification *note1;
@property (nonatomic, strong) UILocalNotification *note2;
@property (nonatomic, strong) UILocalNotification *note3;
@property (nonatomic, strong) UILocalNotification *note4;

@property (nonatomic, strong) UILocalNotification *nota1;
@property (nonatomic, strong) UILocalNotification *nota2;
@property (nonatomic, strong) UILocalNotification *nota3;
@property (nonatomic, strong) UILocalNotification *nota4;

@end

