//
//  MediaPathManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventModelPathManager.h"
#import "EventReportModel.h"

#import "AuthorizeManager.h"

#define EVENT_MODELS    [NSString stringWithFormat:@"event_models_%@",[[AuthorizeManager sharedInstance] userName]]
#define LASTEST_EVENT   [NSString stringWithFormat:@"lastest_event_%@",[[AuthorizeManager sharedInstance] userName]]
@implementation EventModelPathManager

+(void) addEventModelWithPath:(NSString *)path
{
    NSMutableArray *list =
    [[[NSUserDefaults standardUserDefaults] arrayForKey:EVENT_MODELS] mutableCopy];
    if (!list)
        list = [NSMutableArray array];
    else{
        NSSet *set = [NSSet setWithArray:list];
        if ([set containsObject:path]) {
            return;
        }
    }
    [list addObject:path];
    [[NSUserDefaults standardUserDefaults] setObject:list forKey:EVENT_MODELS];
    [[NSUserDefaults standardUserDefaults] setObject:path forKey:LASTEST_EVENT];

}

+(NSString *) lastestEventPath{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LASTEST_EVENT];
}

+(NSArray *) getEventModels
{
    NSMutableArray *list = [NSMutableArray array];
    
    NSArray * array = [[NSUserDefaults standardUserDefaults] arrayForKey:EVENT_MODELS];
    
    if (nil == array) {
        return [NSArray array];
    }
    
    for (NSString *aPath in array) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:aPath])
        {
            EventReportModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:aPath];
            
            if (model) {
                [list addObject:model];
            }
        }
    }
    
    return list;
}
@end
