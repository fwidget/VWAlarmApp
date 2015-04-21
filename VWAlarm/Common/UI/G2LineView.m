//
//  G2LineView.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "G2LineView.h"

@implementation G2LineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CGFloat pixcel = 1.0f / [UIScreen mainScreen].scale;
    UIView *line = [[UIView alloc] initWithFrame:
                    CGRectMake(0, 0, self.frame.size.width, pixcel)];
    [line setBackgroundColor:self.backgroundColor];
    [self addSubview:line];
    self.backgroundColor = [UIColor clearColor];
}

@end
