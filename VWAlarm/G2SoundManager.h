//
//  G2SoundManager.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 22..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface G2SoundManager : NSObject
@property (strong, nonatomic) NSMutableArray *players;
+ (G2SoundManager *)sharedInstance;
- (void)playSounds:(NSArray *)sounds;
- (void)playSoundFileNames:(NSArray *)soundFileNames;

@end