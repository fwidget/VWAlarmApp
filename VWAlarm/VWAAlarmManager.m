//
//  VWAManager.m
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 2..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "VWAAlarmManager.h"
#import "VWAWeatherManager.h"
#import "Alarm.h"

#define LOCAL_NOTIFICATION_USERINFO_KEY_ALARMS          @"alarms"

@implementation VWAAlarmManager
+ (void)addAlarmScheduleLocalNotificationWithItem:(Alarm *)item
{
    UILocalNotification *noti;
    if (item.repeatTimes.count > 0) {
        noti = [G2NotificationManager localNotificationWithFireDate:item.date timeZone:nil alertTitle:nil alertBody:item.title alertAction:LSTR(@"スヌース") repeatIntervalUnit:NSCalendarUnitWeekOfMonth];
    } else {
        noti = [G2NotificationManager localNotificationWithFireDate:item.date timeZone:nil alertTitle:nil alertBody:item.title alertAction:LSTR(@"スヌース")];
    }
    noti.userInfo = @{@"soundFiles" : item.soundFiles};
    [G2NotificationManager addScheduleLocalNotification:noti];
}

+ (void)updateAlarmScheduleLocalNotificationWithItem:(Alarm *)item
{
    [self cancelAlarmScheduleLocalNotificationWithItem:item];
    [self addAlarmScheduleLocalNotificationWithItem:item];
}

+ (void)cancelAlarmScheduleLocalNotificationWithItem:(Alarm *)item
{
    [G2NotificationManager cancelLocalNotificationKey:LOCAL_NOTIFICATION_USERINFO_KEY_ALARMS cancelId:item.indexId];
}

+ (void)didReceiveLocalNotification:(UILocalNotification *)noti applicationState:(UIApplicationState)state
{
    if (state == UIApplicationStateActive) {
        [[G2SoundManager sharedInstance] playSoundFileNames:noti.userInfo[@"soundFiles"]];
        //TODO:날씨 정보 가져오기
        NSLog(@"%@", @"");
    }
    if (state == UIApplicationStateInactive) {
    }
     
    [[UIApplication sharedApplication] cancelLocalNotification:noti];
}

@end
