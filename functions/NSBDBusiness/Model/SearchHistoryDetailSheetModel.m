//
//  SearchHistoryDetailSheetModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHistoryDetailSheetModel.h"
#import "SearchHistoryMetaData.h"

@implementation SearchHistoryDetailSheetModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"datalist" :@"data.rows",
             };
    
}

+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[SearchHistoryMetaData class] forKey:@"datalist"];
    return dict;
}

@end
