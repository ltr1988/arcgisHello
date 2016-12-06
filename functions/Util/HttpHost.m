//
//  HttpHost.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpHost.h"
#import "AuthorizeManager.h"
#import "NSDictionary+JSON.h"
#import "NSDictionary+HttpParam.h"
#import "CommonDefine.h"

@implementation HttpHost
+(NSString *) hostURL
{
    return [HttpHost testURL];
    NSAssert(NO, @"not enabled url");
    return @"not set";
}

+(NSString *) hostAURL
{
    return [NSString stringWithFormat:@"http://%@:7001/nsbd/Service/dataSync.do",HOSTIP];
}

+(NSString *) hostAURLWithParam:(NSDictionary *)dict
{
    if (dict && dict.count>0) {
        return [NSString stringWithFormat:@"%@%@",[self hostAURL],[dict httpParamString]];
    }
    return [self hostAURL];
}

+(NSString *) hostLogin3DURL
{
    return [HttpHost testURL];
    NSAssert(NO, @"not enabled url");
    return @"not set";
}

+(NSString *) liveDataURL
{
    return [HttpHost testURL];
    NSAssert(NO, @"not enabled url");
    return @"not set";
}

+(NSMutableDictionary *) paramWithAction:(NSString *)action method:(NSString *)method req:(NSDictionary *) req
{
    NSMutableDictionary *dict = [@{@"Version":@"1.0",
                                   @"AppKey":[AuthorizeManager sharedInstance].token,
                                   @"Action":action,
                                   @"Method":method,
                                   } mutableCopy];
    dict[@"Signature"] = [HttpHost SignatureWithInfo:dict];
    dict[@"Req"] = [req.json stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return dict;
}

+(NSString *) SignatureWithInfo:(NSDictionary *)info
{
    return @"";
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
