//
//  Search3DHttpManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/12/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Search3DHttpManager.h"
#import "NSDictionary+JSON.h"
#import "NSString+MD5Addition.h"
#import "AFHTTPSessionManager+NSBD.h"

@implementation Search3DHttpManager
+(instancetype) sharedManager
{
    static Search3DHttpManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[Search3DHttpManager alloc] init];
    });
    return manager;
}

-(void) getRequestWithURL:(NSString *)url param:(NSDictionary *)param successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    [[HttpManager SceneManager] SceneGet:url
                              parameters:param
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
                                     // 请求成功
                                     if (success) {
                                         dispatch_main_async_safe(^{
                                             success(task,dict);
                                         });
                                     }
                                     
                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     // 请求失败
                                     if (fail) {
                                         dispatch_main_async_safe(^{
                                             fail(task,error);
                                         });
                                     }
                                 }];
    
}

-(void) postRequestWithURL:(NSString *)url param:(NSDictionary *)param successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    [[HttpManager SceneManager] ScenePOST:url
                               parameters:param
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
                                     // 请求成功
                                     if (success) {
                                         dispatch_main_async_safe(^{
                                             success(task,dict);
                                         });
                                     }
                                     
                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     // 请求失败
                                     if (fail) {
                                         dispatch_main_async_safe(^{
                                             fail(task,error);
                                         });
                                     }
                                 }];
    
}


-(void) request3DHeaderMANEWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    [self getRequestWithURL:[HttpHost host3DURLWithType:@"/GetModel_mane"] param:nil successCallback:success failCallback:fail];
}

-(void) request3DHeaderCategoryWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    [self getRequestWithURL:[HttpHost host3DURLWithType:@"/GetModel_objtype"] param:nil successCallback:success failCallback:fail];
}

-(void) request3DModelWithObjectnum:(NSString *)objectnum SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    [self getRequestWithURL:[HttpHost host3DURLWithType:@"/GetModelByObjectnum"] param:@{@"objectnum":objectnum} successCallback:success failCallback:fail];
}

-(void) request3DModelWithKey:(NSString *)key mane:(NSString *)mane category:(NSString *)category SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSStringEncoding enc = NSUTF8StringEncoding;
    key = [key stringByAddingPercentEscapesUsingEncoding:enc];
    category = [category stringByAddingPercentEscapesUsingEncoding:enc];
    mane = [mane stringByAddingPercentEscapesUsingEncoding:enc];

    NSDictionary *param = @{@"objtype":category,
                            @"mane":mane,
                            @"modelname":key,};
    NSString *url = [NSString stringWithFormat:@"%@?objtype=%@&mane=%@&modelname=%@",[HttpHost host3DURLWithType:@"/GetModel_ByCondition"],category,mane,key];
    [self getRequestWithURL:url param:nil successCallback:success failCallback:fail];
}


-(void) request3DShenMaiWithX:(CGFloat)x y:(CGFloat)y SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary *param = @{@"pointx":@(x),
                            @"pointy":@(y),
                            @"buffer":@(3200),};
    [self getRequestWithURL:[HttpHost host3DURLWithType:@"/QueryNearestMaishen1"] param:param successCallback:success failCallback:fail];
}
@end
