//
//  FacilityInfoModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "FacilityInfoModel.h"
#import "HttpMetaData.h"

@implementation FacilityInfoModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"datalist" :@"data.rows",
             };
    
}

+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[HttpMetaData class] forKey:@"datalist"];
    return dict;
}
@end
