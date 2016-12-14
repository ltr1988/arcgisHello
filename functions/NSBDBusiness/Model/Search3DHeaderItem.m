//
//  Search3DHeaderItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/12/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Search3DHeaderItem.h"

@implementation Search3DHeaderItem

@end

@implementation Search3DMANEHeaderItem
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{
             @"keyword" :@"mane",
             @"number":@"manenum",
             };
    
}
@end

@implementation Search3DCategoryHeaderItem
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{
             @"keyword" :@"objtype",
             @"number":@"objtypenum",
             };
    
}
@end
