//
//  SearchHistoryDetailSheetModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHistoryDetailSheetModel.h"
#import "HttpMetaData.h"

@implementation SearchHistoryDetailSheetModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"datalist" :@"data.rows",
             };
    
}

+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[HttpMetaData class] forKey:@"datalist"];
    return dict;
}

@end
