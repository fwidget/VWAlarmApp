//
//  VWAManager.m
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 2..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "VWAAlarmManager.h"
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
    [noti.userInfo setValue:item forKey:item.indexId];
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

+ (void)simpleAlertMessage:(NSString *)msg;
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:LSTR(@"確認") otherButtonTitles:nil];
    [alert show];
}
@end
