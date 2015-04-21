//
//  G2CacheManager.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "G2CacheManager.h"

@implementation G2CacheManager
+ (G2CacheManager *)sharedInstance
{
    static G2CacheManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[G2CacheManager alloc] init];
        [sharedInstance setCountLimit:30];
    });
    return sharedInstance;
}
@end
