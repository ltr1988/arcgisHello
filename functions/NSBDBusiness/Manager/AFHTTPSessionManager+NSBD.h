//
//  AFHTTPSessionManager+NSBD.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFHTTPSessionManager (NSBD)
- (NSURLSessionDataTask *)NSBDPOST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


- (NSURLSessionDataTask *)NSBDDownloadPOST:(NSString *)URLString
                                parameters:(id)parameters
                                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)SceneGet:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)ScenePOST:(NSString *)URLString
                         parameters:(id)parameters
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)XMLPOST:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
