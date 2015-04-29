//
//  G2DateManager.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "G2DateManager.h"
#import "NSDate+Extras.h"

@implementation G2DateManager
+ (G2DateManager *)sharedInstance
{
    static G2DateManager *sharedInstance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedInstance = [[G2DateManager alloc] init];
    });
    return sharedInstance;
}

+ (NSString *)yyyyMMddHHmmssFromNow
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [df stringFromDate:[NSDate date]];
    return str;
}

+ (NSString *)timeStrFromDate:(NSDate *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    NSString *str = [df stringFromDate:date];
    return str;
}

+ (NSString *)strFromDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    NSString *str = [df stringFromDate:date];
    return str;
    
}

+ (NSArray*)oneWeekDateWithEnableWeekdayType:(G2WeekdayType)type date:(NSDate *)date
{
    return [date oneWeekDateWithEnableWeekdayType:type];
}

+ (NSString *)strWeekdayFromDate:(NSDate *)date localeIdentifier:(NSString *)localeIdentifier
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* comps = [calendar components:NSCalendarUnitWeekday
                                          fromDate:date];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    
    NSString* weekDayStr = df.shortWeekdaySymbols[comps.weekday-1];
    return weekDayStr;
}


@end
