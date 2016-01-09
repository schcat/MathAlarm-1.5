//
//  SetViewController.m
//  alarm0905
//
//  Created by Zhixue Li on 9/5/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import "SetViewController.h"
#import "AlarmItem.h"

@interface SetViewController()

@property (weak, nonatomic) IBOutlet UILabel *timeInterval;

@end

@implementation SetViewController

@synthesize datePicker;
@synthesize pickerTime;
@synthesize degreePicker;
@synthesize pickerDegree;
@synthesize alarmFrequency;

@synthesize intervalSet;

bool key = YES;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    AlarmItem *item = self.item;
    
    NSDate *settime = item.AlarmTime;
    [datePicker setDate:settime animated:NO];
    
  //  UILabel *myView;
  //  myView.font = [UIFont systemFontOfSize:14];
  //  datePicker.

    int levelNumber;
    if ([item.PuzzleLevel isEqualToString:@"Level 1: 9*9"])
    {
        levelNumber = 0;
    }else if ([item.PuzzleLevel isEqualToString:@"Level 2: 9*99"])
    {
        levelNumber = 1;
    }else if ([item.PuzzleLevel isEqualToString:@"Level 3: 99*99"])
    {
        levelNumber = 2;
    }
    NSArray *array = [[NSArray alloc] initWithObjects:@"Level 1: 9*9", @"Level 2: 9*99", @"Level 3: 99*99", nil];
    self.pickerDegree = array;
    [degreePicker selectRow:levelNumber inComponent:0 animated:nil];
    
    NSString *str = [NSString stringWithFormat:@"%d", item.AlarmFrequency];
    self.timeInterval.text = [NSString stringWithFormat: @"%@ min", str];
    
    if (item.EveryDay) {
        [alarmFrequency setTitle:@"每天"forState:UIControlStateNormal];
    }else{
        [alarmFrequency setTitle:@"一次"forState:UIControlStateNormal];
    }
    
    intervalSet.minimumValue = 1;
    intervalSet.maximumValue = 10;
    intervalSet.stepValue = 1;
    intervalSet.value = 5;
    
    [self.mySwitch setOn:item.OnOrOff animated:YES];

    // Do any additional setup after loading the view from its nib.
}

- (IBAction)addReminder:(id)sender{

    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//        NSLog(@"local information");
    }
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSDate *date = self.datePicker.date;
    NSInteger row = [degreePicker selectedRowInComponent:0];
    NSString *selectedDegree = [pickerDegree objectAtIndex:row];
    AlarmItem *item = self.item;
    
//    NSLog(@"converteddate is %@", date);
    
    item.AlarmTime = date;
    item.PuzzleLevel = selectedDegree;
    item.EveryDay = key;
    item.AlarmFrequency = intervalSet.value;
//    NSLog(@"You a set an alarm at %@ with %@", item.AlarmTime, item.PuzzleLevel);
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"HH:mm"];
//    NSString *destDateString = [dateFormatter stringFromDate:date];
    
//    self.showTime.text = destDateString;
//    self.showLevel.text = selectedDegree;
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"OK"
                                                   message:@"Alarm is set!"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
    [alertview show];
    [alertview dismissWithClickedButtonIndex:0 animated:NO];
    
    //注册了一个通知
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    myDelegate.note = [[UILocalNotification alloc] init];
    myDelegate.note.soundName = @"littlestar.wav";
    myDelegate.note.alertBody = @"Wake up me!";
    myDelegate.note.fireDate = date;
    
    if (key == YES) {
        myDelegate.note.repeatInterval = kCFCalendarUnitDay;
    }
    
    NSString *keystr = [NSString stringWithFormat:@"%@",key?@"YES":@"NO"];
    NSString *fre = [NSString stringWithFormat:@"%f", intervalSet.value];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [dictionary setObject:selectedDegree forKey:@"key1"];
    [dictionary setObject:date forKey:@"key2"];
    [dictionary setObject:keystr forKey:@"key3"];
    [dictionary setObject:fre forKey:@"key4"];
    
    myDelegate.note.userInfo = dictionary;
    
//    NSLog(@"datetostring is %@", destDateString);
    
//    NSLog(@"Setting a reminder for %@", myDelegate.note.fireDate);
    [[UIApplication sharedApplication] scheduleLocalNotification:myDelegate.note];
    
    myDelegate.alarmIsOverOrNot = [NSNumber numberWithInt:1];
    
    myDelegate.note1 = [[UILocalNotification alloc] init];
    myDelegate.note1.soundName = @"littlestar.wav";
    myDelegate.note1.alertBody = @"Wake up me!";
    myDelegate.note1.fireDate = [NSDate dateWithTimeInterval: 1 * intervalSet.value * 60 * intervalSet.value sinceDate:date];
    if (key == YES) {
        myDelegate.note1.repeatInterval = kCFCalendarUnitDay;
    }
    myDelegate.note1.userInfo = dictionary;
    [[UIApplication sharedApplication] scheduleLocalNotification:myDelegate.note1];
    
    myDelegate.note2 = [[UILocalNotification alloc] init];
    myDelegate.note2.soundName = @"littlestar.wav";
    myDelegate.note2.alertBody = @"Wake up me!";
    myDelegate.note2.fireDate = [NSDate dateWithTimeInterval: 2 * intervalSet.value * 60 * intervalSet.value sinceDate:date];
    if (key == YES) {
        myDelegate.note2.repeatInterval = kCFCalendarUnitDay;
    }
    myDelegate.note2.userInfo = dictionary;
    [[UIApplication sharedApplication] scheduleLocalNotification:myDelegate.note2];
    
    myDelegate.note3 = [[UILocalNotification alloc] init];
    myDelegate.note3.soundName = @"littlestar.wav";
    myDelegate.note3.alertBody = @"Wake up me!";
    myDelegate.note3.fireDate = [NSDate dateWithTimeInterval: 3 * intervalSet.value * 60 * intervalSet.value sinceDate:date];
    if (key == YES) {
        myDelegate.note3.repeatInterval = kCFCalendarUnitDay;
    }
    myDelegate.note3.userInfo = dictionary;
    [[UIApplication sharedApplication] scheduleLocalNotification:myDelegate.note3];
    
    myDelegate.note4 = [[UILocalNotification alloc] init];
    myDelegate.note4.soundName = @"littlestar.wav";
    myDelegate.note4.alertBody = @"Wake up me!";
    myDelegate.note4.fireDate = [NSDate dateWithTimeInterval: 4 * intervalSet.value * 60 * intervalSet.value sinceDate:date];
    if (key == YES) {
        myDelegate.note4.repeatInterval = kCFCalendarUnitDay;
    }
    myDelegate.note4.userInfo = dictionary;
    [[UIApplication sharedApplication] scheduleLocalNotification:myDelegate.note4];
    
    [self.mySwitch setOn:YES animated:YES];
}

- (IBAction)alarmFrequency:(id)sender{
    key =! key;
    if (key) {
        [alarmFrequency setTitle:@"每天"forState:UIControlStateNormal];
    }else{
        [alarmFrequency setTitle:@"一次"forState:UIControlStateNormal];
    }
}

- (IBAction)intervalSet:(id)sender{
    int intstr = (int)intervalSet.value;
    NSString *str = [NSString stringWithFormat:@"%d",intstr];
    self.timeInterval.text = [NSString stringWithFormat: @"%@ min", str];
}

- (IBAction)mySwitch:(id)sender{
    AlarmItem *item = self.item;
    if (self.mySwitch.isOn) {
        //开启通知
        item.OnOrOff = YES;
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        [[UIApplication sharedApplication] scheduleLocalNotification:myDelegate.note];
        [[UIApplication sharedApplication] scheduleLocalNotification:myDelegate.note1];
        [[UIApplication sharedApplication] scheduleLocalNotification:myDelegate.note2];
        [[UIApplication sharedApplication] scheduleLocalNotification:myDelegate.note3];
        [[UIApplication sharedApplication] scheduleLocalNotification:myDelegate.note4];
        NSLog(@"open");
    }else{
        //释放通知
        item.OnOrOff = NO;
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        [[UIApplication sharedApplication] cancelLocalNotification:myDelegate.note];
        [[UIApplication sharedApplication] cancelLocalNotification:myDelegate.note1];
        [[UIApplication sharedApplication] cancelLocalNotification:myDelegate.note2];
        [[UIApplication sharedApplication] cancelLocalNotification:myDelegate.note3];
        [[UIApplication sharedApplication] cancelLocalNotification:myDelegate.note4];
        NSLog(@"close");
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
 //       pickerLabel.minimumFontSize = 8.;
 //       pickerLabel.adjustsFontSizeToFitWidth = YES;
//        [pickerLabel setTextAlignment:UITextAlignmentCenter];
//        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setItem:(AlarmItem *)itemse
{
    _item = itemse;
 //   self.navigationItem.title = _item.NMTelContactName;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerDegree count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerDegree objectAtIndex:row];
}

//#pragma mark
//-(void)removeNotification{
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onOrOff:(id)sender {
}
@end
