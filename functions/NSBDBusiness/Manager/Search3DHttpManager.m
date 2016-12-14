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
    [[HttpManager NSBDManager] ScenePOST:url
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
    [[HttpManager NSBDManager] ScenePOST:url
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
    [self postRequestWithURL:[HttpHost host3DURLWithType:@"/GetModel_mane"] param:nil successCallback:success failCallback:fail];
}

-(void) request3DHeaderCategoryWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    [self postRequestWithURL:[HttpHost host3DURLWithType:@"/GetModel_objtype"] param:nil successCallback:success failCallback:fail];
}

-(void) request3DModelWithObjectnum:(NSString *)objectnum SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    [self postRequestWithURL:[HttpHost host3DURLWithType:@"/GetModelByObjectnum"] param:@{@"objectnum":objectnum} successCallback:success failCallback:fail];
}


-(void) request3DShenMaiWithX:(CGFloat)x y:(CGFloat)y SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary *param = @{@"pointx":@(x),
                            @"pointy":@(y),
                            @"buffer":@(1000),};
    [self postRequestWithURL:[HttpHost host3DURLWithType:@"/QueryNearestMaishen"] param:param successCallback:success failCallback:fail];
}
@end
