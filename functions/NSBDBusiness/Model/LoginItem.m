//
//  LoginItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LoginItem.h"

@implementation LoginItem
-(instancetype) initWithDict:(NSDictionary *)dictionary
{
    self = [super initWithDict:dictionary];
    if (self) {
        NSDictionary *dict = dictionary[@"data"];
        if (dict) {
            _department = dict[@"department"];
        }
    }
    return self;
    
}
@end
