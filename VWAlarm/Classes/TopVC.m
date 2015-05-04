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
#import "ForecastCell.h"

@interface TopVC ()

@end

@implementation TopVC
{
    BOOL _initLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNowDate];
    [self initClock];
    [self initWeatherInfo];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateClock];
}

- (void)initClock
{
    _clockView.delegate = self;
    _clockView.realTime = YES;
    _clockView.currentTime = YES;
    _clockView.enableDigit = YES;
    _clockView.faceBackgroundAlpha = 0.0;
    _clockView.faceBackgroundColor = [UIColor clearColor];
}

- (void)updateClock
{
    [_clockView updateTimeAnimated:YES];
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
    if (_initLocation) return;
    _initLocation = YES;
    CLLocation *location = locations.lastObject;
    
    // 화면 설정
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 지역명 설정
        [self localNameWithCoordinate:location.coordinate];
        // 날씨 정보 설정
        [self currentWatherByCoordinate:location.coordinate];
        // 시간별 날씨 정보
        [self forecastWeatherByCoordinate:location.coordinate];
    });
    
    
    NSLog(@"latitude : %+.6f", location.coordinate.latitude);
    NSLog(@"longitude : %+.6f", location.coordinate.longitude);
    [_locationManager stopUpdatingLocation];
}

- (void)forecastWeatherByCoordinate:(CLLocationCoordinate2D)coordinate
{
    [_dayWeatherIndicatorView startAnimating];
    VWAWeatherManager *weatherManager = [[VWAWeatherManager alloc] init];
    [weatherManager forecastWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSArray *results){
        [_dayWeatherIndicatorView stopAnimating];
        if (error || !results) {
            NSLog(@"error : %@\nresult : %@", error, results);
            return;
        }
        _forecasts = results;
        [_collectionView reloadData];
    }];
}

- (void)currentWatherByCoordinate:(CLLocationCoordinate2D)coordinate
{
    [_currentWeatherIndicatorView startAnimating];
    VWAWeatherManager *weatherManager = [[VWAWeatherManager alloc] init];
    [weatherManager currentWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSDictionary *result){
        [_currentWeatherIndicatorView stopAnimating];
        [SVProgressHUD dismiss];
        if (error || !result) {
            NSLog(@"error : %@\nresult : %@", error, result);
            return;
        }
        if (result[WEATHER_KEY]) {
            NSInteger weatherId = [result[WEATHER_KEY][@"id"] integerValue];
            BOOL nightTime = [self isNightTimeOfIcon:result[WEATHER_KEY][@"icon"]];
            _weatherImageView.image = [self weatherImageWithWeatherId:weatherId nightTime:nightTime];
            _tempCurrrentLb.text = [NSString stringWithFormat:@"%.1f%@", [result[WEATHER_TEMP_CURRENT_KEY] floatValue], LSTR(@"度")];
            _tempMaxLb.text = [NSString stringWithFormat:@"%@ : %.1f%@", LSTR(@"最高"), [result[WEATHER_TEMP_MAX_KEY] floatValue], LSTR(@"度")];
            _tempMinLb.text = [NSString stringWithFormat:@"%@ : %.1f%@", LSTR(@"最低"), [result[WEATHER_TEMP_MIN_KEY] floatValue], LSTR(@"度")];
        }
    }];
}

- (void)localNameWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    [_localIndicatorView startAnimating];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        [_localIndicatorView stopAnimating];
        if(error) {
            NSLog(@"error");
        } else {
            if (placemarks.count > 0) {
                CLPlacemark *placemark = placemarks.firstObject;
                NSLog(@"address:%@%@%@%@%@", placemark.country, placemark.administrativeArea, placemark.locality, placemark.thoroughfare, placemark.subThoroughfare);
                _localLb.text = [NSString stringWithFormat:@"%@", placemark.locality];
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError.");
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _forecasts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ForecastCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.item = _forecasts[indexPath.row];
    [self configurationCell:cell id:_forecasts[indexPath.row]];
    return cell;
}

- (void)configurationCell:(ForecastCell *)cell id:(id)item
{
    if (item[WEATHER_KEY]) {
        NSInteger weatherId = [item[WEATHER_KEY][@"id"] integerValue];
        BOOL nightTime = [self isNightTimeOfIcon:item[WEATHER_KEY][@"icon"]];
        cell.imageView.image = [self weatherImageWithWeatherId:weatherId nightTime:nightTime];
        NSDate *converDate = [G2DateManager dateFromStr:item[WEATHER_TEMP_DATE_KEY] format:@"yyyy-MM-dd HH:mm:ss"];
        NSString *date = [G2DateManager timeStrFromDate:converDate];
        NSString *time = [NSString stringWithFormat:@"%@", [date substringWithRange:NSMakeRange(0, 2)]];
        cell.label.text = [NSString stringWithFormat:@"%@/%.1f%@", time, [item[WEATHER_TEMP_CURRENT_KEY] floatValue], LSTR(@"度")];
    }
}



#pragma mark - WeatherServieceDelegate
- (void)weatherInfo:(NSDictionary *)info
{
    if (!info) {
        return;
    }
    if ((info[WEATHER_KEY])) {
        NSInteger weatherId = [info[WEATHER_KEY][@"id"] integerValue];
        BOOL nightTime = [self isNightTimeOfIcon:info[WEATHER_KEY][@"icon"]];
        _weatherImageView.image = [self weatherImageWithWeatherId:weatherId nightTime:nightTime];
        _tempCurrrentLb.text = [NSString stringWithFormat:@"%.1f%@", [info[WEATHER_TEMP_CURRENT_KEY] floatValue], LSTR(@"度")];
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
