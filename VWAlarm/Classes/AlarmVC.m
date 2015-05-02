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
    self.navigationItem.leftBarButtonItem = [self barButton];
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
    [self configuration:cell atIndexPath:indexPath];
    return cell;
}

- (void)configuration:(AlarmCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.item = _items[indexPath.row];
    cell.titleLb.text = _items[indexPath.row][ALARM_ITEM_KEY_TITLE];
    NSString *time = [G2DateManager timeStrFromDate:_items[indexPath.row][ALARM_ITEM_KEY_DATE]];
    NSString *ampm = ALARM_CLOCK_AM;
    if ([[time substringWithRange:NSMakeRange(0, 2)] integerValue] > 12) ampm = ALARM_CLOCK_PM;
    
    cell.alarmLb.text = [NSString stringWithFormat:@"%@", [G2DateManager strFromDate:_items[indexPath.row][ALARM_ITEM_KEY_DATE] format:@"hh:mm"]];
    cell.ampmLb.text = ampm;
    cell.repeatLb.text = [self repeateWithItems:_items[indexPath.row][ALARM_ITEM_KEY_REPEAT]];
    cell.activeSwitch.on = ([_items[indexPath.row][ALARM_ITEM_KEY_ACTIVE] integerValue] == 1 ) ? YES : NO;
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
        [self deleteRowItemAtIndexPath:indexPath];
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_tableView.editing) return;
    _selectIndexPath = indexPath;
    [self presentAlarmWithItem:_items[indexPath.row]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (_tableView.editing) ? YES : NO;
}

- (void)deleteRowItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_items removeObjectAtIndex:indexPath.row];
}

#pragma mark - AlarmDetailDelegate
- (void)deleteAlarmDetail:(NSMutableDictionary *)item
{
    [self deleteRowItemAtIndexPath:_selectIndexPath];
    [_tableView beginUpdates];
    [_tableView deleteRowsAtIndexPaths:@[_selectIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    [_tableView endUpdates];
}

- (void)saveAlarmDetail:(AlarmItem *)item isAdd:(BOOL)isAdd
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
    [self addNotification:item isAdd:isAdd];
}

// 알람 등록
- (void)addNotification:(AlarmItem *)item isAdd:(BOOL)isAdd
{
    if (isAdd) {
        // 신규
        [G2NotificationManager addAlarmScheduleLocalNotificationWithDates:item alarmId:item.alarmId repeat:item.repeatTimes];
    } else {
        // 알람 수정
    }
}

- (void)saveData
{
    [[G2DataManager sharedInstance] updateData:_items forName:ALARM_DATA_KEY];
}

@end
