//
//  Search3DResultItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Search3DResultItem.h"
#import "MJExtension.h"

@implementation Search3DResultItem


+ (NSArray *)allowedCodingPropertyNames
{
    return @[@"title",@"mane",@"modelpath"];
}
MJCodingImplementation

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"title" :@"modelname",
             @"mane":@"mane",
             @"modelpath":@"modelpath",
             };
    
}
@end
