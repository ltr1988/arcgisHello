//
//  SearchHistoryMetaData.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHistoryMetaData.h"

@implementation SearchHistoryMetaData
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"dataID":@"id",
             @"value":@"value",
             };
    
}
@end
