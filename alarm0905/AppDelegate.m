//
//  AppDelegate.m
//  alarm0905
//
//  Created by Zhixue Li on 9/5/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize alarmIsOverOrNot;
@synthesize degreeOfThisAlarm;

@synthesize note1;
@synthesize note2;
@synthesize note3;
@synthesize note4;

@synthesize nota1;
@synthesize nota2;
@synthesize nota3;
@synthesize nota4;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    alarmIsOverOrNot = [NSNumber numberWithInt:0];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ListViewController *listViewController = [[ListViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:listViewController];
    
    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];  
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    NSDate *nowDate = [NSDate date];
    NSLog(@"thedatenow is %@", nowDate);
    
    NSString *degree = [notification.userInfo objectForKey:@"key1"];
    NSString *key = [notification.userInfo objectForKey:@"key3"];
    NSDate *date = [notification.userInfo objectForKey:@"key2"];
    NSString *fre = [notification.userInfo objectForKey:@"key4"];
    
    bool everyday = ([key isEqualToString:@"YES"])?YES:NO;
    int frequency = [fre intValue];
    
    degreeOfThisAlarm = degree;
    AlarmViewController *alert = [[AlarmViewController alloc] init];
    self.window.rootViewController = alert;
    
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] cancelLocalNotification:note1];
    [[UIApplication sharedApplication] cancelLocalNotification:note2];
    [[UIApplication sharedApplication] cancelLocalNotification:note3];
    [[UIApplication sharedApplication] cancelLocalNotification:note4];
    
    if (everyday == YES) {
        
        nota1 = [[UILocalNotification alloc] init];
        nota1.soundName = @"littlestar.wav";
        nota1.alertBody = @"Wake up me!";
        nota1.fireDate = [NSDate dateWithTimeInterval: 1 * 60 * frequency * 24 * 60 * 60 sinceDate:date];
        nota1.userInfo = notification.userInfo;
        [[UIApplication sharedApplication] scheduleLocalNotification: nota1];
        
        nota2 = [[UILocalNotification alloc] init];
        nota2.soundName = @"littlestar.wav";
        nota2.alertBody = @"Wake up me!";
        nota2.fireDate = [NSDate dateWithTimeInterval: 2 * 60 * frequency * 24 * 60 * 60 sinceDate:date];
        nota2.userInfo = notification.userInfo;
        [[UIApplication sharedApplication] scheduleLocalNotification: nota2];
        
        nota3 = [[UILocalNotification alloc] init];
        nota3.soundName = @"littlestar.wav";
        nota3.alertBody = @"Wake up me!";
        nota3.fireDate = [NSDate dateWithTimeInterval: 3 * 60 * frequency * 24 * 60 * 60 sinceDate:date];
        nota3.userInfo = notification.userInfo;
        [[UIApplication sharedApplication] scheduleLocalNotification: nota3];
        
        nota4 = [[UILocalNotification alloc] init];
        nota4.soundName = @"littlestar.wav";
        nota4.alertBody = @"Wake up me!";
        nota4.fireDate = [NSDate dateWithTimeInterval: 4 * 60 * frequency * 24 * 60 * 60 sinceDate:date];
        nota4.userInfo = notification.userInfo;
        [[UIApplication sharedApplication] scheduleLocalNotification: nota4];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
        if ([alarmIsOverOrNot isEqualToNumber:[NSNumber numberWithInt:1]]){
            ListViewController *listViewController = [[ListViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc]
                                                     initWithRootViewController:listViewController];
            self.window.rootViewController = navController;
        }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
