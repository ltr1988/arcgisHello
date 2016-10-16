//
//  MyEventListModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventListModel.h"
#import "MyEventItem.h"

@implementation MyEventListModel
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
    
    [dict setObject:[MyEventItem class] forKey:@"datalist"];
    return dict;
}


-(BOOL) hasMore
{
    return [_total integerValue] >= 10;
}
@end
