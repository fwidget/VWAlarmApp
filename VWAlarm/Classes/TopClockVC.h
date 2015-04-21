//
//  TopClockVC.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopClockVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ampmLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *alarmScrollView;

@end
