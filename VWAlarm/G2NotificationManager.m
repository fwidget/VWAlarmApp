//
//  G2NotificationManager.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 16..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "G2NotificationManager.h"

@implementation G2NotificationManager
+ (G2NotificationManager *)sharedInstance
{
    static dispatch_once_t pred;
    static G2NotificationManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });  
    return sharedInstance;
}


#pragma mark - public method
+ (void)addScheduleLocalNotification:(UILocalNotification *)noti
{
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
}

+ (void)cancelLocalNotificationKey:(NSString *)key
{
    [self cancelLocalNotificationKey:key cancelId:nil];
}

+ (void)cancelLocalNotificationKey:(NSString *)key cancelId:(NSString *)cancelId
{
    NSArray *notifications = [self localNotifications];
    for (UILocalNotification *noti in notifications) {
        if (noti.userInfo[key]) {
            if (cancelId && cancelId.length > 0 && noti.userInfo[key]) {
                [[UIApplication sharedApplication] cancelLocalNotification:noti];
            }
        }
    }
}

+ (void)cancelAllLocalNotification
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

+ (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UILocalNotification *noti = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (noti) {
        
        [self cancelLocalNotification:noti];
    }
}

+ (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions application:(UIApplication *)application
{
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    [self didFinishLaunchingWithOptions:launchOptions];
}

+ (void)didReceiveLocalNotification:(UILocalNotification *)noti applicationState:(UIApplicationState)state
{
    [VWAAlarmManager didReceiveLocalNotification:noti applicationState:state];
    
    if (state == UIApplicationStateActive) {
        [VWAAlarmManager simpleAlertMessage:@"UIApplicationStateActive"];
    }
    
    if (state == UIApplicationStateInactive) {
        [VWAAlarmManager simpleAlertMessage:@"UIApplicationStateInactive"];
    }
    
    [[UIApplication sharedApplication] cancelLocalNotification:noti];
}

+ (UILocalNotification *)localNotificationWithFireDate:(NSDate *)date timeZone:(NSTimeZone *)timeZone alertTitle:(NSString *)alertTitle alertBody:(NSString *)alertBody alertAction:(NSString *)alertAction
{
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    noti.fireDate = date;
    noti.timeZone = [NSTimeZone localTimeZone];
    noti.alertTitle = alertTitle;
    noti.alertBody = alertBody;
    noti.alertAction = alertAction;
    noti.soundName = UILocalNotificationDefaultSoundName;
    return noti;
}

+ (UILocalNotification *)localNotificationWithFireDate:(NSDate *)date timeZone:(NSTimeZone *)timeZone alertTitle:(NSString *)alertTitle alertBody:(NSString *)alertBody alertAction:(NSString *)alertAction repeatIntervalUnit:(NSCalendarUnit)repeatIntervalUnit
{
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    noti.fireDate = date;
    noti.timeZone = (timeZone) ? timeZone : [NSTimeZone localTimeZone];
    noti.alertTitle = alertTitle;
    noti.alertBody = alertBody;
    noti.alertAction = alertAction;
    noti.soundName = UILocalNotificationDefaultSoundName;
    noti.repeatCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    noti.repeatInterval = repeatIntervalUnit;
    return noti;
}

#pragma mark - private method
+ (NSArray *)localNotifications
{
    return [[UIApplication sharedApplication] scheduledLocalNotifications];
}

+ (void)cancelLocalNotification:(UILocalNotification *)notification{
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
}
@end
