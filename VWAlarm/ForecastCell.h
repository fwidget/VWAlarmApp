//
//  ForecastCell.h
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 4..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCell : UICollectionViewCell
@property (strong, nonatomic) id item;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
