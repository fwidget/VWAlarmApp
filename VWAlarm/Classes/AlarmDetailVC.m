//
//  AlarmDetailVC.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 14..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "AlarmDetailVC.h"
#import "Alarm.h"

#define TABLEVIEW_CELL_INDENTIFIERS @[@[ALARM_CELL_IDENTIFIER_LABEL, ALARM_CELL_IDENTIFIER_REPEAT, ALARM_CELL_IDENTIFIER_SOUND, ALARM_CELL_IDENTIFIER_SONOOZE], @[ALARM_CELL_IDENTIFIER_DELETE]]

@interface AlarmDetailVC ()
@end

@implementation AlarmDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isAdd = (_item) ? NO : YES;
    if (_isAdd) {
        NSDictionary *item = @{ ALARM_ITEM_KEY_TITLE : ALARM_DEFAULT_TITLE, ALARM_ITEM_KEY_SOUND : @"", ALARM_ITEM_KEY_SOUND_FILENAME : @"", ALARM_ITEM_KEY_SNOOSE : @(NO), ALARM_ITEM_KEY_REPEAT:@[], ALARM_ITEM_KEY_DATE : [NSDate date]};
        _item = [item mutableCopy];
    }
    [self initDatePicker];
}

- (void)initDatePicker
{
    _datePicker.date = _item[ALARM_ITEM_KEY_DATE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelNaviBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveNaviBtn:(id)sender
{
    // save
    if ([_delegate respondsToSelector:@selector(saveAlarmDetail:isAdd:)]) {
        [_delegate saveAlarmDetail:_item isAdd:_isAdd];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)alarmdate:(UIDatePicker *)sender
{
    NSLog(@"input : %@", sender.date);
    _item[ALARM_ITEM_KEY_DATE] = sender.date;
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 수정은 삭제셀 표시, 신규 미표시
    return (_isAdd) ? 1 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [TABLEVIEW_CELL_INDENTIFIERS[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIndentifier = TABLEVIEW_CELL_INDENTIFIERS[indexPath.section][indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
    [self configuration:cell indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if ([_delegate respondsToSelector:@selector(deleteAlarmDetail:)]) {
            [_delegate deleteAlarmDetail:_item];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)configuration:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = (_item[ALARM_ITEM_KEY_TITLE]) ? _item[ALARM_ITEM_KEY_TITLE] : ALARM_DEFAULT_TITLE;
            break;
        case 1:
            cell.detailTextLabel.text = (_item[ALARM_ITEM_KEY_REPEAT]) ? [self repeateWithItems:_item[ALARM_ITEM_KEY_REPEAT]] : ALARM_NONE_TITLE;
            break;
        case 2:
            cell.detailTextLabel.text = (_item[ALARM_ITEM_KEY_SOUND]) ? _item[ALARM_ITEM_KEY_SOUND] : ALARM_NONE_TITLE;
            break;
        case 3:
        {
            UISwitch *snoose = (UISwitch *)[cell viewWithTag:VIEW_WITH_TAG_SNOOSE_SWITCH];
            snoose.on = ([_item[ALARM_ITEM_KEY_SNOOSE] boolValue]) ? YES : NO;
        }
            break;
        default:
            break;
    }
}

- (NSString *)repeateWithItems:(NSArray *)items
{
    if (!items || items.count == 0) {
        return ALARM_NONE_TITLE;
    }
    NSString *repeatStr = @"";
    for (NSNumber *weekIndex in items) {
        if (repeatStr.length == 0) {
            repeatStr = REPEATCELL_WEEK[[weekIndex integerValue]];
        } else {
            repeatStr = [NSString stringWithFormat:@"%@・%@", repeatStr, REPEATCELL_WEEK[[weekIndex integerValue]]];
        }
    }
    return repeatStr;
}

#pragma mark - AlarmDetailOptionDelegate
- (void)sendItem:(id)item
{
    NSLog(@"sendItem %@",item);
    if (!item || ![item isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if (item[ALARM_PARAMETER_KEY_REPEAT]) {
        _item[ALARM_ITEM_KEY_REPEAT] = ([item[ALARM_PARAMETER_KEY_REPEAT] count] > 0) ? item[ALARM_PARAMETER_KEY_REPEAT] : ALARM_NONE_TITLE;
    }
    
    if (item[ALARM_PARAMETER_KEY_LABEL]) {
        _item[ALARM_ITEM_KEY_TITLE] = item[ALARM_PARAMETER_KEY_LABEL];
    }
    
    if (item[ALARM_PARAMETER_KEY_SOUND] && item[ALARM_PARAMETER_KEY_SOUND_FILENAME]) {
        _item[ALARM_ITEM_KEY_SOUND] = item[ALARM_PARAMETER_KEY_SOUND];
        _item[ALARM_ITEM_KEY_SOUND_FILENAME] = item[ALARM_PARAMETER_KEY_SOUND_FILENAME];
    }
    
    [_tableView reloadData];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AlarmDetailOptionVC *vc = [segue destinationViewController];
    vc.delegate = self;
    vc.item = _item;
    
    if ([segue.identifier isEqualToString:ALARM_PARAMETER_KEY_LABEL]) {
        vc.cellIdentifier = ALARM_DETAIL_OPTION_CELL_IDENTIFIER_LABEL;
    } else if ([segue.identifier isEqualToString:ALARM_PARAMETER_KEY_SOUND]) {
        vc.cellIdentifier = ALARM_DETAIL_OPTION_CELL_IDENTIFIER_SOUND;
    } else if ([segue.identifier isEqualToString:ALARM_PARAMETER_KEY_REPEAT]) {
        vc.cellIdentifier = ALARM_DETAIL_OPTION_CELL_IDENTIFIER_REPEAT;
        vc.selectItems = [NSMutableArray arrayWithArray:_item[ALARM_ITEM_KEY_REPEAT]];
    }
}


@end
