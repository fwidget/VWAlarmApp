//
//  WeatherVC.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "WeatherVC.h"
#import "WeatherDetailVC.h"
#import "WeatherCell.h"
#import "OWMWeatherAPI.h"

@interface WeatherVC ()
@property (nonatomic) NSIndexPath *selectIndexPath;
@property (strong, nonatomic) OWMWeatherAPI *weatherAPI;
@end

@implementation WeatherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self barButton];
    
    _weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"b679f6c90a21d8c40513078a40bc19b8"];
    [_weatherAPI setLangWithPreferedLanguage];
    [_weatherAPI setTemperatureFormat:kOWMTempCelcius];
    
    [_weatherAPI currentWeatherByCityName:@"Odense" withCallback:^(NSError *error, NSDictionary *result) {
        if (error) {
            // Handle the error
            return;
        }
        
        if (!_items) _items = [NSMutableArray array];
        
        NSString *cityName = [NSString stringWithFormat:@"%@, %@",
                              result[@"name"],
                              result[@"sys"][@"country"]
                              ];
        
        NSString *currentTemp = [NSString stringWithFormat:@"%.1f℃",
                                 [result[@"main"][@"temp"] floatValue] ];
        NSString *minTemp = [NSString stringWithFormat:@"%.1f℃",
                                 [result[@"main"][@"temp_min"] floatValue] ];
        NSString *maxTemp = [NSString stringWithFormat:@"%.1f℃",
                                 [result[@"main"][@"temp_max"] floatValue] ];
        
        NSString *weather = result[@"weather"][0][@"description"];
        NSDictionary *weatherInfo = @{@"name" : cityName, @"currentTemp" : currentTemp, @"minTemp" : minTemp, @"maxTemp" : maxTemp, @"weather" : weather};
        [_items addObject:weatherInfo];
        [_tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_weatherAPI) {
        _weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"b679f6c90a21d8c40513078a40bc19b8"];
        [_weatherAPI setLangWithPreferedLanguage];
        [_weatherAPI setTemperatureFormat:kOWMTempCelcius];
    }
    
    [_weatherAPI currentWeatherByCityName:@"Odense" withCallback:^(NSError *error, NSDictionary *result) {
        if (error) {
            // Handle the error
            return;
        }
        
        if (!_items) _items = [NSMutableArray array];
        
        NSString *cityName = [NSString stringWithFormat:@"%@, %@",
                              result[@"name"],
                              result[@"sys"][@"country"]
                              ];
        
        NSString *currentTemp = [NSString stringWithFormat:@"%.1f℃",
                                 [result[@"main"][@"temp"] floatValue] ];
        NSString *minTemp = [NSString stringWithFormat:@"%.1f℃",
                             [result[@"main"][@"temp_min"] floatValue] ];
        NSString *maxTemp = [NSString stringWithFormat:@"%.1f℃",
                             [result[@"main"][@"temp_max"] floatValue] ];
        
        NSString *weather = result[@"weather"][0][@"description"];
        NSDictionary *weatherInfo = @{@"name" : cityName, @"currentTemp" : currentTemp, @"minTemp" : minTemp, @"maxTemp" : maxTemp, @"weather" : weather};
        [_items addObject:weatherInfo];
        [_tableView reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation button

- (void)tableEditting
{
    _tableView.editing = !_tableView.editing;
    _tableView.allowsSelectionDuringEditing = !_tableView.allowsSelectionDuringEditing;
}

- (UIBarButtonItem *)barButton
{
    UIBarButtonItem *barButton;
    if (_tableView.editing) {
        barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButton:)];
    } else {
        barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButton:)];
    }
    
    return barButton;
}


- (void)editButton:(id)sender
{
    [self tableEditting];
    self.navigationItem.leftBarButtonItem = [self barButton];
}

- (void)doneButton:(id)sender
{
    [self tableEditting];
    self.navigationItem.leftBarButtonItem = [self barButton];
}

- (IBAction)addWeather:(id)sender
{
    [self presentWeatherWithItem:nil];
}

- (void)presentWeatherWithItem:(NSDictionary *)item
{
//    UINavigationController *navi = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherDetailNavi"];
//    WeatherDetailVC *vc = navi.viewControllers.firstObject;
//    vc.delegate = self;
//    if (item) vc.item = [NSMutableDictionary dictionaryWithDictionary:item];
//    [self presentViewController:navi animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = WEATHER_CELL_IDENTIFIER_WEATHER;
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.weatherLb.text = _items[indexPath.row][@"weather"];
    cell.weatherLowLb.text = _items[indexPath.row][@"minTemp"];
    cell.weatherHighLb.text = _items[indexPath.row][@"maxTemp"];
    cell.weatherImageView.image = nil;
    cell.weatherEtcLb.text = _items[indexPath.row][@"name"];
    return cell;
}

//- (void)configuration:(AlarmCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
//    cell.item = _items[indexPath.row];
//    cell.titleLb.text = _items[indexPath.row][ALARM_ITEM_KEY_TITLE];
//    NSString *time = [G2DateManager timeStrFromDate:_items[indexPath.row][ALARM_ITEM_KEY_DATE]];
//    NSString *ampm = ALARM_CLOCK_AM;
//    if ([[time substringWithRange:NSMakeRange(0, 2)] integerValue] > 12) ampm = ALARM_CLOCK_PM;
//    
//    cell.alarmLb.text = [NSString stringWithFormat:@"%@", [G2DateManager timeStrFromDate:_items[indexPath.row][ALARM_ITEM_KEY_DATE] format:@"hh:mm"]];
//    cell.ampmLb.text = ampm;
//    cell.repeatLb.text = [self repeateWithItems:_items[indexPath.row][ALARM_ITEM_KEY_REPEAT]];
//    cell.activeSwitch.on = ([_items[indexPath.row][ALARM_ITEM_KEY_ACTIVE] integerValue] == 1 ) ? YES : NO;
//}
//
//- (NSString *)repeateWithItems:(NSArray *)items
//{
//    NSString *repeatStr = @"";
//    for (NSNumber *number in items) {
//        if (repeatStr.length == 0) {
//            repeatStr = REPEATCELL_WEEK[[number integerValue]];
//        } else {
//            repeatStr = [NSString stringWithFormat:@"%@ %@", repeatStr, REPEATCELL_WEEK[[number integerValue]]];
//        }
//    }
//    return repeatStr;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self deleteRowItemAtIndexPath:indexPath];
//        [_tableView beginUpdates];
//        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [_tableView endUpdates];
//    }
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (!_tableView.editing) return;
//    _selectIndexPath = indexPath;
//    [self presentAlarmWithItem:_items[indexPath.row]];
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return (_tableView.editing) ? YES : NO;
//}
//
//- (void)deleteRowItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    [_items removeObjectAtIndex:indexPath.row];
//}
//
//#pragma mark - AlarmDetailDelegate
//- (void)deleteAlarmDetail:(NSMutableDictionary *)item
//{
//    [self deleteRowItemAtIndexPath:_selectIndexPath];
//    [_tableView beginUpdates];
//    [_tableView deleteRowsAtIndexPaths:@[_selectIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [_tableView endUpdates];
//}
//
//- (void)saveAlarmDetail:(NSMutableDictionary *)item isAdd:(BOOL)isAdd
//{
//    NSLog(@"item %@", item);
//    if (item && isAdd) {
//        if (!_items) _items = [NSMutableArray array];
//        [_items addObject:item];
//    } else if (_selectIndexPath) {
//        [_items replaceObjectAtIndex:_selectIndexPath.row withObject:item];
//    }
//    [_tableView reloadData];
//    [self saveData];
//}
//
//- (void)saveData
//{
//    [[G2DataManager sharedInstance] updateData:_items forName:ALARM_DATA_KEY];
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
@end
