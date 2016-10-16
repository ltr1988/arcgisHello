//
//  MyDealedEventListModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyDealedEventListModel.h"
#import "MyDealedEventItem.h"

@implementation MyDealedEventListModel
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
    
    [dict setObject:[MyDealedEventItem class] forKey:@"datalist"];
    return dict;
}


-(BOOL) hasMore
{
    return [_total integerValue] >= 10;
}

@end
