//
//  G2CacheManager.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface G2CacheManager : NSCache
+ (G2CacheManager *)sharedInstance;
@end
