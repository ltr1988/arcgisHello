//
//  HttpHost.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpHost.h"

@implementation HttpHost
+(NSString *) hostURL
{
    NSAssert(NO, @"not enabled url");
    return @"not set";
}

+(NSDictionary *)param
{
    NSDictionary *dict = @{@"Version":@"1.0",
             @"Action":@"",
             @"Method":@"",
             @"AppKey":@"100",
             @"Req":@"",
             @"Signature":@"加密的字符串"};
    return [dict copy];
}

+(NSString *) weatherURL
{
    return @"http://api.map.baidu.com/telematics/v3/weather";
}

+(NSString *) testURL
{
    return @"http://www.baidu.com";
}
@end
