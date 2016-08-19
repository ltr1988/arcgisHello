//
//  HttpBaseModel.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"
#import "MJExtension.h"

@implementation HttpBaseModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:
                                 [super replacedKeyFromPropertyName]];
    
    [dict setObject:@"status" forKey:@"status"];
    
    return dict;
}

-(void) setStatus:(NSInteger)status
{
    _status = status;
    
    _success = (_status == HttpResultSuccess);
}
@end
