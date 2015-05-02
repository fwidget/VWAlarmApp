//
//  AlarmDetailVC.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 14..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmDetailOptionVC.h"
@protocol AlarmDetailDelegate <NSObject>
- (void)saveAlarmDetail:(AlarmItem *)item isAdd:(BOOL)isAdd;
- (void)deleteAlarmDetail:(AlarmItem *)item;
@end

@interface AlarmDetailVC : UIViewController < UITableViewDelegate, UITableViewDataSource, AlarmDetailOptionDelegate >
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AlarmItem *item;
@property (nonatomic) BOOL isAdd;
@property (weak, nonatomic) id<AlarmDetailDelegate> delegate;
@end
