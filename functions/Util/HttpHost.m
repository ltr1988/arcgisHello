//
//  HttpHost.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpHost.h"

@implementation HttpHost
+(NSString *) weatherURL
{
    return @"http://api.map.baidu.com/telematics/v3/weather";
}

+(NSString *) testURL
{
    return @"http://www.baidu.com";
}
@end
