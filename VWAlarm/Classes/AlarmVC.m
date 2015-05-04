//
//  SecondViewController.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "AlarmVC.h"
#import "AlarmUtility.h"
#import "AlarmCell.h"
#import "AlarmDetailVC.h"

@interface AlarmVC ()
@property (nonatomic) NSIndexPath *selectIndexPath;
@end

@implementation AlarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = [VWADataManager selectDataWithEntity:VWAEntityOfAlarm];
    _items = [NSMutableArray arrayWithArray:arr];
    self.navigationItem.leftBarButtonItem = [self barButton];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    if (_items.count > 0) {
        if (_tableView.editing) {
            barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButton:)];
        } else {
            barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButton:)];
        }
    } else {
        barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButton:)];
    }
    
    barButton.enabled = (_items.count > 0) ? YES : NO;

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
    [self presentAlarmWithItem:(Alarm *)[VWADataManager initDataWithEntity:VWAEntityOfAlarm] isAdd:YES];
}

- (void)presentAlarmWithItem:(Alarm *)item isAdd:(BOOL)isAdd
{
    UINavigationController *navi = [self.storyboard instantiateViewControllerWithIdentifier:ALARM_STORYBOARD_ID_ALARM_DETAILNAVI];
    AlarmDetailVC *vc = navi.viewControllers.firstObject;
    vc.delegate = self;
    vc.item = item;
    vc.isAdd = isAdd;
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
    [self configurationCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configurationCell:(AlarmCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Alarm *item = (Alarm *)_items[indexPath.row];
    
    cell.item = item;
    cell.titleLb.text = item.title;
    NSString *time = [G2DateManager timeStrFromDate:item.date];
    NSString *ampm = ALARM_CLOCK_AM;
    if ([[time substringWithRange:NSMakeRange(0, 2)] integerValue] > 12) ampm = ALARM_CLOCK_PM;
    
    cell.alarmLb.text = [NSString stringWithFormat:@"%@", [G2DateManager strFromDate:item.date format:@"hh:mm"]];
    cell.ampmLb.text = ampm;
    cell.repeatLb.text = [self repeateWithItems:item.repeatTimes];
    cell.activeSwitch.on = ([item.active integerValue] == 1 ) ? YES : NO;
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
    [self presentAlarmWithItem:_items[indexPath.row] isAdd:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (_tableView.editing) ? YES : NO;
}

- (void)deleteRowItemAtIndexPath:(NSIndexPath *)indexPath
{
    Alarm *item = (Alarm *)_items[indexPath.row];
    BOOL success = [VWADataManager deleteDataWithEntity:VWAEntityOfAlarm indexId:item.indexId];
    if (success) {
        [_items removeObjectAtIndex:indexPath.row];
        [VWAAlarmManager cancelAlarmScheduleLocalNotificationWithItem:item]; // cancel noti 
    } else {
        [VWAAlarmManager simpleAlertMessage:LSTR(@"削除に失敗しました")];
    }
}

#pragma mark - AlarmDetailDelegate
- (void)deleteAlarmDetail:(Alarm *)item
{
    [self deleteRowItemAtIndexPath:_selectIndexPath];
    [_tableView beginUpdates];
    [_tableView deleteRowsAtIndexPaths:@[_selectIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    [_tableView endUpdates];
}

- (void)saveAlarmDetail:(Alarm *)item isAdd:(BOOL)isAdd
{
    NSLog(@"item %@", item);
    if (!item) {
        NSLog(@"%s", __func__);
        return;
    }
    if ([VWADataManager saveDataWithEntity:VWAEntityOfAlarm]) {
        NSArray *arr = [VWADataManager selectDataWithEntity:VWAEntityOfAlarm];
        _items = [NSMutableArray arrayWithArray:arr];
    }
    [_tableView reloadData];
}

@end
