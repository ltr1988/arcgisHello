//
//  SearchStartItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchTaskStatusModel.h"
#import "MJExtension.h"

@implementation SearchTaskStatusModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:
                                 [super replacedKeyFromPropertyName]];
    
    [dict setObject:@"taskid" forKey:@"tid"];
    [dict setObject:@"name" forKey:@"name"];
    [dict setObject:@"type" forKey:@"type"];
    return dict;
}

@end
