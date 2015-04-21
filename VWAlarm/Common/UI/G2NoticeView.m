//
//  G2NoticeView.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "G2NoticeView.h"

@implementation G2NoticeView

- (void)showNoticeBar:(void(^)(void))complete
{
    _isShowNoticeView = YES;
    [UIView animateWithDuration:_duration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.center = _endPoint;
    } completion:^(BOOL finished){
        if (complete) {
            complete();
        } else {
            [self performSelector:@selector(hiddenMessageBar:) withObject:@(YES) afterDelay:60]; // 1分後に自動に隠す
        }
    }];
}

- (void)hiddenMessageBar:(BOOL)animated
{
    if (!_isShowNoticeView) return;
    [UIView animateWithDuration:0.4 delay:1.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.center = _startPoint;
    }completion:^(BOOL finished){
        self.alpha = 0.0;
        _isShowNoticeView = NO;
        [self finishMessageBar];
    }];
}

- (void)showMessageBar:(NSString *)message duration:(NSTimeInterval)duration complete:(void(^)(void))complete
{
    
    if (_isShowNoticeView) {
        _info = @{@"message" : message, @"duration" : @(duration), @"complete" : complete};
        return;
    }
    
    if (!_overlay) {
        _overlay = [[UIView alloc] initWithFrame:self.bounds];
        _overlay.backgroundColor = [UIColor blackColor];
        _overlay.alpha = 0.9;
        [self addSubview:_overlay];
    }
    
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:self.bounds];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.backgroundColor = [UIColor clearColor];
        _title.textColor = [UIColor whiteColor];
        _title.font = [UIFont systemFontOfSize:13.0];
        _title.numberOfLines = 2;
        _title.minimumScaleFactor = 0.5;
        [_overlay addSubview:_title];
    }
    
    _title.text = message;
    
    self.center = _startPoint;
    self.alpha = 1.0;
    self.backgroundColor = [UIColor clearColor];
    self.duration = duration;
    
    _endPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    [self showNoticeBar:complete];
}


- (void)finishMessageBar
{
    if (_info) {
        [self showMessageBar:_info[@"message"] duration:[_info[@"duration"] floatValue] complete:_info[@"complete"]];
        _info = nil;
    }
}
@end
