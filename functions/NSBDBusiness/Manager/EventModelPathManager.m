//
//  MediaPathManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventModelPathManager.h"
#import "EventReportModel.h"

@implementation EventModelPathManager

+(void) addEventModelWithPath:(NSString *)path
{
    NSMutableArray *list =
    [[[NSUserDefaults standardUserDefaults] arrayForKey:@"eventModels"] mutableCopy];
    if (!list)
        list = [NSMutableArray array];
    else{
        NSSet *set = [NSSet setWithArray:list];
        if ([set containsObject:path]) {
            return;
        }
    }
    [list addObject:path];
    [[NSUserDefaults standardUserDefaults] setObject:list forKey:@"eventModels"];
    [[NSUserDefaults standardUserDefaults] setObject:path forKey:@"lastestEvent"];

}

+(NSString *) lastestEventPath{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastestEvent"];
}

+(NSArray *) getEventModels
{
    NSMutableArray *list = [NSMutableArray array];
    
    NSArray * array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"eventModels"];
    
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
