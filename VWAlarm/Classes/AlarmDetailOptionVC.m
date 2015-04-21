//
//  AlarmDetailOptionVC.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 14..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "AlarmDetailOptionVC.h"
#import "Alarm.h"

@interface AlarmDetailOptionVC ()
@end

@implementation AlarmDetailOptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)initTableView
{
    if ([_cellIdentifier isEqualToString:ALARM_DETAIL_OPTION_CELL_IDENTIFIER_REPEAT]) {
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_cellIdentifier isEqualToString:ALARM_DETAIL_OPTION_CELL_IDENTIFIER_REPEAT]) {
        return [REPEATCELL_WEEK count];
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    [self configuration:cell indexPath:indexPath];
    return cell;
}

- (void)configuration:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if ([_cellIdentifier isEqualToString:ALARM_DETAIL_OPTION_CELL_IDENTIFIER_REPEAT]) {
        cell.selectionStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.textLabel.text =  [self weekStrAtIndex:indexPath.row];
        if ([_selectItems containsObject:@(indexPath.row)]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if ([_cellIdentifier isEqualToString:ALARM_DETAIL_OPTION_CELL_IDENTIFIER_LABEL]) {
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (NSString *)weekStrAtIndex:(NSInteger)index
{
    NSString *weekStr = REPEATCELL_WEEK[index];
    weekStr = [NSString stringWithFormat:@"%@%@", weekStr, LSTR(@"曜日")];
    return weekStr;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![_cellIdentifier isEqualToString:ALARM_DETAIL_OPTION_CELL_IDENTIFIER_REPEAT]) return;
    
    if (!_selectItems) _selectItems = [NSMutableArray array];
    if ([_selectItems containsObject:@(indexPath.row)]) {
        [_selectItems removeObject:@(indexPath.row)];
    } else {
        [_selectItems addObject:@(indexPath.row)];
    }
    [tableView reloadData];
    [self sortingItems:_selectItems];
    [self sendItem:@{ALARM_PARAMETER_KEY_REPEAT : _selectItems}];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length > 0) {
        [self sendItem:@{ALARM_PARAMETER_KEY_LABEL: textField.text}];
    }
}

- (void)sendItem:(id)item
{
    if ([_delegate respondsToSelector:@selector(sendItem:)]) {
        [_delegate sendItem:item];
    }
}

- (void)sortingItems:(NSMutableArray *)items
{
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [items sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
