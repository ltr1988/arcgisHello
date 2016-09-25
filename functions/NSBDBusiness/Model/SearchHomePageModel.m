//
//  SearchHomePageModel.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHomePageModel.h"
#import "SearchCategoryItem.h"
#import "MJExtension.h"

@implementation SearchHomePageModel


+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{@"datalist" :@"data"};
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[SearchCategoryItem class] forKey:@"datalist"];
    return dict;
}

@end
