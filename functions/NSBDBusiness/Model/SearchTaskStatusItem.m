//
//  SearchStartItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchTaskStatusItem.h"

@implementation SearchTaskStatusItem

-(instancetype) initWithDict:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSDictionary *dict = dictionary[@"data"];
        if (dict) {
            _tid = dict[@"tid"];
            _name = dict[@"name"];
            _type = dict[@"type"];
        }
    }
    return self;
    
}
@end
