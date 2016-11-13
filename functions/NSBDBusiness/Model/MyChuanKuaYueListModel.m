//
//  MyChuanKuaYueListModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueListModel.h"
#import "MyChuanKuaYueItem.h"
@implementation MyChuanKuaYueListModel
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
    
    [dict setObject:[MyChuanKuaYueItem class] forKey:@"datalist"];
    return dict;
}


-(BOOL) hasMore
{
    return [_total integerValue] >= 10;
}

@end
