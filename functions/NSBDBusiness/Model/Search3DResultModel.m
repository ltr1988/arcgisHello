//
//  Search3DResultModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Search3DResultModel.h"
#import "Search3DResultItem.h"

@implementation Search3DResultModel
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{@"datalist" :@"modellist",
             };
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[Search3DResultItem class] forKey:@"datalist"];
    return dict;
}
@end
