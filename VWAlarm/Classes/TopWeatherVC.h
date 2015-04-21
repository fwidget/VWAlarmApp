//
//  TopWeatherVC.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 7..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopWeatherVC : UIViewController < UICollectionViewDataSource, UICollectionViewDelegate >
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *datasource;
@end
