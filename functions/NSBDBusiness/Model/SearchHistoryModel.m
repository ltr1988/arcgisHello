//
//  SearchHistoryModel.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHistoryModel.h"
#import "SearchHistoryTaskItem.h"
#import "SearchHistoryMetaData.h"
@implementation SearchHistoryModel

-(BOOL) hasMore
{
    return [_total integerValue] >= 10;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"datalist" :@"data.rows",
             @"total" :@"data.total",
             };
    
}

+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[SearchHistoryMetaData class] forKey:@"datalist"];
    return dict;
}
@end
