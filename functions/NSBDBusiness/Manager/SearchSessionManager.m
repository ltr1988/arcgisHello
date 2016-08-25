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

#import "SearchSessionItem.h"


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
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"current session"];
        self.session = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return self;
}

-(void) setSession:(SearchSessionItem *)session
{
    if (!session)
        _session = [SearchSessionItem new];
    else
        _session = [session copy];
    if (_session && _session.sessionId && _session.sessionId.length>0) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:_session];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"current session"];
    }
}
-(void) setNewSessionWithId:(NSString *)sessionId
{
    _session = [SearchSessionItem new];
    _session.sessionId = sessionId;
    _session.sessionStartTime = [[NSDate date] timeIntervalSince1970];
}

-(BOOL) hasSession
{
    return (_session && _session.sessionId && _session.sessionId.length>0);
}

-(void) requestNewSearchSessionWithSearchStartModel:(SearchStartModel*) model successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSString *sessionId = [[SearchSessionManager sharedManager] session].sessionId;
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
