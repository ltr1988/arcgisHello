//
//  SearchHistoryModel.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHistoryModel.h"
#import "MJExtension.h"
#import "SearchHistoryItem.h"

@implementation SearchHistoryModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"datalist" :@"data"};
    
}

+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[SearchHistoryItem class] forKey:@"datalist"];
    return dict;
}
@end
