//
//  G2SoundManager.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "G2SoundManager.h"

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
        _player = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
        [_player play];
    }

}

- (NSString *)filePathOfSoundName:(NSString *)soundName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"mp3"];
    return filePath;
}
@end
