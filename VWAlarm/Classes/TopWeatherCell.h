//
//  TopWeatherCell.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopWeatherCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *highLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowLabel;

@end
