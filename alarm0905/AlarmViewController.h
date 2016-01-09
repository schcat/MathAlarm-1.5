//
//  AlarmViewController.h
//  alarm0905
//
//  Created by Zhixue Li on 9/5/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SetViewController.h"
#import "AlarmItem.h"

@interface AlarmViewController : UIViewController

@property (nonatomic, retain) NSNumber *answer;

@property (nonatomic, strong) IBOutlet UIPickerView *resultPicker;
@property (nonatomic, strong) NSArray *pickerResult1;
@property (nonatomic, strong) NSArray *pickerResult2;
@property (nonatomic, strong) NSArray *pickerResult3;
@property (nonatomic, strong) NSArray *pickerResult4;

@property (nonatomic, strong) AlarmItem *item;

@end
