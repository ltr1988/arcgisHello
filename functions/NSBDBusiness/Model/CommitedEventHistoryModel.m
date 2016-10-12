//
//  MyEventHistoryModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "CommitedEventHistoryModel.h"
#import "MyEventHistoryItem.h"

@implementation CommitedEventHistoryModel
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{@"datalist" :@"data",
             @"total" :@"total",
             @"pageNo" :@"pageNo",
             };
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[MyEventHistoryItem class] forKey:@"datalist"];
    return dict;
}
@end
