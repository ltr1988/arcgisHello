//
//  MyEventHistoryModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "CommitedEventHistoryModel.h"
#import "CommitedEventHistoryItem.h"


@implementation CommitedEventHistoryModel
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{@"datalist" :@"data.rows",
             @"total" :@"data.total",
             @"pageNo" :@"data.pageNo",
             @"pageSize" :@"data.pageSize",
             };
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[CommitedEventHistoryItem class] forKey:@"datalist"];
    return dict;
}


-(BOOL) hasMore
{
    return [_total integerValue] >= 10;
}
@end
