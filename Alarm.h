//
//  Alarm.h
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 3..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Alarm : NSManagedObject

@property (nonatomic, retain) NSString * indexId;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSArray * repeatTimes;
@property (nonatomic, retain) NSString * snoose;
@property (nonatomic, retain) NSArray * soundFiles;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) NSNumber * active;

@end
