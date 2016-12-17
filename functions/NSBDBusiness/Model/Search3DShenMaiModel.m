//
//  Search3DShenMaiModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Search3DShenMaiModel.h"

#import "Search3DShenMaiItem.h"

@implementation Search3DShenMaiModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"datalist" :@"maishenlist",
             };
    
}

+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[Search3DShenMaiItem class] forKey:@"datalist"];
    return dict;
}@end
