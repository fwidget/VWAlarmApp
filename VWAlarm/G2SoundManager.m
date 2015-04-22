//
//  G2SoundManager.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 22..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "G2SoundManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation G2SoundManager
+ (G2SoundManager *)sharedInstance
{
    static dispatch_once_t pred;
    static G2SoundManager *sharedSoundManager = nil;
    dispatch_once(&pred, ^{ sharedSoundManager = [[self alloc] init]; });
    return sharedSoundManager;
}
- (void)playSounds:(NSArray *)sounds
{
    for (NSString *soundName in sounds) {
        NSString *filePath = [self filePathOfSoundName:soundName];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
        [player play];
    }
}

- (NSString *)filePathOfSoundName:(NSString *)soundName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"mp3"];
    return filePath;
}

- (void)playSoundFileNames:(NSArray *)soundFileNames
{
    for (NSString *soundName in soundFileNames) {
        NSString *filePath = [self filePathOfSoundName:soundName];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
        [player play];
    }
}

- (void)playSound
{
    
}

- (void)nextPlay
{
    
}

@end
