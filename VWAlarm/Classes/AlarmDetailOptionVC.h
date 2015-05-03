//
//  AlarmDetailOptionVC.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 14..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmUtility.h"
#import "Alarm.h"

@protocol AlarmDetailOptionDelegate <NSObject>
- (void)sendSelectOptionItem:(Alarm *)item;
@end

@interface AlarmDetailOptionVC : UIViewController < UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Alarm *item;
@property (strong, nonatomic) NSMutableArray *selectItems;
@property (strong, nonatomic) NSString *cellIdentifier;
@property (weak, nonatomic) id<AlarmDetailOptionDelegate> delegate;

@end
