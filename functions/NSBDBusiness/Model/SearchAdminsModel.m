//
//  SearchAdminsModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/25.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "SearchAdminsModel.h"

@implementation SearchAdminsModel
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{@"datalist" :@"data"};
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[SearchAdminItem class] forKey:@"datalist"];
    return dict;
}

@end
