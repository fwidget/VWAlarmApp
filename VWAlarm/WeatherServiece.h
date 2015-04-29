//
//  WeatherServiece.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 25..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWMWeatherAPI.h"

@protocol WeatherServieceDelegate <NSObject>
- (void)weatherInfo:(NSDictionary *)info;
@end

@interface WeatherServiece : NSObject <CLLocationManagerDelegate>
+ (WeatherServiece *)sharedInstance;
@property (nonatomic) NSInteger apiKey;
@property (strong, nonatomic) OWMWeatherAPI *weatherAPI;
@property (strong, nonatomic) NSDictionary *weatherInfo;
@property (weak, nonatomic) id<WeatherServieceDelegate> deleage;


// 위도, 경도로 날씨 정보를 취득
-(void)currentWeatherByCoordinate:(CLLocationCoordinate2D) coordinate
                     withCallback:( void (^)( NSError* error, NSDictionary *result ) )callback;
// 도시 이름으로 날씨 정보 취득
-(void)currentWeatherByCityName:(NSString *)name
                   withCallback:(void (^)(NSError* error, NSDictionary *result))callback;
// 도시 아이디로 날씨 정보 취득
-(void)currentWeatherByCityId:(NSString *) cityId
                 withCallback:( void (^)( NSError* error, NSDictionary *result ) )callback;
@end
