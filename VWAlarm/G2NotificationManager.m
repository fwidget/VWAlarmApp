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
// alarm용
+ (void)addAlarmScheduleLocalNotificationWithDates:(NSArray *)dates alarmId:(NSString *)alarmId repeat:(BOOL)repeat
{
    // alarm  :   NSCalendarUnitWeekOfMonth
    for (NSDate *date in dates) {
        UILocalNotification *noti = [self localNotificationWithFireDate:date timeZone:[NSTimeZone localTimeZone] alertTitle:@"" alertBody:@"" alertAction:@""];
        if (repeat) {
            noti = [self localNotificationOfRepeatIntervalUnit:NSCalendarUnitWeekOfMonth notification:noti];
        }
        if (alarmId && alarmId.length > 0) {
            [noti.userInfo setValue:alarmId forKey:LOCAL_NOTIFICATION_USERINFO_KEY_ALARMS];
        }
        [self addScheduleLocalNotification:noti];
    }
}

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
            if (cancelId && cancelId.length > 0 && [noti.userInfo[key] isEqualToString:cancelId]) {
                [[UIApplication sharedApplication] cancelLocalNotification:noti];
            } else {
                [[UIApplication sharedApplication] cancelLocalNotification:noti];
            }
        }
    }
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
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

+ (void)didReceiveLocalNotification:(UILocalNotification *)noti applicationState:(UIApplicationState)state
{
    if (state == UIApplicationStateActive) {
        
    }
    
    if (state == UIApplicationStateInactive) {
        
    }
    
    [[UIApplication sharedApplication] cancelLocalNotification:noti];
}

+ (UILocalNotification *)localNotificationWithFireDate:(NSDate *)date timeZone:(NSTimeZone *)timeZone alertTitle:(NSString *)alertTitle alertBody:(NSString *)alertBody alertAction:(NSString *)alertAction
{
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    noti.fireDate = date;
    noti.timeZone = (timeZone) ? timeZone : [NSTimeZone localTimeZone];
    noti.alertTitle = alertTitle;
    noti.alertBody = alertBody;
    noti.alertAction = alertAction;
    noti.soundName = UILocalNotificationDefaultSoundName;
    return noti;
}

+ (UILocalNotification *)localNotificationOfRepeatIntervalUnit:(NSCalendarUnit)repeatIntervalUnit notification:(UILocalNotification *)noti;
{
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
