//
//  FacilityManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "FacilityManager.h"
#import "NSDictionary+JSON.h"
#import "NSString+MD5Addition.h"
#import "AFHTTPSessionManager+NSBD.h"

@implementation FacilityManager
+(instancetype) sharedInstance
{
    static FacilityManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FacilityManager new];
    });
    return instance;
}

-(void) requestFacilityWithId:(NSString *)fid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail
{
    NSDictionary * info = @{
                            @"objectnum":fid,
                            };
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"queryfacility" method:@"sbList" req:info];
    
    
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
