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

+(NSString *) hostAURL
{
//    return [NSString stringWithFormat:@"http://%@:7001/nsbd/Service/dataSync.do",HOSTIP];
    return [NSString stringWithFormat:@"http://%@:8080/nsbd/Service/dataSync.do",HOSTIP];
}

+(NSString *) host3DURL
{
//    return [NSString stringWithFormat:@"http://%@:81/WebServices/ManagerS.asmx",HOSTIP_3D];
    return [NSString stringWithFormat:@"http://%@:87/WebServices/ManagerS.asmx",HOSTIP_3D];
   
}

+(NSString *) host3DURLWithType:(NSString *)type
{
    return [[self host3DURL] stringByAppendingString:type];
}

+(NSString *) hostAURLWithParam:(NSDictionary *)dict
{
    if (dict && dict.count>0) {
        return [NSString stringWithFormat:@"%@%@",[self hostAURL],[dict httpParamString]];
    }
    return [self hostAURL];
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

@end
