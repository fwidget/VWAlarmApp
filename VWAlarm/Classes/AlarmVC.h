//
//  SecondViewController.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmDetailVC.h"

@interface AlarmVC : UIViewController < UITableViewDataSource, UITableViewDelegate, AlarmDetailDelegate >

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *items;
@end

