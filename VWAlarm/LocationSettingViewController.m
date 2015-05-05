//
//  LocationSettingViewController.m
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 5..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "LocationSettingViewController.h"
#define LOCATION_STR(str) [NSString stringWithFormat:@"%@ : %@", LSTR(@"現在設定エリア"),str]

@implementation LocationSettingViewController
{
    BOOL _initLocation; //YES：설정 완료 NO：미설정
    MKPointAnnotation *_currentAnnotation;
}

- (id)init {
    if (self = [super init]) {
        _initLocation = NO;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        //ユーザーはこのアプリによる位置情報サービスの利用を許可していない、または「設定」で無効にしている
        NSLog(@"Location services is unauthorized.");
    }
    else {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        // 권한 요구
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            [_locationManager requestWhenInUseAuthorization];
        }
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.distanceFilter = 100.0;
        
        [_locationManager startUpdatingLocation];
    }
    
    _mapView.mapType = MKMapTypeStandard;
    _mapView.rotateEnabled = NO;
    _mapView.showsUserLocation = NO;
    
    
    // 초기 설정
    NSDictionary *locationDic = USERDEFAULTS_GET_KEY(LOCATION_KEY);
    // 위치 데이터가 있으면
    if (locationDic) {
        CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake([locationDic[LOCATION_KEY_LATI] floatValue], [locationDic[LOCATION_KEY_LONGI] floatValue]);
        MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(0.1, 0.1); // 숫자가 작으면 확대 배율이 커짐
        MKCoordinateRegion newRegion = MKCoordinateRegionMake(centerCoordinate, coordinateSpan);
        [_mapView setRegion:newRegion animated:YES];
        [self localSearchStr:locationDic[LOCATION_KEY_NAME]];
        _button.enabled = NO;
        _initLocation = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showCurrentLocation:(id)sender
{
    [_locationManager startUpdatingLocation];
}

- (IBAction)showSettingAlert:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LSTR(@"確認") message:LSTR(@"この位置を設定しますか？") delegate:self cancelButtonTitle:LSTR(@"キャンセル") otherButtonTitles:LSTR(@"設定"), nil];
    [alert show];
}

#pragma mark - CLLocationManagerDelegate
// 위치 업데이트
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [manager stopUpdatingLocation];
    CLLocation *currentLocation = locations.lastObject;
    CLLocationCoordinate2D coordinate = currentLocation.coordinate;
    MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(0.1, 0.1); // 숫자가 작으면 확대 배율이 커짐
    MKCoordinateRegion newRegion = MKCoordinateRegionMake(coordinate, coordinateSpan);
    [_mapView setRegion:newRegion animated:YES];
    [self localNameWithCoordinate:coordinate];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError.");
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
                [self localSearchStr:placemark.locality];
            }
        }
    }];
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"didSelectAnnotationView");
    MKPointAnnotation *point = view.annotation;
    _currentLocationLb.text = LOCATION_STR(point.title);
    _currentAnnotation = point;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"annotation %@", _currentAnnotation);
        NSDictionary *locationDic = LOCATION_DIC(_currentAnnotation.title, @(_currentAnnotation.coordinate.latitude), @(_currentAnnotation.coordinate.longitude));
        USERDEFAULTS_SET_OBJ(LOCATION_KEY, locationDic);
        [USERDEFAULTS synchronize];
    }
}

#pragma mark - UISearchBarDelegate
// 로컬검색
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    if ([searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0) {
        [self localSearchStr:searchBar.text];
        _button.enabled = YES;
    } else {
        [UIAlertView simpleAlertMessage:LSTR(@"探す位置を入力してください")];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)localSearchStr:(NSString *)str
{
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = str;
    request.region = _mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
     {
         [_mapView removeAnnotations:[_mapView annotations]];
         
         for (MKMapItem *item in response.mapItems)
         {
             MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
             point.coordinate = item.placemark.coordinate;
             point.title = item.placemark.name;
             point.subtitle = item.placemark.title;
             
             [_mapView addAnnotation:point];
         }

         if ([[_mapView annotations] count] == 1) {
             [_mapView selectAnnotation:[_mapView annotations][0] animated:NO];
         }
         [_mapView showAnnotations:[_mapView annotations] animated:YES];
     }];
}

@end
