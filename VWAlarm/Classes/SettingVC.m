//
//  SettingVC.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "SettingVC.h"
#import "Line.h"
#import "LKLineActivity.h"

#define TABLE_SECTION_TITLES @[@[LSTR(@"天気予報エリア")], @[LSTR(@"友達にシェア"), LSTR(@"サポート"), LSTR(@"このアプリについて")]]
#define TABLEVIEW_CELL_INDENTIFIERS @[@[CELL_IDENTIFIER_SETTING_MAPVIEW], @[CELL_IDENTIFIER_SETTING_SHARE, CELL_IDENTIFIER_SETTING_DETAIL, CELL_IDENTIFIER_SETTING_DETAIL], @[CELL_IDENTIFIER_SETTING_DELETE]]


@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [TABLE_SECTION_TITLES count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [TABLE_SECTION_TITLES[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_INDENTIFIERS[indexPath.section][indexPath.row]];
    [self configurationCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self openActivity];
    }
}

- (void)configurationCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = TABLE_SECTION_TITLES[indexPath.section][indexPath.row];
    cell.textLabel.text = title;
    if (indexPath.section == 0) {
        NSDictionary *locationDic = USERDEFAULTS_GET_KEY(LOCATION_KEY);
        cell.detailTextLabel.text = (locationDic[LOCATION_KEY_NAME]) ? locationDic[LOCATION_KEY_NAME] : LSTR(@"未設定");
    }
}

- (void)openActivity
{
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:@[SHARE_MESSAGE_CONTENT, [NSURL URLWithString:SHARE_MESSAGE_URL]] applicationActivities:@[[[LKLineActivity alloc] init]]];
    [self presentViewController:avc animated:YES completion:nil];
}

@end
