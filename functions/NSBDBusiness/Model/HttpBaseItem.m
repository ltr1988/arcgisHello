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
        self.status = [dict[@"status"] intValue];
    }
    return self;
}

-(void) setStatus:(NSInteger)status
{
    _status = status;
    
    _success = (_status == HttpResultSuccess);
}
@end
