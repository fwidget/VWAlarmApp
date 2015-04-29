//
//  G2DateManager.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Extras.h"

@interface G2DateManager : NSObject
+ (G2DateManager *)sharedInstance;
+ (NSString *)yyyyMMddHHmmssFromNow;
+ (NSString *)timeStrFromDate:(NSDate *)date;
+ (NSArray*)oneWeekDateWithEnableWeekdayType:(G2WeekdayType)type date:(NSDate *)date;
+ (NSString *)strFromDate:(NSDate *)date format:(NSString *)format;
+ (NSString *)strWeekdayFromDate:(NSDate *)date localeIdentifier:(NSString *)localeIdentifier; // 요일 리턴
@end
