//
//  HttpBaseItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseItem.h"

@implementation HttpBaseItem

-(instancetype) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _success = ([dict[@"status"] intValue] ==100);
    }
    return self;
}
@end
