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
#import "AuthorizeManager.h"
#import "AFHTTPSessionManager+NSBD.h"
#import "NSBDBaseUIItem.h"
#import "NSString+UUID.h"
#import "NSDateFormatterHelper.h"

#define CURRENT_SESSION [NSString stringWithFormat:@"current_session_%@",[[AuthorizeManager sharedInstance] userName]]
@implementation SearchSessionManager

static SearchSessionManager* manager = nil;
+(instancetype) sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SearchSessionManager alloc] init];
    });
    return manager;
}

+(void) changeUser
{
    manager = [[SearchSessionManager alloc] init];
}

-(instancetype) init
{
    self = [super init];
    if (self) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_SESSION];
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
    [self localizeSession];
}

-(void) localizeSession
{
    if (_session && _session.sessionId && _session.sessionId.length>0) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:_session];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:CURRENT_SESSION];
    }
}
-(void) setNewSessionWithId:(NSString *)sessionId
{
    _session = [SearchSessionItem new];
    _session.sessionId = sessionId;
    _session.sessionStartTime = [[NSDate date] timeIntervalSince1970];
    [self localizeSession];
}

-(void) setCurrentSessionWithBasicInfo:(SearchStartModel *)basicInfo
{
    if (_session) {
        _session.basicInfo = basicInfo;
        [self localizeSession];
    }
}

-(BOOL) hasSession
{
    return (_session && _session.sessionId.length>0);
}

-(NSMutableDictionary *) paramWithModel:(SearchStartModel*) model sessionID:(NSString *)sessionID
{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSString *date = [outputFormatter stringFromDate:model.date.date];

//{"starttime":"2018-03-17 22:39:35","timekeeping":"00:00","auditor":"0dca6b78-87e0-4e3a-a06f-0b9b957ce89d","status":"1","executor":"1","xctasktypename":"常规","type":"0","id":"01399bbf-8fb6-41d3-83d7-a65682c3bc59","exetime":"2018-03-17 22:39:35","xcglyname":"南干测试1","source":"Android","name":"ngqglc","userName":"ngqglc","weather":"阴转雾","isnew":"0"}
    NSDictionary *info = @{
                           @"executor":model.searcher.detail,
                           @"exetime":date,
                           @"xctasktypename":model.taskTypeName.title,
                           @"timekeeping":@"00:00",
                           @"weather":model.weather.detail,
                           @"auditor":model.searchAdmin.detail,
                           @"status":@"1",
                           @"source":@"IOS",
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
    
    
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
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

-(void) requestUpdateLocationWithX:(double) x y:(double)y height:(double)h successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    if (!self.session.sessionId || self.session.pauseState)
    {
        if (fail) fail(nil,nil);
        return;
    }
    
    NSDateFormatter *formater = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDictionary *info = @{
                           @"id":[NSString stringWithUUID],
                           @"taskid":self.session.sessionId,
                           @"adduser":[AuthorizeManager sharedInstance].userName,
                           @"longitude":[NSString stringWithFormat:@"%f",x],
                           @"latitude":[NSString stringWithFormat:@"%f",y],
                           @"height":[NSString stringWithFormat:@"%f",h],
                           @"exedate": [formater stringFromDate:[NSDate date]],
                           };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"track" method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
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
//开始新任务
-(void) requestNewSearchSessionWithSearchStartModel:(SearchStartModel*) model sessionID:(NSString *)sessionId successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary *param = [self paramWithModel:model sessionID:sessionId];
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:param]
                             parameters:nil
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
    
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
                     parameters:nil
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


-(void) requestQueryHistoryLineListSearchSessionWithTaskId:(NSString *) taskid code:(NSString *) code action:(NSString *) action SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary *info = @{
                           @"taskid":taskid,
                           @"ishistory":@"Y",
                           };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:action method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
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

-(void) requestQueryHistoryWellSearchSessionWithTaskId:(NSString *) taskid wellnum:(NSString *) wellnum action:(NSString *) action SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary *info = @{
                           @"source":@"IOS",
                           @"taskid":taskid,
                           @"state":@"1",
                           @"wellnum":wellnum,
                           };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:action method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
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

-(void) requestQueryHistoryListSearchSessionWithTaskId:(NSString *) taskid code:(NSString *) code action:(NSString *) action SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary *info = @{
                           @"code":code,
                           @"taskid":taskid,
                           @"ishistory":@"Y",
                           };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"taskfacility" method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
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


//taskconfig
-(void) requestTaskConfigInSearchSessionSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    if (![self hasSession]) {
        return;
    }
    NSDictionary *info = @{@"id":_session.sessionId};
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"taskconfig" method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
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

-(void) requestUploadSheetWithItem:(NSBDBaseUIItem *) item SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary *info = item.requestInfo;
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:item.actionKey method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
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

-(void) requestQueryTaskFinishedStatusWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary *info = @{
                           @"userid":[AuthorizeManager sharedInstance].userid,
                           };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"tasknotfinished" method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
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

-(void) requestQueryInspectAdminWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback)fail
{
    NSDictionary *info = @{
                           @"userid":[AuthorizeManager sharedInstance].userid,
                           @"source":@"iOS",
                           };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"inspectadmin" method:@"doInDto" req:info];
    
    [[HttpManager NSBDManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
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

@end
