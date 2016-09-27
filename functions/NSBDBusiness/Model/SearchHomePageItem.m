//
//  SearchCategoryItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/8/21.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHomePageItem.h"
#import "MJExtension.h"
#import "DGQAirItem.h"
#import "NSBDBaseUIItem.h"

@implementation SearchHomePageItem

+ (NSDictionary *)replacedKeyFromPropertyName
{
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setObject:@"name" forKey:@"title"];
        [dict setObject:@"code" forKey:@"code"];
        return dict;
    }

}

+(NSDictionary *) mappingInfo
{
    return @{
                @"DGQPQJ":[DGQAirItem class],
                @"1":[DGQAirItem class],
                @"2":[DGQAirItem class],
             };
}


-(id) sheetItem
{
    Class cls = [SearchHomePageItem mappingInfo][self.code];
    return [cls new];
}
@end
