//
//  FirstViewController.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TopVC : UIViewController <CLLocationManagerDelegate, BEMAnalogClockDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nowDateLb;
@property (weak, nonatomic) IBOutlet UILabel *localLb;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *localIndicatorView;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *tempCurrrentLb;
@property (weak, nonatomic) IBOutlet UILabel *tempMaxLb;
@property (weak, nonatomic) IBOutlet UILabel *tempMinLb;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *currentWeatherIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *weatherTimes;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *dayWeatherIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *clockView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *forecasts;
@end

