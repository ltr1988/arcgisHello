//
//  SearchSessionManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSessionManager.h"
#import "SearchStartModel.h"
#import "NSDictionary+JSON.h"
@implementation SearchSessionManager
+(instancetype) sharedManager
{
    static SearchSessionManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SearchSessionManager alloc] init];
    });
    return manager;
}

-(instancetype) init
{
    self = [super init];
    if (self) {
        self.sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"current search id"];
    }
    return self;
}

-(void) setSessionId:(NSString *)sid
{
    _sessionId = [sid copy];
    if (sid && sid.length>0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:sid forKey:@"current search id"];
    }
}

-(BOOL) hasSession
{
    return (_sessionId && _sessionId.length>0);
}

-(void) requestNewSearchSessionWithSearchStartModel:(SearchStartModel*) model successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSString *sessionId = [[SearchSessionManager sharedManager] sessionId];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *date = [outputFormatter stringFromDate:[NSDate date]];
    NSDictionary *info = @{@"taskid":sessionId,
                           @"executor":model.searcher.detail,
                           @"exetime":date,
                           @"weather":model.weather.detail,
                           @"auditor":model.searchAdmin.detail};
    
    NSDictionary *param = @{@"Req":info.json};

    [[HttpManager manager] GET:[HttpHost hostURL]
                    parameters:param
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
                           // 请求成功
                           dispatch_main_async_safe(^{
                               success(task,dict);
                           });
                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           // 请求失败
                           dispatch_main_async_safe(^{
                               fail(task,error);
                           });
                       }];

}

-(void) requestEndSearchSessionWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    [[HttpManager manager] GET:[HttpHost hostURL]
                    parameters:nil
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
                           // 请求成功
                           dispatch_main_async_safe(^{
                               success(task,dict);
                           });
                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           // 请求失败
                           dispatch_main_async_safe(^{
                               fail(task,error);
                           });
                       }];
    
}
@end
