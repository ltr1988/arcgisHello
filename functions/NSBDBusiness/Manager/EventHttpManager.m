//
//  EventHttpManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventHttpManager.h"
#import "NSDictionary+JSON.h"
#import "HttpHost.h"
#import "SearchSessionItem.h"
#import "AuthorizeManager.h"
#import "AFHTTPSessionManager+NSBD.h"
#import "NSString+UUID.h"
#import "EventReportModel.h"
#import "CheckableTitleItem.h"
#import "TitleDetailItem.h"
#import "TitleDateItem.h"
#import "TitleItem.h"
#import "TitleDetailTextItem.h"

@implementation EventHttpManager
+(instancetype) sharedManager
{
    static EventHttpManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EventHttpManager alloc] init];
    });
    return manager;
}

-(void) requestUploadAttachment:(UIImage *)image fkid:(NSString *)fkid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSString *uuid = [NSString stringWithUUID];
    NSDictionary * info = @{
                            @"type":@"qxyj",//表单不填， qxyj对应事件上报
                            @"username": [AuthorizeManager sharedInstance].userName,
                            @"id":uuid,
                            @"fkid": fkid,
                            @"filetype": @"image", //@"video"
                            @"filename": [uuid stringByAppendingString:@".png"],
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"file" method:@"doInDto" req:info];
    
    [[HttpManager NSBDFileManager] POST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                  NSData *data = UIImagePNGRepresentation(image);
                  [formData appendPartWithFileData:data name:@"file" fileName:@"1test_abcdefg.png" mimeType:@"image/jpeg"];
              } progress:^(NSProgress * _Nonnull uploadProgress) {
                  
              } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  NSDictionary *respDict = [NSDictionary dictWithJson:str];
                  if (success) {
                      dispatch_main_async_safe(^{
                          success(task,respDict);
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

//to be tested
-(void) requestUploadAttachmentMovie:(NSURL *)movieURL fkid:(NSString *)fkid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSString *uuid = [NSString stringWithUUID];
    NSDictionary * info = @{
                            @"type":@"qxyj",//表单不填， qxyj对应事件上报
                            @"username": [AuthorizeManager sharedInstance].userName,
                            @"id":uuid,
                            @"fkid": fkid,
                            @"filetype": @"video", //@"video"
                            @"filename": [uuid stringByAppendingString:@".mov"],
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"file" method:@"doInDto" req:info];
    
    [[HttpManager NSBDFileManager] POST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                  [formData appendPartWithFileURL:movieURL name:@"movie" error:nil];
              } progress:^(NSProgress * _Nonnull uploadProgress) {
                  
              } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  NSDictionary *respDict = [NSDictionary dictWithJson:str];
                  if (success) {
                      dispatch_main_async_safe(^{
                          success(task,respDict);
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

-(void) requestNewEvent:(EventReportModel *)model successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSDictionary * info = @{
                            @"id":[NSString stringWithUUID],
                            @"userName": [AuthorizeManager sharedInstance].userName,
                            @"incidentSource": @"YDSB",
                            @"title": model.eventName.detail?:@"no title",
                            @"occurTime": [formater stringFromDate:[NSDate date]],
                            @"alarmPerson": model.reporter.detail?:@"no person",
                            @"alarmPersonContacts": model.department.detail?:@"no contacts",
                            @"category": model.eventType.detail?:@"no category",
                            @"responseLevel": model.level.detail?:@"no level",
                            @"occurLocation": model.place.detail?:@"no location",
                            @"spacePosition_x": [NSString stringWithFormat:@"%.4f",model.location.x],
                            @"spacePosition_y": [NSString stringWithFormat:@"%.4f",model.location.y],
                            @"description": model.eventStatus.detail?:@"",
                            @"reasons": model.reason.detail?:@"",
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incident" method:@"add" req:info];
    
    
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


-(void) requestHistoryEventWithPage:(NSInteger)page SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"pageNo":@(page),
                            @"pageSize":@(10),
                            @"data":@{
                                    @"userName": [AuthorizeManager sharedInstance].userName,
                                    @"userScope":@"0",  //3 for 我的事件列表 ， 0 for 已完成事件
                                    },
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incident" method:@"queryList" req:info];
    
    
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


-(void) requestMyEventWithPage:(NSInteger)page SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"pageNo":@(page),
                            @"pageSize":@(10),
                            @"data":@{
                                    @"userName": [AuthorizeManager sharedInstance].userName,
                                    @"userScope":@"3",  //3 for 我的事件列表 ， 0 for 已完成事件
                                    },
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incident" method:@"queryList" req:info];
    
    
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

-(void) requestMyEventProgressListWithId:(NSString*) eid SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"id":eid,
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incident" method:@"getProgressList" req:info];
    
    
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
-(void) requestMyDealedEventProgressListWithId:(NSString*) eid SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"id":eid,
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incidentTask" method:@"getDisposeList" req:info];
    
    
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

-(void) requestAddMyEventProgressListWithId:(NSString*) eid
                                   title:(NSString*) title
                               disposeBy:(NSString*) disposeBy
                         SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"incidentId":eid,
                            @"id":[NSString stringWithUUID],
                            @"operate":@"insert",
                            @"state":@"1",
                            @"disposeDescription":title,
                            @"disposeBy":disposeBy, //处置单位
                            @"userName":[AuthorizeManager sharedInstance].userName,
                            @"incidentSource":@"YDSB",
                            @"source":@"IOS",
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incident" method:@"addProgress" req:info];
    
    
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

-(void) requestAddMyEventProgressListWithId:(NSString*) eid
                                      content:(NSString*) content
                            SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"taskId":eid,
                            @"id":[NSString stringWithUUID],
                            @"operate":@"insert",
                            @"state":@"1",
                            @"disposeComment":content,
                            @"userName":[AuthorizeManager sharedInstance].userName,
                            @"incidentSource":@"YDSB",
                            @"source":@"IOS",
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incident" method:@"addDispose" req:info];
    
    
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

-(void) requestMyDealedEventListWithPage:(NSInteger)page SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"pageNo":@(page),
                            @"pageSize":@(10),
                            @"data":@{
                                    @"userName": [AuthorizeManager sharedInstance].userName,
                                    @"status":@"",
                                    },
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incidentTask" method:@"queryList" req:info];
    
    
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

-(void) requestMyDealedEventDetailWithId:(NSString *)eid SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"id":eid,
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incidentTask" method:@"getData" req:info];
    
    
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
