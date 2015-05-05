//
//  AlarmDetailOptionVC.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 14..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "AlarmDetailOptionVC.h"

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
    if ([_cellIdentifier isEqualToString:CELL_IDENTIFIER_ALARM_DETAIL_OPTION_REPEAT] || [_cellIdentifier isEqualToString:CELL_IDENTIFIER_ALARM_DETAIL_OPTION_SNOOSE]) {
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
    if ([_cellIdentifier isEqualToString:CELL_IDENTIFIER_ALARM_DETAIL_OPTION_REPEAT]) {
        return [REPEATCELL_WEEK count];
    } else if ([_cellIdentifier isEqualToString:CELL_IDENTIFIER_ALARM_DETAIL_OPTION_SNOOSE]) {
        return [SNOOSECELL_TYPE count];
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
    if ([_cellIdentifier isEqualToString:CELL_IDENTIFIER_ALARM_DETAIL_OPTION_REPEAT]) {
        cell.selectionStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.textLabel.text =  [self weekStrAtIndex:indexPath.row];
        if ([_selectItems containsObject:@(indexPath.row)]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if ([_cellIdentifier isEqualToString:CELL_IDENTIFIER_ALARM_DETAIL_OPTION_SNOOSE]) {
        cell.selectionStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.textLabel.text = SNOOSECELL_TYPE[indexPath.row];
        if (_item.snoose.length > 0 && [SNOOSECELL_TYPE[indexPath.row] isEqualToString:_item.snoose]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if ([_cellIdentifier isEqualToString:CELL_IDENTIFIER_ALARM_DETAIL_OPTION_LABEL]) {
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
    if ([_cellIdentifier isEqualToString:CELL_IDENTIFIER_ALARM_DETAIL_OPTION_REPEAT]) {
        if (!_selectItems) _selectItems = [NSMutableArray array];
        if ([_selectItems containsObject:@(indexPath.row)]) {
            [_selectItems removeObject:@(indexPath.row)];
        } else {
            [_selectItems addObject:@(indexPath.row)];
        }
        [tableView reloadData];
        _item.repeatTimes = _selectItems;
        [self selectItem:_item];
    } else if ([_cellIdentifier isEqualToString:CELL_IDENTIFIER_ALARM_DETAIL_OPTION_SNOOSE]) {
        _item.snoose = SNOOSECELL_TYPE[indexPath.row];
        [tableView reloadData];
        [self selectItem:_item];
    }
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
        _item.title = textField.text;
        [self selectItem:_item];
    }
}

- (void)selectItem:(Alarm *)item
{
    if ([_delegate respondsToSelector:@selector(sendSelectOptionItem:)]) {
        [_delegate sendSelectOptionItem:item];
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
