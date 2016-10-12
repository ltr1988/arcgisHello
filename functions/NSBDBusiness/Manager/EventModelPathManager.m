//
//  MediaPathManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventModelPathManager.h"
#import "EventReportModel.h"
#import "NSString+LVPath.h"
#import "AuthorizeManager.h"

#define EVENT_MODELS    [NSString stringWithFormat:@"event_models_%@",[[AuthorizeManager sharedInstance] userName]]

@implementation EventModelPathManager

+(void) addEventMode:(EventReportModel *)model
{
    
    NSString *path = [[NSString documentsPath] stringByAppendingPathComponent:EVENT_MODELS];
    NSMutableArray *list = [NSMutableArray array];
    NSArray *array = [self getEventModels];
    if (array && array.count>0) {
        [list addObjectsFromArray:array];
    }
    [list addObject:model];
    [NSKeyedArchiver archiveRootObject:list toFile:path];
}

+(void) removeEventMode:(EventReportModel *)model
{
    NSString *path = [[NSString documentsPath] stringByAppendingPathComponent:EVENT_MODELS];
    NSMutableArray *list = [NSMutableArray array];
    NSArray *array = [self getEventModels];

    for (EventReportModel* eModel in array) {
        if ([eModel.uuid isEqualToString:model.uuid]) {
            continue;
        }
        [list addObject:eModel];
    }
    [NSKeyedArchiver archiveRootObject:list toFile:path];
}

+(EventReportModel *) lastestEventModel
{
    NSArray *array = [self getEventModels];
    if (array && array.count>0) {
        return array.lastObject;
    }
    return nil;
}

+(NSArray *) getEventModels
{
    NSArray *array = nil;
    NSString *path = [[NSString documentsPath] stringByAppendingPathComponent:EVENT_MODELS];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    return array;
}
@end
