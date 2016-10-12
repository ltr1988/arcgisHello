//
//  SearchCategoryItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchCategoryItem.h"

#import "NSBDBaseUIItem.h"
#import "DGQAirItem.h"


@implementation SearchCategoryItem

+ (NSDictionary *)replacedKeyFromPropertyName
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"facilityCode" forKey:@"facilityCode"];
    [dict setObject:@"id" forKey:@"itemId"];
    [dict setObject:@"facilityId" forKey:@"fid"];
    [dict setObject:@"categoryId" forKey:@"categoryId"];
    [dict setObject:@"addTime.time" forKey:@"timeStamp"];
    [dict setObject:@"facilityType" forKey:@"ftype"];
    [dict setObject:@"facilityName" forKey:@"fname"];
    [dict setObject:@"addUser" forKey:@"addUser"];
    return dict;
    
}

@end

@implementation SearchCategoryItem (TitleOnlyCellViewModel)

-(NSString *) title
{
    return (_fname&& _fname.length>0)?_fname:_facilityCode;
}

@end
