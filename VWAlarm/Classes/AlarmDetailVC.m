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
        _item = [[AlarmItem alloc] init];
    }
    [self initDatePicker];
}

- (void)initDatePicker
{
    _datePicker.date = _item.date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    _item.date = sender.date;
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
            cell.detailTextLabel.text = (_item.title.length > 0) ? _item.title : ALARM_DEFAULT_TITLE;
            break;
        case 1:
            cell.detailTextLabel.text = (_item.repeatTimes.count > 0) ? [self repeateWithItems:_item.repeatTimes] : ALARM_NONE_TITLE;
            break;
        case 2:
            cell.detailTextLabel.text = (_item.soundFiles.count > 0) ? [self soundTitleWithItems:_item.soundFiles] : ALARM_NONE_TITLE;
            break;
        case 3:
        {
            UISwitch *snoose = (UISwitch *)[cell viewWithTag:VIEW_WITH_TAG_SNOOSE_SWITCH];
            snoose.on = (_item.snoose) ? YES : NO;
        }
            break;
        default:
            break;
    }
}
- (NSString *)soundTitleWithItems:(NSArray *)items
{
    if (!items || items.count == 0) {
        return ALARM_NONE_TITLE;
    }
    NSString *title_str = @"";
    for (NSString *str in items) {
        if (str.length == 0) {
            title_str = str;
        } else {
            title_str = [title_str stringByAppendingString:str];
        }
    }
    return title_str;
    
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
- (void)sendItem:(AlarmItem *)item
{
    NSLog(@"sendItem %@",item);
    if (!item || ![item isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if (item.repeatTimes.count > 0) {
        _item.repeatTimes = item.repeatTimes;
    }
    
    if (item.title) {
        _item.title = item.title;
    }
    
    if ([item.soundFiles count] > 0) {
        _item.soundFiles = item.soundFiles;
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
        vc.selectItems = [NSMutableArray arrayWithArray:_item.repeatTimes];
    }
}


@end
