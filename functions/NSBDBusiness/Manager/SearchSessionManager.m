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
#import "HttpHost.h"
#import "SearchSessionItem.h"
#import "AuthorizeManager.h"


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

-(NSMutableDictionary *) paramWithModel:(SearchStartModel*) model sessionID:(NSString *)sessionID
{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *date = [outputFormatter stringFromDate:[NSDate date]];


    NSDictionary *info = @{
                           @"executor":model.searcher.detail,
                           @"exetime":date,
                           @"weather":model.weather.detail,
                           @"auditor":model.searchAdmin.detail,
                           @"status":@"1",
                           @"source":@"iOS",
                           @"id":sessionID,
                           @"userName":[AuthorizeManager sharedInstance].userName};
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"taskbase" method:@"doInDto" req:info];
    return dict;
}
//查询
//state :0暂停 1执行中 2完成 3审核完成 4审核失败
-(void) requestChangeSearchSessionState:(NSInteger)state successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    if (![self hasSession]) {
        return;
    }
    NSDictionary *info = @{
                           @"status":[NSString stringWithFormat:@"%ld",state],
                           @"id":_session.sessionId,
                           @"userName":[AuthorizeManager sharedInstance].userName};
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"taskstart" method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] POST:[HttpHost hostAURLWithParam:dict]
                    parameters:nil
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
                           NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                           NSDictionary *dict = [NSDictionary dictWithJson:str];
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


//开始新任务
-(void) requestNewSearchSessionWithSearchStartModel:(SearchStartModel*) model sessionID:(NSString *)sessionId successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary *param = [self paramWithModel:model sessionID:sessionId];

    [[HttpManager NSBDManager] POST:[HttpHost hostAURLWithParam:param]
                    parameters:nil
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
                           // 请求成功
                           NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                           NSDictionary *dict = [NSDictionary dictWithJson:str];
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

-(void) requestEndSearchSessionWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    
    [self requestChangeSearchSessionState:2 successCallback:success failCallback:fail];
    
}

//巡查query
-(void) requestQueryListSearchSessionWithTaskId:(NSString *) taskid code:(NSString *) code action:(NSString *) action SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary *info = @{
                           @"code":code,
                           @"taskid":taskid,
                           };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"taskfacility" method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] POST:[HttpHost hostAURLWithParam:dict]
                     parameters:nil
                       progress:nil
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
                            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            NSDictionary *dict = [NSDictionary dictWithJson:str];
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

//taskconfig
-(void) requestTaskConfigInSearchSessionSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    if (![self hasSession]) {
        return;
    }
    NSDictionary *info = @{@"id":_session.sessionId};
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"taskconfig" method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] POST:[HttpHost hostAURLWithParam:dict]
                     parameters:nil
                       progress:nil
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
                            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            NSDictionary *dict = [NSDictionary dictWithJson:str];
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
@end
