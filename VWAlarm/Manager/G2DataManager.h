//
//  G2DataManager.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LOCAL_FILENAME                                @"/VWAInfo.dat"
#define LOCAL_INFO                                    @"vwa_info"

@interface G2DataManager : NSObject <NSCoding>
@property (strong, nonatomic) NSMutableDictionary *localInfo;
+ (G2DataManager *)sharedInstance;
- (void)loadData;
- (void)saveData;
- (id)loadDataForName:(NSString *)name;
- (BOOL)updateData:(id)data forName:(NSString *)name;
@end
