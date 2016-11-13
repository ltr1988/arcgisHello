//
//  EventHttpManager+ChuanKuaYue.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventHttpManager+ChuanKuaYue.h"
#import "AuthorizeManager.h"
#import "AFHTTPSessionManager+NSBD.h"

@implementation EventHttpManager (ChuanKuaYue)


-(void) requestQueryChuanKuaYueWithPage:(NSInteger)page SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"pageNo":@(page),
                            @"pageSize":@(10),
                            @"data":@{
                                    @"userCode": [AuthorizeManager sharedInstance].userName,
                                    @"code":@"arcoss",
                                    @"type":@"ledger",
                                    },
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"common" method:@"queryPage" req:info];
    
    
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


-(void) requestQueryChuanKuaYueDetailWithID:(NSString *)theID SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"pageNo":@(1),
                            @"pageSize":@(10),
                            @"data":@{
                                    @"userCode": [AuthorizeManager sharedInstance].userName,
                                    @"code":@"arcoss",
                                    @"type":@"ledger",
                                    @"queryParam":[NSString stringWithFormat:@"ID,EQ,%@",theID],
                                    @"isLoadFile":@"true",
                                    },
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"common" method:@"queryPage" req:info];
    
    
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


-(void) requestQueryHistoryChuanKuaYueWithPage:(NSInteger)page ID:(NSString *)theID SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"pageNo":@(page),
                            @"pageSize":@(10),
                            @"data":@{
                                    @"userCode": [AuthorizeManager sharedInstance].userName,
                                    @"code":@"history",
                                    @"type":@"across",
                                    @"queryParam":[NSString stringWithFormat:@"ACROSSCODE,EQ,%@",theID],
                                    },
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"common" method:@"queryPage" req:info];
    
    
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


-(void) requestAddMyChuanKuaYueProgressListWithId:(NSString *)uuid
                                         acrossId:(NSString *)acrossId
                                       acrossName:(NSString *)acrossName
                                       acrossCode:(NSString *)acrossCode
                                          content:(NSString *)content
                                  SuccessCallback:(HttpSuccessCallback) success
                                     failCallback:(HttpFailCallback) fail
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSDictionary * info = @{
                            @"userCode":[AuthorizeManager sharedInstance].userName,
                            @"id":uuid,
                            @"acrossId":acrossId,
                            @"acrossName":acrossName,
                            @"acrossCode":acrossCode,
                            @"btime":[formater stringFromDate:[NSDate date]],
                            @"content":content,
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"supervise" method:@"doInDto" req:info];
    
    
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


-(void) requestQueryHistoryChuanKuaYueProgressWithPage:(NSInteger)page AcrossCode:(NSString *)acrossCode SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"pageNo":@(page),
                            @"pageSize":@(10),
                            @"data":@{
                                    @"userCode": [AuthorizeManager sharedInstance].userName,
                                    @"code":@"supervise",
                                    @"type":@"across",
                                    @"queryParam":[NSString stringWithFormat:@"ACROSSCODE,EQ,%@;CHECKSTATE,EQ,1;",acrossCode],
                                    @"isLoadFile":@"true",
                                    },
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"common" method:@"queryPage" req:info];
    
    
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
-(void) requestQueryMyChuanKuaYueProgressWithPage:(NSInteger)page AcrossCode:(NSString *)acrossCode SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"pageNo":@(page),
                            @"pageSize":@(10),
                            @"data":@{
                                    @"userCode": [AuthorizeManager sharedInstance].userName,
                                    @"code":@"supervise",
                                    @"type":@"across",
                                    @"queryParam":[NSString stringWithFormat:@"ACROSSCODE,EQ,%@;CREATORID,EQ,%@;",acrossCode,[AuthorizeManager sharedInstance].userName],
                                    @"isLoadFile":@"true",
                                    },
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"common" method:@"queryPage" req:info];
    
    
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
