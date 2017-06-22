//
//  SearchHistoryManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHistoryManager.h"
#import "NSString+LVPath.h"
#import "AuthorizeManager.h"
#import "NSDateFormatterHelper.h"

#import "AFHTTPSessionManager+NSBD.h"

#define SEARCH_HISTORY_DATE_KEY    [NSString stringWithFormat:@"search_history_date_%@",[[AuthorizeManager sharedInstance] userName]]
#define SEARCH_HISTORY_CACHE_KEY    [NSString stringWithFormat:@"search_history_cache_%@",[[AuthorizeManager sharedInstance] userName]]

@interface SearchHistoryManager()
@property (nonatomic,strong) NSMutableArray *cache;

@end

@implementation SearchHistoryManager
+(instancetype) sharedManager
{
    static SearchHistoryManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SearchHistoryManager alloc] init];
    });
    return manager;
}

-(BOOL) saveCache
{
    NSString *path = [[NSString documentsPath] stringByAppendingPathComponent:SEARCH_HISTORY_CACHE_KEY];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    return [_cache writeToFile:path atomically:YES];
}

#pragma mark search history list
-(void) requestSearchHistoryListWithPage:(NSInteger)page SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{

    NSDictionary * info = @{
                            @"pageNo":@(page),
                            @"pageSize":@(10),
                            @"data":@{
                                    @"userName": [AuthorizeManager sharedInstance].userName,
                                    @"userScope":@"0",
                                    },
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"queryhistory" method:@"doInDto" req:info];
    
    
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

#pragma mark search query info
-(void) requestSearchHistoryQueryInfo:(id) qinfo SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:SEARCH_HISTORY_DATE_KEY
                    ];
    if (!date) {
        
    }
    
    
    NSDateFormatter *formater = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd-HH:mm:ss"];
 
    NSDictionary * info = @{
                            @"userName": [AuthorizeManager sharedInstance].userName,
                            
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

#pragma mark task config for history
-(void) requestTaskConfigInSearchSessionWithTaskId:(NSString *)taskid SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    if (!taskid || taskid.length==0) {
        return;
    }
    NSDictionary *info = @{@"id":taskid};
    
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
@end
