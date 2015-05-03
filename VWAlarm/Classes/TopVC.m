//
//  FirstViewController.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "TopVC.h"
#import "VWAWeatherManager.h"
#import <CoreLocation/CoreLocation.h>

@interface TopVC () <WeatherServieceDelegate>

@end

@implementation TopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNowDate];
    [self initWeatherInfo];
    
}

- (void)initWeatherInfo
{
    [self startLocation];
}

- (void)initNowDate
{
    NSDate *date = [NSDate date];
    NSString *now = [G2DateManager strFromDate:date format:@"yyyy.MM.dd"];
    NSString *weekday = [G2DateManager strWeekdayFromDate:date localeIdentifier:@"ja"];
    _nowDateLb.text = [NSString stringWithFormat:@"%@ %@", now, weekday];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)startLocation
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    _locationManager.delegate = self;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"Location services is unauthorized.");
    } else {
        // iOS 8.0
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationManager requestAlwaysAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations.lastObject;
    // 지역명 설정
    [self localNameWithCoordinate:location.coordinate];

    // 날씨 정보 설정
    VWAWeatherManager *weatherService = [[VWAWeatherManager alloc] init];
    weatherService.deleage = self;
    [weatherService currentWeatherByCoordinate:location.coordinate withCallback:nil];
    
    NSLog(@"latitude : %+.6f", location.coordinate.latitude);
    NSLog(@"longitude : %+.6f", location.coordinate.longitude);
    [_locationManager stopUpdatingLocation];
}

- (void)localNameWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error) {
            NSLog(@"error");
        } else {
            if (placemarks.count > 0) {
                CLPlacemark *placemark = placemarks.firstObject;
                NSLog(@"address:%@%@%@%@%@", placemark.country, placemark.administrativeArea, placemark.locality, placemark.thoroughfare, placemark.subThoroughfare);
                _localLb.text = [NSString stringWithFormat:@"%@", placemark.administrativeArea];
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError.");
}




#pragma mark - WeatherServieceDelegate
- (void)weatherInfo:(NSDictionary *)info
{
    if (!info) {
        return;
    }
    if ((info[@"weather"])) {
        NSInteger weatherId = [info[@"weather"][@"id"] integerValue];
        BOOL nightTime = [self isNightTimeOfIcon:info[@"weather"][@"icon"]];
        _weatherImageView.image = [self weatherImageWithWeatherId:weatherId nightTime:nightTime];
        _temperatureLb.text = [NSString stringWithFormat:@"%.1f%@", [info[@"currentTemp"] floatValue], LSTR(@"度")];
    }
}

- (UIImage *)weatherImageWithWeatherId:(NSInteger)condition nightTime:(BOOL)nightTime
{
    // Thunderstorm
    if (condition < 300) {
        return (nightTime) ? [UIImage imageNamed:@"tstorm1_night"] : [UIImage imageNamed:@"tstorm1"];
    }
    // Drizzle
    else if (condition < 500) {
        return [UIImage imageNamed:@"light_rain"];
    }
    // Rain / Freezing rain / Shower rain
    else if (condition < 600) {
        return [UIImage imageNamed:@"shower3"];
    }
    // Snow
    else if (condition < 700) {
        return [UIImage imageNamed:@"snow4"];
    }
    // Fog / Mist / Haze / etc.
    else if (condition < 771) {
        return (nightTime) ? [UIImage imageNamed:@"fog_night"] : [UIImage imageNamed:@"fog"];
    }
    // Tornado / Squalls
    else if (condition < 800) {
        return [UIImage imageNamed:@"tstorm3"];
    }
    // Sky is clear
    else if (condition == 800) {
        return (nightTime) ? [UIImage imageNamed:@"sunny_night"] : [UIImage imageNamed:@"sunny"];
    }
    // few / scattered / broken clouds
    else if (condition < 804) {
        return (nightTime) ? [UIImage imageNamed:@"cloudy2_night"] : [UIImage imageNamed:@"cloudy2"];
    }
    // overcast clouds
    else if (condition == 804) {
        return [UIImage imageNamed:@"overcast"];
    }
    // Extreme
    else if ((condition >= 900 && condition < 903) || (condition > 904 && condition < 1000)) {
        return [UIImage imageNamed:@"tstorm3"];
    }
    // Cold
    else if (condition == 903) {
        return [UIImage imageNamed:@"snow5"];
    }
    // Hot
    else if (condition == 904) {
        return [UIImage imageNamed:@"sunny"];
    }
    // Weather condition is not available
    else {
        return [UIImage imageNamed:@"dunno"];
    }
}

- (BOOL)isNightTimeOfIcon:(NSString *)icon
{
    return [icon hasPrefix:@"n"];
}
@end
