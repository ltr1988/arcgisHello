//
//  Search3DHeaderModel.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/12/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Search3DHeaderModel.h"
#import "Search3DHeaderItem.h"

@implementation Search3DHeaderModel
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{@"datalist" :@"data.rows",
             @"datalist2" :@"data.rows2",
             };
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[Search3DHeaderItem class] forKey:@"datalist"];
    [dict setObject:[Search3DHeaderItem class] forKey:@"datalist2"];
    return dict;
}

@end
