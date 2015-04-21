//
//  G2NoticeView.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface G2NoticeView : UIView
@property (nonatomic) BOOL isShowNoticeView;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIView *overlay;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) NSTimeInterval duration;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSDictionary *info;
- (void)showMessageBar:(NSString *)message duration:(NSTimeInterval)duration complete:(void(^)(void))complete;
- (void)hiddenMessageBar:(BOOL)animated;
@end
