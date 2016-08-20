//
//  LoginItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LoginItem.h"
#import "MJExtension.h"

@implementation LoginItem

+(NSDictionary *)replacedKeyFromPropertyName
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"department" forKey:@"department"];
    return dict;
}

@end
