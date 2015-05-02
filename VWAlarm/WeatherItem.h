//
//  WeatherItem.h
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 2..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherItem : NSObject
@property (strong, nonatomic) NSString *weatherId;
@property (strong, nonatomic) NSString *cityName;     // 도시 이름
@property (strong, nonatomic) NSString *currentTemp;  // 현재 기온
@property (strong, nonatomic) NSString *minTemp;      // 최저 기온
@property (strong, nonatomic) NSString *maxTemp;      // 최고 기온
@property (strong, nonatomic) NSString *weatherInfo;  // 날씨 정보
@property (strong, nonatomic) NSDate *createDate;     // 등록 일자
@property (strong, nonatomic) NSDate *updateDate;     // 데이터 갱신 일자(=날씨 정보 취득 일자)
@end
