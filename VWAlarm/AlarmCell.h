//
//  AlarmCell.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 17..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *alarmLb;
@property (weak, nonatomic) IBOutlet UILabel *ampmLb;
@property (weak, nonatomic) IBOutlet UILabel *repeatLb;
@property (weak, nonatomic) IBOutlet UISwitch *activeSwitch;
@property (strong, nonatomic) NSDictionary *item;
@end
