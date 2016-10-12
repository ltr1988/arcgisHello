//
//  SearchHistoryItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHistoryItem.h"
#import "MJExtension.h"

@implementation SearchHistoryItem
+ (NSDictionary *)replacedKeyFromPropertyName
{
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setObject:@"name" forKey:@"name"];
        [dict setObject:@"startDate" forKey:@"startDate"];
        [dict setObject:@"endDate" forKey:@"endDate"];
        [dict setObject:@"id" forKey:@"taskid"];
        
        return dict;
    }
    
}
@end
