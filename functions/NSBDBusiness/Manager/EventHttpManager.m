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


#pragma mark file

-(void) requestUploadAttachment:(UIImage *)image fkid:(NSString *)fkid qxyjFlag:(BOOL) isQxyj successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSString *uuid = [NSString stringWithUUID];
    NSMutableDictionary * info = [@{
                            @"username": [AuthorizeManager sharedInstance].userName,
                            @"id":uuid,
                            @"fkid": fkid,
                            @"filetype": @"image", //@"video"
                            @"filename": [uuid stringByAppendingString:@".png"],
                            } mutableCopy];
    if (isQxyj)
        info[@"type"]=@"qxyj";//表单不填， qxyj对应事件上报
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"file" method:@"doInDto" req:info];
    
    [[HttpManager NSBDFileManager] POST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                  NSData *data = UIImagePNGRepresentation(image);
                  [formData appendPartWithFileData:data name:@"file" fileName:[uuid stringByAppendingString:@".png"] mimeType:@"image/jpeg"];
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
-(void) requestUploadAttachmentMovie:(NSURL *)movieURL fkid:(NSString *)fkid qxyjFlag:(BOOL) isQxyj successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSString *uuid = [NSString stringWithUUID];
    NSMutableDictionary * info = [@{
                            @"username": [AuthorizeManager sharedInstance].userName,
                            @"id":uuid,
                            @"fkid": fkid,
                            @"filetype": @"video", //@"video"
                            @"filename": [uuid stringByAppendingString:@".mp4"],
                            } mutableCopy];
    
    if (isQxyj)
        info[@"type"]=@"qxyj";//表单不填， qxyj对应事件上报
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"file" method:@"doInDto" req:info];
    
    [[HttpManager NSBDFileManager] POST:[HttpHost hostAURLWithParam:dict]
                             parameters:nil
              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                  NSData *data = [NSData dataWithContentsOfURL:movieURL];
                  [formData appendPartWithFileData:data name:@"file" fileName:[uuid stringByAppendingString:@".mp4"] mimeType:@"video/mp4"];
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

-(void) requestQueryAttachmentListWithId:(NSString *)fkid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"id": fkid,
                            };
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incident" method:@"getData" req:info];
    
    [[HttpManager NSBDFileManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
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

-(void) requestQuerySearchAttachmentListWithId:(NSString *)fkid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"fkid": fkid,
                            };
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"file" method:@"fileList" req:info];
    
    [[HttpManager NSBDFileManager] NSBDPOST:[HttpHost hostAURLWithParam:dict]
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

-(void) requestDownloadAttachmentWithId:(NSString *)fkid qxyjFlag:(BOOL)isqxyj successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSMutableDictionary * info = [@{
                            @"id": fkid,
                            } mutableCopy];
    if (isqxyj) {
        info[@"type"]=@"qxyj";
    }
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"file" method:@"downLoad" req:info];
    
    
    
//    [self downloadTask:[HttpHost hostAURLWithParam:dict]];
    [[HttpManager NSBDFileManager] NSBDDownloadPOST:[HttpHost hostAURLWithParam:dict]
                                 parameters:nil
                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
                                        // 请求成功
                                        if (success) {
                                            dispatch_main_async_safe(^{
                                                success(task,data);
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

#pragma mark business

-(void) requestNewEvent:(EventReportModel *)model successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    [model parseEventModelToHttpModel];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSDictionary * info = @{
                            @"id":model.uuid,
                            @"userName": [AuthorizeManager sharedInstance].userName,
                            @"incidentSource": @"YDSB",
                            @"title": model.eventName.detail?:@"no title",
                            @"occurTime": [formater stringFromDate:[NSDate date]],
//                            @"alarmPerson": @"no person",
//                            @"alarmPersonContacts": @"no contacts",
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
                                       uuid:(NSString *)uuid
                                   title:(NSString*) title
                               disposeBy:(NSString*) disposeBy
                         SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"incidentId":eid,
                            @"id":uuid,
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
                                       uuid:(NSString *) uuid
                                      content:(NSString*) content
                            SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"taskId":eid,
                            @"id":uuid,
                            @"operate":@"insert",
                            @"state":@"1",
                            @"disposeComment":content,
                            @"userName":[AuthorizeManager sharedInstance].userName,
                            @"incidentSource":@"YDSB",
                            @"source":@"IOS",
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"incidentTask" method:@"addDispose" req:info];
    
    
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
