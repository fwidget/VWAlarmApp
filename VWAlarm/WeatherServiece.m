//
//  WeatherServiece.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 25..
//  Copyright (c) 2015년 vwa. All rights reserved.
//


#define APIKeys @[@"b679f6c90a21d8c40513078a40bc19b8", @"b679f6c90a21d8c40513078a40bc19b8", @"b679f6c90a21d8c40513078a40bc19b8"]

#import "WeatherServiece.h"

@implementation WeatherServiece
+ (WeatherServiece *)sharedInstance
{
    static WeatherServiece *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WeatherServiece alloc] init];
    });
    return sharedInstance;
}

- (void)setupWeatherService
{
    if (!_weatherAPI) {
        _apiKey = 0;
        _weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:APIKeys[_apiKey]];
    }
    [_weatherAPI setLangWithPreferedLanguage];
    [_weatherAPI setTemperatureFormat:kOWMTempCelcius];
}

- (void)changeAPIKey
{
    _apiKey = _apiKey+1;
    if (_apiKey >= APIKeys.count) {
        _apiKey = 0;
    }
    _weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:APIKeys[_apiKey]];
    [_weatherAPI setLangWithPreferedLanguage];
    [_weatherAPI setTemperatureFormat:kOWMTempCelcius];
}


-(void)currentWeatherByCityName:(NSString *)name
                   withCallback:(void (^)(NSError* error, NSDictionary *result))callback
{
    [self setupWeatherService];
    [_weatherAPI currentWeatherByCityName:name withCallback:^(NSError *error, NSDictionary *result) {
        if (error) {
            [self errorMessage:@"cityName" complete:^{
                [self currentWeatherByCityName:name withCallback:callback];
            }];
            return;
        }
        
        NSString *cityName = [NSString stringWithFormat:@"%@, %@",
                              result[@"name"],
                              result[@"sys"][@"country"]
                              ];
        
        NSString *currentTemp = [NSString stringWithFormat:@"%.1f℃",
                                 [result[@"main"][@"temp"] floatValue] ];
        NSString *minTemp = [NSString stringWithFormat:@"%.1f℃",
                             [result[@"main"][@"temp_min"] floatValue] ];
        NSString *maxTemp = [NSString stringWithFormat:@"%.1f℃",
                             [result[@"main"][@"temp_max"] floatValue] ];
        
        NSString *weather = result[@"weather"][0][@"description"];
        _weatherInfo = @{@"name" : cityName, @"currentTemp" : currentTemp, @"minTemp" : minTemp, @"maxTemp" : maxTemp, @"weather" : weather};
    }];
}

-(void)currentWeatherByCoordinate:(CLLocationCoordinate2D) coordinate
                      withCallback:( void (^)( NSError* error, NSDictionary *result ) )callback
{
    [self setupWeatherService];
    [_weatherAPI currentWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSDictionary *result) {
        if (error) {
            [self errorMessage:@"coordinate" complete:^{
                [self currentWeatherByCoordinate:coordinate withCallback:callback];
            }];
            return;
        }
        
        NSString *cityName = [NSString stringWithFormat:@"%@, %@",
                              result[@"name"],
                              result[@"sys"][@"country"]
                              ];
        
        NSString *currentTemp = [NSString stringWithFormat:@"%.1f℃",
                                 [result[@"main"][@"temp"] floatValue] ];
        NSString *minTemp = [NSString stringWithFormat:@"%.1f℃",
                             [result[@"main"][@"temp_min"] floatValue] ];
        NSString *maxTemp = [NSString stringWithFormat:@"%.1f℃",
                             [result[@"main"][@"temp_max"] floatValue] ];
        
        NSString *weather = result[@"weather"][0][@"description"];
        _weatherInfo = @{@"name" : cityName, @"currentTemp" : currentTemp, @"minTemp" : minTemp, @"maxTemp" : maxTemp, @"weather" : weather};
    }];
}

-(void)currentWeatherByCityId:(NSString *) cityId
                  withCallback:( void (^)( NSError* error, NSDictionary *result ) )callback
{
    [self setupWeatherService];
    [_weatherAPI currentWeatherByCityId:cityId withCallback:^(NSError *error, NSDictionary *result) {
        if (error) {
            [self errorMessage:@"cityId" complete:^{
                [self currentWeatherByCityId:cityId withCallback:callback];
            }];
            return;
        }
        
        NSString *cityName = [NSString stringWithFormat:@"%@, %@",
                              result[@"name"],
                              result[@"sys"][@"country"]
                              ];
        
        NSString *currentTemp = [NSString stringWithFormat:@"%.1f℃",
                                 [result[@"main"][@"temp"] floatValue] ];
        NSString *minTemp = [NSString stringWithFormat:@"%.1f℃",
                             [result[@"main"][@"temp_min"] floatValue] ];
        NSString *maxTemp = [NSString stringWithFormat:@"%.1f℃",
                             [result[@"main"][@"temp_max"] floatValue] ];
        
        NSString *weather = result[@"weather"][0][@"description"];
        _weatherInfo = @{@"name" : cityName, @"currentTemp" : currentTemp, @"minTemp" : minTemp, @"maxTemp" : maxTemp, @"weather" : weather};
    }];
}


- (void)errorMessage:(NSString *)msg complete:(void(^)(void))complete
{
    NSLog(@"msg : %@", msg);
    [self changeAPIKey];
    if (complete) {
        complete();
    }
}

- (NSDictionary *)getWeatherInfo
{
    return _weatherInfo;
}

@end
