//
//  G2MediaManager.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 29..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface G2MediaManager : NSObject < MPMediaPickerControllerDelegate >
@property (strong, nonatomic) MPMusicPlayerController *musicPlayer;
+ (G2MediaManager *)sharedInstance;
@end
