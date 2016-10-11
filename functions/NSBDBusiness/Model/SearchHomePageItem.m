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
#import "DGQWellItem.h"
#import "DGQWaterItem.h"
#import "NSBDBaseUIItem.h"
#import "DGQLine.h"

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
                @"DGQPKJ":[DGQWellItem class],
                @"DGQFSK":[DGQWaterItem class],
                @"DGQGX":[DGQLine class],
                
                @"DNPKJ":[DGQWellItem class],
                @"DNPQJ":[DGQWellItem class],
                @"DNGX":[DGQWellItem class],
                
                @"NGQGX":[DGQWellItem class],
                @"NGQPQJDOWN":[DGQWellItem class],
                @"NGQPQJUP":[DGQWellItem class],
                @"NGQPKJDOWN":[DGQWellItem class],
                @"NGQPKJUP":[DGQWellItem class],
             };
}


-(id) sheetItem
{
    Class cls = [SearchHomePageItem mappingInfo][self.code];
    return [cls new];
}
@end
