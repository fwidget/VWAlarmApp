//
//  G2SoundManager.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 22..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface G2SoundManager : NSObject < AVAudioPlayerDelegate >
@property (strong, nonatomic) NSMutableArray *players;
@property (strong, nonatomic) AVAudioPlayer *player;
+ (G2SoundManager *)sharedInstance;
//- (void)playSounds:(NSArray *)sounds;
- (void)playSoundFileNames:(NSArray *)soundFileNames;
- (void)startPlaySounds;
- (void)pauseSounds;
- (void)stopPlaySounds;
@end
