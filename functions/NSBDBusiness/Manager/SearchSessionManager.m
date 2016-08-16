//
//  SearchSessionManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSessionManager.h"


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

-(void) requestNewSearchSessionWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    [[HttpManager manager] GET:[HttpHost testURL]
                    parameters:nil
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
                           // 请求成功
                           dispatch_main_async_safe(^{
                               self.sessionId = @"a";//from dict
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
    [[HttpManager manager] GET:[HttpHost testURL]
                    parameters:nil
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
                           // 请求成功
                           dispatch_main_async_safe(^{
                               self.sessionId = @"";
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
