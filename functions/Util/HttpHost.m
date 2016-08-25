//
//  HttpHost.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpHost.h"
#import "TokenManager.h"
#import "NSString+MD5Addition.h"
#import "NSDictionary+JSON.h"

@implementation HttpHost
+(NSString *) hostURL
{
    return [HttpHost testURL];
    NSAssert(NO, @"not enabled url");
    return @"not set";
}

+(NSString *) hostLoginURL
{
    return [HttpHost testURL];
    NSAssert(NO, @"not enabled url");
    return @"not set";
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

+(NSMutableDictionary *) param
{
    NSMutableDictionary *dict = [@{@"Version":@"1.0",
                                   @"AppKey":[TokenManager sharedManager].deviceToken,
                                   } mutableCopy];
    return dict;
}

+(NSString *) SignatureWithInfo:(NSDictionary *)info
{
    return @"";
}

+(NSMutableDictionary *) loginParamWithUser:(NSString *)user password:(NSString *)psw
{
    NSMutableDictionary *dict = [HttpHost param];
    dict[@"Action"] = @"Login";
    dict[@"Method"] = @"login";
    dict[@"Signature"] = [HttpHost SignatureWithInfo:dict];
    
    NSDictionary *info = @{@"userName":user,
                           @"userPwd":[psw stringFromMD5],
                           @"model":[UIDevice currentDevice].model,
                           @"serialnumber":[UIDevice currentDevice].identifierForVendor,
                           @"devicename":[UIDevice currentDevice].name};
    
    dict[@"Req"] = info.json;
    return dict;
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
