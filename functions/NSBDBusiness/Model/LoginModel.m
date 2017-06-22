//
//  LoginModel.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
+(NSDictionary *)replacedKeyFromPropertyName
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:
                                 [super replacedKeyFromPropertyName]];
    
    [dict setObject:@"data.token" forKey:@"token"];
    [dict setObject:@"data.userid" forKey:@"userid"];
    [dict setObject:@"data.username" forKey:@"username"];
    [dict setObject:@"data.bindingcode" forKey:@"bindingcode"];
    [dict setObject:@"data.bindingpoint" forKey:@"bindingpoint"];
    return dict;
}
@end
