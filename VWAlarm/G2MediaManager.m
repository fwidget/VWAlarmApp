//
//  G2MediaManager.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 29..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "G2MediaManager.h"

@implementation G2MediaManager
+ (G2MediaManager *)sharedInstance
{
    static dispatch_once_t pred;
    static G2MediaManager *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

- (void)initObjects
{
    if (!_musicPlayer) {
        _musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
    }
}
@end
