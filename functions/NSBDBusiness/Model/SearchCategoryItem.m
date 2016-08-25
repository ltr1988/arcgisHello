//
//  SearchCategoryItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/8/21.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchCategoryItem.h"
#import "MJExtension.h"
#import "DGQAirItem.h"
#import "NSBDBaseUIItem.h"

@implementation SearchCategoryItem

+ (NSDictionary *)replacedKeyFromPropertyName
{
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setObject:@"title" forKey:@"title"];
        [dict setObject:@"code" forKey:@"code"];
        return dict;
    }

}

+(NSDictionary *) mappingInfo
{
    return @{
                @"0":[DGQAirItem class],
                @"1":[DGQAirItem class],
                @"2":[DGQAirItem class],
             };
}


-(id) sheetItem
{
    Class cls = [SearchCategoryItem mappingInfo][self.code];
    return [cls new];
}
@end