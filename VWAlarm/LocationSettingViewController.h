//
//  LocationSettingViewController.h
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 5..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationSettingViewController : UIViewController < CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate, UIAlertViewDelegate >
@property (nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *currentLocationLb;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end
