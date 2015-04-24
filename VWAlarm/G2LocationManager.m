//
//  G2LocationManager.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 25..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "G2LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@implementation G2LocationManager
+ (G2LocationManager *)sharedInstance
{
    static G2LocationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[G2LocationManager alloc] init];
    });
    return sharedInstance;
}

- (void)startup
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        // iOS 8.0
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationManager requestAlwaysAuthorization];
        } else {
            [_locationManager startUpdatingLocation];
        }
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations.lastObject;
    NSLog(@"latitude : %+.6f", location.coordinate.latitude);
    NSLog(@"longitude : %+.6f", location.coordinate.longitude);
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager startUpdatingLocation];
    }
}

@end
