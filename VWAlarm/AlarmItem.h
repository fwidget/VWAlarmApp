//
//  AlarmItem.h
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 2..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmItem : NSObject
@property (strong, nonatomic) NSString *alarmId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *date;         // "2015-05-02 10:05:14 +0000";
@property (strong, nonatomic) NSArray *repeatTimes; // 월~일 매일
@property (nonatomic) BOOL snoose;     // 반복 5분, 10분, 30분
@property (strong, nonatomic) NSArray *soundFiles;  // 설정 시간에 따른 재생 목록 리스트
@property (strong, nonatomic) NSDate *createDate;   // 생성 일자
@property (strong, nonatomic) NSDate *updateDate;   // 수정 일자
@end
