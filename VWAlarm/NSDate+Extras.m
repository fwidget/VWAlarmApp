//
//  NSDate+Extras.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 17..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "NSDate+Extras.h"

@implementation NSDate (Extras)
- (NSDateComponents*)dateAndTimeComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self];
}

- (NSArray *)oneWeekDateWithEnableWeekdayType:(G2WeekdayType)type
{
    if (type == 0) {
        return nil;
    }
    // 현재부터 7일간
    NSUInteger oneWeekNum = 7;
    NSMutableDictionary *oneWeekDict = [NSMutableDictionary dictionaryWithCapacity:oneWeekNum];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    for (NSUInteger i = 0; i < oneWeekNum; i++) {
        NSDateComponents *comp = [self dateAndTimeComponents];
        [comp setDay:comp.day + i];
        NSDate *newDate = [cal dateFromComponents:comp];
        NSDateComponents * newComp = [newDate dateAndTimeComponents];
        [oneWeekDict setObject:newComp forKey:[NSString stringWithFormat:@"%ld", (long)newComp.weekday]];
    }
    
    // 일주일 데이터에서 type에 포함 하는 것만
    NSMutableArray *resultArr= [NSMutableArray array];
    G2WeekdayType compType = type;
    // weekday에서1〜7(日〜土)
    for (NSUInteger i = 1; i <= oneWeekNum; i++) {
        if (compType % 2 == 1) {
            NSDateComponents *comp = [oneWeekDict objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
            [resultArr addObject:[cal dateFromComponents:comp]];
        }
        compType >>= 1;
    }
    return resultArr;
}
@end
