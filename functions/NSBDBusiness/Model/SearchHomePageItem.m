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
#import "DGQLine.h"
#import "NGQAirItem.h"
#import "NGQWellItem.h"
#import "NGQLine.h"
#import "DNAirItem.h"
#import "DNWellItem.h"
#import "DNLine.h"
#import "NGQAirUpItem.h"
#import "NGQAirDownItem.h"
#import "NGQWellUpItem.h"
#import "NGQWellDownItem.h"
#import "NSBDBaseUIItem.h"
#import "TCHTankItem.h"
#import "TCHWaterItem.h"
#import "TCHSluiceItem.h"

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
                
                @"DNPKJ":[DNWellItem class],
                @"DNPQJ":[DNAirItem class],
                @"DNGX":[DNLine class],
                
                @"NGQGX":[NGQLine class],
                @"NGQPQJDOWN":[NGQAirDownItem class],
                @"NGQPQJUP":[NGQAirUpItem class],
                @"NGQPKJDOWN":[NGQWellDownItem class],
                @"NGQPKJUP":[NGQWellUpItem class],
                
                @"TCHTJC":[TCHTankItem class],
                @"TCHFZ":[TCHSluiceItem class],
                @"TCHFSK":[TCHWaterItem class],
             };
}


-(NSString *)shortCode
{
    return [self.code componentsSeparatedByString:@"_"].firstObject;
}

-(id) sheetItem
{
    Class cls = [SearchHomePageItem mappingInfo][self.shortCode];
    return [cls new];
}
@end
