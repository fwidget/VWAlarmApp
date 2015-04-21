//
//  G2DataManager.m
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#import "G2DataManager.h"

@implementation G2DataManager

+ (G2DataManager *)sharedInstance
{
    static G2DataManager *sharedInstance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedInstance = [[G2DataManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.localInfo = [aDecoder decodeObjectForKey:LOCAL_INFO];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.localInfo forKey:LOCAL_INFO];
}

- (void)loadData
{
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:[self filePath]];
    NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    self.localInfo = [decoder decodeObjectForKey:LOCAL_INFO];
    if (!self.localInfo) {
        self.localInfo = [NSMutableDictionary dictionary];
    }
    [decoder finishDecoding];
}

- (void)saveData
{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *encoder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [encoder encodeObject:self.localInfo forKey:LOCAL_INFO];
    [encoder finishEncoding];
    [data writeToFile:[self filePath] atomically:YES];
}

- (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = paths[0];
    NSString *filePath = [directory stringByAppendingString:LOCAL_FILENAME];
    return filePath;
}

- (id)loadDataForName:(NSString *)name
{
    if (!_localInfo) _localInfo = [NSMutableDictionary dictionary];
    if (_localInfo[name]) return _localInfo[name];
    return nil;
}

- (BOOL)updateData:(id)data forName:(NSString *)name
{
    if (!_localInfo) _localInfo = [NSMutableDictionary dictionary];
    [_localInfo setObject:data forKey:name];
    
    return YES;
}

@end
