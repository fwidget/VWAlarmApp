//
//  AlarmDetailOptionVC.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 14..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AlarmDetailOptionDelegate <NSObject>
- (void)sendItem:(id)item;
@end

@interface AlarmDetailOptionVC : UIViewController < UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *item;
@property (strong, nonatomic) NSMutableArray *selectItems;
@property (strong, nonatomic) NSMutableArray *selectIndexs;
@property (strong, nonatomic) NSString *cellIdentifier;
@property (weak, nonatomic) id<AlarmDetailOptionDelegate> delegate;

@end
