//
//  WeatherServiece.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 25..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "VWAWeatherManager.h"

@implementation VWAWeatherManager
+ (VWAWeatherManager *)sharedInstance
{
    static VWAWeatherManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VWAWeatherManager alloc] init];
    });
    return sharedInstance;
}


- (void)currentWeatherByCityName:(NSString *)name
                   withCallback:(void (^)(NSError* error, NSDictionary *result))callback
{
    NSString *method = [NSString stringWithFormat:@"/weather?q=%@&units=metric", name];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", @"http://api.openweathermap.org/data/2.5", method];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (error) {
            NSLog(@"error : %@", error);
            [self currentWeatherByCityName:name withCallback:callback];
        } else {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"error : %@", error);
                [self currentWeatherByCityName:name withCallback:callback];
            } else {
                NSLog(@"json %@", json);
                callback(error, [self weatherInfo:json]);
            }
        }
    }];
}

- (void)currentWeatherByCoordinate:(CLLocationCoordinate2D)coordinate withCallback:(void (^)(NSError *error, NSDictionary *result))callback
{
    NSString *method = [NSString stringWithFormat:@"/weather?lat=%f&lon=%f&units=metric",
                        coordinate.latitude, coordinate.longitude ];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", @"http://api.openweathermap.org/data/2.5", method];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (error) {
            NSLog(@"error : %@", error);
            [self currentWeatherByCoordinate:coordinate withCallback:callback];
        } else {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"error : %@", error);
                [self currentWeatherByCoordinate:coordinate withCallback:callback];
            } else {
                NSLog(@"json %@", json);
                callback(error, [self weatherInfo:json]);
            }
        }
    }];
}

- (void)forecastWeatherByCoordinate:(CLLocationCoordinate2D)coordinate
                       withCallback:(void (^)( NSError* error, NSArray *results) )callback
{
    
    NSString *method = [NSString stringWithFormat:@"/forecast?lat=%f&lon=%f&units=metric",
                        coordinate.latitude, coordinate.longitude];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", @"http://api.openweathermap.org/data/2.5", method];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (error) {
            NSLog(@"error : %@", error);
            [self forecastWeatherByCoordinate:coordinate withCallback:callback];
        } else {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"error : %@", error);
                [self forecastWeatherByCoordinate:coordinate withCallback:callback];
            } else {
                NSLog(@"json %@", json);
                callback(error, [self forecastsWithInfo:json]);
            }
        }
    }];
}

- (void)currentWeatherByCityId:(NSString *)cityId
                  withCallback:(void (^)( NSError* error, NSDictionary *result ) )callback
{
    NSString *method = [NSString stringWithFormat:@"/weather?id=%@&units=metric", cityId];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", @"http://api.openweathermap.org/data/2.5", method];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (error) {
            NSLog(@"error : %@", error);
            [self currentWeatherByCityId:cityId withCallback:callback];
        } else {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"error : %@", error);
                [self currentWeatherByCityId:cityId withCallback:callback];
            } else {
                NSLog(@"json %@", json);
                callback(error, [self weatherInfo:json]);
            }
        }
    }];
}

- (NSDictionary *)weatherInfo:(NSDictionary *)result
{
    if (!result) return nil;
    NSString *cityName = [NSString stringWithFormat:@"%@, %@",
                          result[@"name"],
                          result[@"sys"][@"country"]
                          ];
    
    NSString *temp = [NSString stringWithFormat:@"%.1f℃",
                      [result[@"main"][@"temp"] floatValue] ];
    NSString *temp_min = [NSString stringWithFormat:@"%.1f℃",
                          [result[@"main"][@"temp_min"] floatValue] ];
    NSString *temp_max = [NSString stringWithFormat:@"%.1f℃",
                          [result[@"main"][@"temp_max"] floatValue] ];
    NSDictionary *weather = [(NSArray *)result[@"weather"] firstObject];
    
    NSDictionary *weatherInfo = @{WEATHER_CITY_NAME_KEY : cityName, WEATHER_TEMP_CURRENT_KEY : temp, WEATHER_TEMP_MIN_KEY : temp_min, WEATHER_TEMP_MAX_KEY : temp_max, WEATHER_KEY : weather};
    NSLog(@"******************weahterInfo******************");
    NSLog(@"%@", weatherInfo);
    return weatherInfo;
}

- (NSArray *)forecastsWithInfo:(NSDictionary *)result
{
    if (!result || !result[@"list"]) return nil;
    
    NSMutableArray *forecasts = [NSMutableArray array];
    for (id item in result[@"list"]) {
        NSString *date = [NSString stringWithFormat:@"%@", item[@"dt_txt"]];
        NSString *temp = [NSString stringWithFormat:@"%.1f℃",
                          [item[@"main"][@"temp"] floatValue] ];
        NSDictionary *weather = [(NSArray *)item[@"weather"] firstObject];
        NSDictionary *weatherInfo = @{WEATHER_TEMP_DATE_KEY : date, WEATHER_TEMP_CURRENT_KEY : temp, WEATHER_KEY : weather};
        [forecasts addObject:weatherInfo];
    }
    return (NSArray *)forecasts;
}
@end
