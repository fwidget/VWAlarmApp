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
{
    NSInteger _playIndex;
}

+ (G2SoundManager *)sharedInstance
{
    static dispatch_once_t pred;
    static G2SoundManager *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
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
        if (!_players) _players = [NSMutableArray array];
        [_players addObject:player];
    }
    
}

- (void)startPlaySounds
{
    if (_players.count > 0) {
        _playIndex = 0;
        [self playSoundAtIndex:_playIndex];
    }
}

- (void)pauseSounds
{
    [_player pause];
}

- (void)stopPlaySounds
{
    [_player pause];
    [_player stop];
    _player = nil;
    _players = nil;
    _playIndex = 0;
}

- (void)playSoundAtIndex:(NSInteger)index
{
    if (_players.count > 0) {
        _player = [_players objectAtIndex:index];
        [_player play];
    }
}

- (void)nextPlay
{
    if (_players.count > 0 && _playIndex < _players.count) {
        _playIndex = _playIndex + 1;
        [self playSoundAtIndex:_playIndex];
    }
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        [self nextPlay];
    }
}

@end
