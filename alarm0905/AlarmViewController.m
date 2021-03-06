//
//  AlarmViewController.m
//  alarm0905
//
//  Created by Zhixue Li on 9/5/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import "AlarmViewController.h"
#import "ListViewController.h"
#import "AlarmQuestion.h"
#import "AlarmItemStore.h"
#import <AVFoundation/AVFoundation.h>

@interface AlarmViewController()
@property (weak, nonatomic) IBOutlet UILabel *questionLable;
@property (weak, nonatomic) IBOutlet UILabel *tipLable;

@property(nonatomic,strong)AVAudioPlayer *audioplayer;

@end

@implementation AlarmViewController

@synthesize resultPicker;
@synthesize pickerResult1;
@synthesize pickerResult2;
@synthesize pickerResult3;
@synthesize pickerResult4;

@synthesize answer;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
 //   MusicAction *music1 = [[MusicAction alloc] init];
    
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"zhizuo.wav" withExtension:Nil];
    self.audioplayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:Nil];
    [self.audioplayer prepareToPlay];
    
//    NSLog(@"Play music");
    
    [self.audioplayer play];
    
    [super viewWillAppear:animated];
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    self.pickerResult1 = array1;
    NSArray *array2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    self.pickerResult2 = array2;
    NSArray *array3 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    self.pickerResult3 = array3;
    NSArray *array4 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    self.pickerResult4 = array4;

    NSString *puzzleLevel;
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    puzzleLevel = myDelegate.degreeOfThisAlarm;
//    NSLog(@"PuzzleLevel is %@", puzzleLevel);
    
    AlarmQuestion *alarmQuestion = [AlarmQuestion initQuestion:puzzleLevel];
    
    self.questionLable.text = alarmQuestion.showQuestion;
    self.tipLable.text = @"Answer the Question ?";
    
    answer = (NSNumber*)alarmQuestion.stringAnswer;
}

- (IBAction)addReminder:(id)sender{

    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//        NSLog(@"local information");
    }
    
    NSInteger row0 = [resultPicker selectedRowInComponent:0];
    NSString *number1Int = [pickerResult1 objectAtIndex:row0];
    int number1 = [number1Int intValue];
    
    NSInteger row1 = [resultPicker selectedRowInComponent:1];
    NSString *number2Int = [pickerResult2 objectAtIndex:row1];
    int number2 = [number2Int intValue];
    
    NSInteger row2 = [resultPicker selectedRowInComponent:2];
    NSString *number3Int = [pickerResult3 objectAtIndex:row2];
    int number3 = [number3Int intValue];
    
    NSInteger row3 = [resultPicker selectedRowInComponent:3];
    NSString *number4Int = [pickerResult4 objectAtIndex:row3];
    int number4 = [number4Int intValue];
    
    int calculateResult = 0;
    calculateResult = 1000 * number1 + 100 * number2 + 10 * number3 + number4;
    
//    NSLog(@"calculateResult is %d", calculateResult);
    
    int answerInt = [answer intValue];
//    NSLog(@"answer is %d", answerInt);
    
    if (calculateResult - answerInt == 0) {
        self.tipLable.text = @"Your answer is right !";
//        NSLog(@"It's right!");
        [self.audioplayer stop];
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        myDelegate.alarmIsOverOrNot = [NSNumber numberWithInt:1];
        
        ListViewController *listViewController = [[ListViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc]
                                                 initWithRootViewController:listViewController];

        [self presentViewController:navController animated:YES completion:nil];
        
    }else{
        self.tipLable.text = @"It's wrong !";
//        NSLog(@"It's wrong!");
    }
}

#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerResult1 count];
    return [pickerResult2 count];
    return [pickerResult3 count];
    return [pickerResult4 count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerResult1 objectAtIndex:row];
    return [pickerResult2 objectAtIndex:row];
    return [pickerResult3 objectAtIndex:row];
    return [pickerResult4 objectAtIndex:row];
}

@end
