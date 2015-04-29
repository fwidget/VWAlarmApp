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

#define SHARE_MESSAGE_MAIL_TITLE     @"あなたに声で教えてくれる天気アプリ"
#define SHARE_MESSAGE_CONTENT   @"あなたに声で天気を教えてくれるアプリ"
#define SHARE_MESSAGE_URL       @"https://itun.es/i6B34fX"


@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)openActivity
{
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:@[SHARE_MESSAGE_CONTENT, [NSURL URLWithString:SHARE_MESSAGE_URL]] applicationActivities:@[[[LKLineActivity alloc] init]]];
    [self presentViewController:avc animated:YES completion:nil];

}
@end
