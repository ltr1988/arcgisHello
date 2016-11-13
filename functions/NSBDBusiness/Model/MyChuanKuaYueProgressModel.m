//
//  MyChuanKuaYueProgressModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueProgressModel.h"
#import "MyChuanKuaYueProgressItem.h"

@implementation MyChuanKuaYueProgressModel
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
    
    [dict setObject:[MyChuanKuaYueProgressItem class] forKey:@"datalist"];
    return dict;
}


-(BOOL) hasMore
{
    return [_total integerValue] >= 10;
}

@end
