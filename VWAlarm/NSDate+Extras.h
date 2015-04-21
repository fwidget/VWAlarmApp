//
//  NSDate+Extras.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 17..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    G2WeekdayTypeSunday     = 1 << 0,
    G2WeekdayTypeMonday     = 1 << 1,
    G2WeekdayTypeTuesday    = 1 << 2,
    G2WeekdayTypeWednesday  = 1 << 3,
    G2WeekdayTypeThursday   = 1 << 4,
    G2WeekdayTypeFriday     = 1 << 5,
    G2WeekdayTypeSaturday   = 1 << 6,
}G2WeekdayType;

@interface NSDate (Extras)
- (NSDateComponents*)dateAndTimeComponents;
- (NSArray*)oneWeekDateWithEnableWeekdayType:(G2WeekdayType)type;
@end
