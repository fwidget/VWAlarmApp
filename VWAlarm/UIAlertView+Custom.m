//
//  UIAlertView+Custom.m
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 5..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "UIAlertView+Custom.h"

@implementation UIAlertView (Custom)
+ (void)simpleAlertMessage:(NSString *)msg;
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:LSTR(@"確認") otherButtonTitles:nil];
    [alert show];
}
@end
