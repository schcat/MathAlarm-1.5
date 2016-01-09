//
//  SetViewController.h
//  alarm0905
//
//  Created by Zhixue Li on 9/5/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@class AlarmItem;

@interface SetViewController : UIViewController

@property (nonatomic, strong) NSArray *pickerTime;
@property (nonatomic, strong) NSArray *pickerDegree;

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UIPickerView *degreePicker;
@property (nonatomic, strong) IBOutlet UIButton *alarmFrequency;
@property (nonatomic, strong) IBOutlet UIStepper *intervalSet;
@property (nonatomic, strong) IBOutlet UISwitch *mySwitch;

@property (nonatomic, strong) AlarmItem *item;

@end
