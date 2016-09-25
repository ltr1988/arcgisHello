//
//  SearchCategoryModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchCategoryModel.h"
#import "SearchCategoryItem.h"

@implementation SearchCategoryModel
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
