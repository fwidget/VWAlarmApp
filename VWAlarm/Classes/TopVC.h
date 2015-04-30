//
//  FirstViewController.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TopVC : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nowDateLb;
@property (weak, nonatomic) IBOutlet UILabel *localLb;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLb;
@property (nonatomic) CLLocationManager *locationManager;
@end

