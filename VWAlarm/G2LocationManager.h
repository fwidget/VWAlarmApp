//
//  G2LocationManager.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 25..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface G2LocationManager : NSObject < CLLocationManagerDelegate >
@property (strong, nonatomic) CLLocationManager *locationManager;
+ (G2LocationManager *)sharedInstance;
- (void)startup;
@end
