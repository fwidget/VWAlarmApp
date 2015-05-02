//
//  AlarmItem.m
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 2..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "AlarmItem.h"
@implementation AlarmItem
- (id)init
{
    self = [super init];
    if (self) {
        _alarmId = @"";
        _title = @"";
        _date = [NSDate date];
        _repeatTimes = [NSArray array];
        _snoose = NO;
        _soundFiles = [NSArray array];
        _createDate = [NSDate date];
        _updateDate = [NSDate date];
    }
    return self;
}
@end
