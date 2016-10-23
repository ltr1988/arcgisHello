//
//  SearchHistoryTaskItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHistoryTaskItem.h"
#import "HttpMetaData.h"
#import "SearchHistoryItem.h"

@implementation SearchHistoryTaskItem

-(instancetype) initWithSearchHistoryMetaArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        _datalist = [array copy];
    }
    return self;
}

-(SearchHistoryItem*) searchHistoryItem
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (HttpMetaData *data in _datalist) {
        if ([data.dataID isEqualToString:@"id"] ||
            [data.dataID isEqualToString:@"endTime"] ||
            [data.dataID isEqualToString:@"startTime"]||
            [data.dataID isEqualToString:@"name"])
        {
            dictionary[data.dataID] = data.value?:@"";
        }
        
    }
    SearchHistoryItem *item = [[SearchHistoryItem alloc] init];
    item.taskid = dictionary[@"id"];
    item.endDate = dictionary[@"endTime"];
    item.startDate = dictionary[@"startTime"];
    item.name = dictionary[@"name"];
    
    return item;
}
@end
