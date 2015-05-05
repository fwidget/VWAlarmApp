//
//  VWAManager.h
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 3..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, VWAEntity) {
    VWAEntityOfAlarm = 1,
    VWAEntityOfWeather,
    VWAEntityOfSetting,
};

@interface VWADataManager : NSObject
+ (id)initDataWithEntity:(VWAEntity)entity;
+ (BOOL)deleteDataWithEntity:(VWAEntity)entity indexId:(NSString *)indexId;
+ (NSArray *)selectDataWithEntity:(VWAEntity)entity;
+ (BOOL)saveDataWithEntity:(VWAEntity)entity;
@end
