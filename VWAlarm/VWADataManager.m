//
//  VWAManager.m
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 3..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "VWADataManager.h"
#import "AppDelegate.h"
#import "Alarm.h"
#import "Weather.h"
#import "Setting.h"

@implementation VWADataManager

// 데이터 취득
+ (NSArray *)selectDataWithEntity:(VWAEntity)entity
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:[self entityNameForKey:entity]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createDate" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSArray *results = [((AppDelegate *)SELF_DELEGATE).managedObjectContext executeFetchRequest:fetchRequest error:nil];

    return results;
}

// 빈 데이터 생성
+ (id)initDataWithEntity:(VWAEntity)entity
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityNameForKey:entity] inManagedObjectContext:((AppDelegate *)SELF_DELEGATE).managedObjectContext];
}

+ (BOOL)saveDataWithEntity:(VWAEntity)entity
{
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)SELF_DELEGATE).managedObjectContext;
    NSError *saveError = nil;
    if (![managedObjectContext save:&saveError]) {
        NSLog(@"saveDataWithEntity Error log %@", saveError.description);
        return NO;
    }
    return YES;
}

//+ (BOOL)insertDataWithEntity:(VWAEntity)entity obj:(id)obj
//{
//    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)SELF_DELEGATE).managedObjectContext;
//    NSFetchRequest *insertRequest = [[NSFetchRequest alloc] initWithEntityName:[self entityNameForKey:entity]];
//    
//}

// 데이터 삭제
+ (BOOL)deleteDataWithEntity:(VWAEntity)entity indexId:(NSString *)indexId
{
    NSManagedObjectContext *managedObjectContext = ((AppDelegate *)SELF_DELEGATE).managedObjectContext;
    NSFetchRequest *deleteRequest = [[NSFetchRequest alloc] initWithEntityName:[self entityNameForKey:entity]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"indexId like %@", indexId];
    [deleteRequest setPredicate:predicate];
    [deleteRequest setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:deleteRequest error:&error];
    
    for (NSManagedObject *data in results) {
        [managedObjectContext deleteObject:data];
    }
    
    NSError *saveError = nil;
    if (![managedObjectContext save:&saveError]) {
        NSLog(@"deleteDataWithEntity Error log %@", saveError.description);
        return NO;
    }
    return YES;
}

#pragma mark - entitykey
+ (NSString *)entityNameForKey:(VWAEntity)entity
{
    if (entity == VWAEntityOfAlarm) {
        return NSStringFromClass(Alarm.class);
    } else if (entity == VWAEntityOfWeather) {
        return NSStringFromClass(Weather.class);
    } else if (entity == VWAEntityOfSetting) {
        return NSStringFromClass(Setting.class);
    }
    return nil;
}
@end
