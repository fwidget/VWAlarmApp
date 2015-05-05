//
//  WeatherServiece.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 25..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APIKeys @[@"b679f6c90a21d8c40513078a40bc19b8", @"b679f6c90a21d8c40513078a40bc19b8", @"b679f6c90a21d8c40513078a40bc19b8"]

// server url
#define WEATHER_API                       @"http://api.openweathermap.org/data/2.5"

// paramters key
#define WEATHER_KEY                       @"weather"
#define WEATHER_CITY_NAME_KEY             @"cityName"
#define WEATHER_TEMP_CURRENT_KEY          @"temp"
#define WEATHER_TEMP_MIN_KEY              @"temp_min"
#define WEATHER_TEMP_MAX_KEY              @"temp_max"
#define WEATHER_TEMP_DATE_KEY             @"dt_txt"

@interface VWAWeatherManager : NSObject <CLLocationManagerDelegate>
+ (VWAWeatherManager *)sharedInstance;
@property (nonatomic) NSInteger apiKeyIndex;


// 위도, 경도로 날씨 정보를 취득
- (void)currentWeatherByCoordinate:(CLLocationCoordinate2D)coordinate
                     withCallback:(void (^)(NSError* error, NSDictionary *result))callback;
// 도시 이름으로 날씨 정보 취득
- (void)currentWeatherByCityName:(NSString *)name
                   withCallback:(void (^)(NSError* error, NSDictionary *result))callback;
// 도시 아이디로 날씨 정보 취득
- (void)currentWeatherByCityId:(NSString *)cityId
                 withCallback:(void (^)(NSError* error, NSDictionary *result))callback;
// 위도, 경도로 시간별 날씨 정보를 취득
- (void)forecastWeatherByCoordinate:(CLLocationCoordinate2D)coordinate
                              withCallback:(void (^)( NSError* error, NSArray *results))callback;

- (NSDictionary *)weatherInfo:(NSDictionary *)result;
@end
