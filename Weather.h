//
//  Weather.h
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 3..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Weather : NSManagedObject

@property (nonatomic, retain) NSNumber * weatherId;
@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSNumber * currentTemp;
@property (nonatomic, retain) NSNumber * minTemp;
@property (nonatomic, retain) NSNumber * maxTemp;
@property (nonatomic, retain) NSData * weatherInfo;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSDate * updateDate;

@end
