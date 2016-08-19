//
//  SearchHomePageModel.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHomePageModel.h"
#import "MJExtension.h"

@implementation SearchHomePageModel
+(NSDictionary *) replacedKeyFromPropertyName
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:
                                 [super replacedKeyFromPropertyName]];
    
    [dict setObject:@"taskid" forKey:@"tid"];
    [dict setObject:@"name" forKey:@"name"];
    [dict setObject:@"type" forKey:@"type"];
    return dict;
}

@end
