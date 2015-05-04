//
//  VWAManager.h
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 2..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarm.h"

@interface VWAAlarmManager : NSObject
+ (void)addAlarmScheduleLocalNotificationWithItem:(Alarm *)item;
+ (void)updateAlarmScheduleLocalNotificationWithItem:(Alarm *)item;
+ (void)cancelAlarmScheduleLocalNotificationWithItem:(Alarm *)item;
+ (void)simpleAlertMessage:(NSString *)msg;
+ (void)didReceiveLocalNotification:(UILocalNotification *)noti applicationState:(UIApplicationState)state;
@end

