//
//  AlarmDetailVC.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 14..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "AlarmDetailVC.h"

#define TABLEVIEW_CELL_INDENTIFIERS @[@[ALARM_CELL_IDENTIFIER_LABEL, ALARM_CELL_IDENTIFIER_REPEAT, ALARM_CELL_IDENTIFIER_SONOOZE], @[ALARM_CELL_IDENTIFIER_DELETE]]

@interface AlarmDetailVC ()
@end

@implementation AlarmDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatePicker];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (void)initDatePicker
{
    _datePicker.date = (_isAdd) ? [NSDate date] : _item.date;
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
    [self checkItemValues:_item];
    // save
    if ([VWADataManager saveDataWithEntity:VWAEntityOfAlarm]) {
        [self addNotification:_item isAdd:_isAdd]; // noti 등록
        
        if ([_delegate respondsToSelector:@selector(saveAlarmDetail:isAdd:)]) {
            [_delegate saveAlarmDetail:_item isAdd:_isAdd];
        }
 
        [self dismissViewControllerAnimated:YES completion:^{

        }];
    } else {
        [VWAAlarmManager simpleAlertMessage:LSTR(@"登録に失敗しました")];
    }
}

// 알람 등록
- (void)addNotification:(Alarm *)item isAdd:(BOOL)isAdd
{
    if (isAdd) {
        [VWAAlarmManager addAlarmScheduleLocalNotificationWithItem:item];
    } else {
        [VWAAlarmManager updateAlarmScheduleLocalNotificationWithItem:item];
    }
}

//TODO:사운드 부분 수정 필요
- (void)checkItemValues:(Alarm *)item
{
    if (!item.indexId.length > 0) {
        NSURL *url = [[item objectID] URIRepresentation];
        item.indexId = [url absoluteString];
    }
    if (!item.createDate) {
        item.createDate = [NSDate date];
    }
    if (!item.updateDate) {
        item.updateDate = [NSDate date];
    }
    if (!item.active) {
        item.active = @(1);
    }
    // test
    if (!item.soundFiles) {
        item.soundFiles = @[@"get01", @"get02", @"get03"];
    }
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
            cell.detailTextLabel.text = (_item.snoose.length > 0) ? _item.snoose : ALARM_NONE_TITLE;
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
- (void)sendSelectOptionItem:(Alarm *)item
{
    NSLog(@"sendSelectOptionItem %@",item);
    if (!item || ![item isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if (item.repeatTimes.count > 0) {
        _item.repeatTimes = item.repeatTimes;
    }
    
    if (item.title.length > 0) {
        _item.title = item.title;
    }
    
    if ([item.soundFiles count] > 0) {
        _item.soundFiles = item.soundFiles;
    }
    
    if (item.snoose.length > 0) {
        _item.snoose = item.snoose;
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
    } else if ([segue.identifier isEqualToString:ALARM_PARAMETER_KEY_SNOOSE]) {
        vc.cellIdentifier = ALARM_DETAIL_OPTION_CELL_IDENTIFIER_SNOOSE;
    }
}


@end
