//
//  WeatherCell.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 23..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *weatherLb;
@property (weak, nonatomic) IBOutlet UILabel *weatherHighLb;
@property (weak, nonatomic) IBOutlet UILabel *weatherLowLb;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherEtcLb;
@end
