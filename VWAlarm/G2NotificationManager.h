//
//  G2NotificationManager.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 16..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface G2NotificationManager : NSObject
@property (strong, nonatomic) UILocalNotification *notification;
+ (G2NotificationManager *)sharedInstance;

+ (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
+ (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions application:(UIApplication *)application;
+ (void)didReceiveLocalNotification:(UILocalNotification *)noti applicationState:(UIApplicationState)state;

+ (void)cancelLocalNotificationKey:(NSString *)key;
+ (void)cancelLocalNotificationKey:(NSString *)key cancelId:(NSString *)cancelId;
+ (void)cancelAllLocalNotification;

+ (void)addScheduleLocalNotification:(UILocalNotification *)noti;

+ (UILocalNotification *)localNotificationWithFireDate:(NSDate *)date timeZone:(NSTimeZone *)timeZone alertTitle:(NSString *)alertTitle alertBody:(NSString *)alertBody alertAction:(NSString *)alertAction;
+ (UILocalNotification *)localNotificationWithFireDate:(NSDate *)date timeZone:(NSTimeZone *)timeZone alertTitle:(NSString *)alertTitle alertBody:(NSString *)alertBody alertAction:(NSString *)alertAction repeatIntervalUnit:(NSCalendarUnit)repeatIntervalUnit;
@end
