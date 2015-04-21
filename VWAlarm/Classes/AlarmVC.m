//
//  SecondViewController.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "AlarmVC.h"
#import "Alarm.h"
#import "AlarmCell.h"

@interface AlarmVC ()
@property (nonatomic) NSIndexPath *selectIndexPath;
@end

@implementation AlarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _items = [[G2DataManager sharedInstance] loadDataForName:ALARM_DATA_KEY];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation button
- (IBAction)editButton:(id)sender
{
    _tableView.editing = !_tableView.editing;
    _tableView.allowsSelectionDuringEditing = !_tableView.allowsSelectionDuringEditing;
}
- (IBAction)addAlarm:(id)sender
{
    [self presentAlarmWithItem:nil];
}

- (void)presentAlarmWithItem:(NSDictionary *)item
{
    UINavigationController *navi = [self.storyboard instantiateViewControllerWithIdentifier:ALARM_STORYBOARD_ID_ALARM_DETAILNAVI];
    AlarmDetailVC *vc = navi.viewControllers.firstObject;
    vc.delegate = self;
    if (item) vc.item = [NSMutableDictionary dictionaryWithDictionary:item];
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark - TableView Delegate
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
    static NSString *CellIdentifier = ALARM_CELL_IDENTIFIER_ALARM;
    AlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.item = _items[indexPath.row];
    cell.titleLb.text = _items[indexPath.row][ALARM_ITEM_KEY_TITLE];
    NSString *time = [G2DateManager timeStrFromDate:_items[indexPath.row][ALARM_ITEM_KEY_DATE]];
    NSString *ampm = ALARM_CLOCK_AM;
    if ([[time substringWithRange:NSMakeRange(0, 2)] integerValue] > 12) ampm = ALARM_CLOCK_PM;
    
    cell.alarmLb.text = [NSString stringWithFormat:@"%@", [G2DateManager timeStrFromDate:_items[indexPath.row][ALARM_ITEM_KEY_DATE] format:@"hh:mm"]];
    cell.ampmLb.text = ampm;
    cell.repeatLb.text = [self repeateWithItems:_items[indexPath.row][ALARM_ITEM_KEY_REPEAT]];
    cell.activeSwitch.on = ([_items[indexPath.row][ALARM_ITEM_KEY_ACTIVE] integerValue] == 1 ) ? YES : NO;
    return cell;
}

- (NSString *)repeateWithItems:(NSArray *)items
{
    NSString *repeatStr = @"";
    for (NSNumber *number in items) {
        if (repeatStr.length == 0) {
            repeatStr = REPEATCELL_WEEK[[number integerValue]];
        } else {
            repeatStr = [NSString stringWithFormat:@"%@ %@", repeatStr, REPEATCELL_WEEK[[number integerValue]]];
        }
    }
    return repeatStr;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_tableView.editing) return;
    _selectIndexPath = indexPath;
    [self presentAlarmWithItem:_items[indexPath.row]];
}

#pragma mark - saveAlarmDetailDelegate
- (void)saveAlarmDetail:(NSMutableDictionary *)item isAdd:(BOOL)isAdd
{
    NSLog(@"item %@", item);
    if (item && isAdd) {
        if (!_items) _items = [NSMutableArray array];
        [_items addObject:item];
    } else if (_selectIndexPath) {
        [_items replaceObjectAtIndex:_selectIndexPath.row withObject:item];
    }
    [_tableView reloadData];
    [self saveData];
}

- (void)saveData
{
    [[G2DataManager sharedInstance] updateData:_items forName:ALARM_DATA_KEY];
}

@end
