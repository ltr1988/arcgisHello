//
//  SearchAdminItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/25.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "SearchAdminItem.h"

@implementation SearchAdminItem
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"adminID":@"ID",
             @"name":@"NAME",};
    
}
@end
