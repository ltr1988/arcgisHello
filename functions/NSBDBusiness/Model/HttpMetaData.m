//
//  SearchHistoryMetaData.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpMetaData.h"

@implementation HttpMetaData
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"dataID":@"id",
             @"value":@"value",
             
             @"title":@"title",
             };
    
}
@end
