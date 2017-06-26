//
//  AFHTTPSessionManager+NSBD.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "AFHTTPSessionManager+NSBD.h"
#import "NSDictionary+JSON.h"
#import "GDataXMLNode.h"

@implementation AFHTTPSessionManager (NSBD)
- (NSURLSessionDataTask *)NSBDPOST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSUTF8StringEncoding
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSDictionary dictWithJson:str];
        if (dict[@"msg"] && [dict[@"msg"] isEqualToString:@"token令牌失效！"]) {
            NSMutableDictionary *mDict = [dict mutableCopy];
            mDict[@"status"]=@"304";
            dict = [mDict copy];
        }
        if (success) {
            success(task,dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        NSLog(@"%@", error);
    }];
}

- (NSURLSessionDataTask *)ScenePOST:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSUTF8StringEncoding
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSDictionary dictWithJson:str];
        if (success) {
            success(task,dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        NSLog(@"%@", error);
    }];
}

- (NSURLSessionDataTask *)SceneGet:(NSString *)URLString
                         parameters:(id)parameters
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSUTF8StringEncoding
//        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//        NSString *str = [[NSString alloc] initWithData:responseObject encoding:enc];
        
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSDictionary dictWithJson:str];
        if (success) {
            success(task,dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        NSLog(@"%@", error);
    }];
}

- (NSURLSessionDataTask *)SceneGeT:(NSString *)URLString
                         parameters:(id)parameters
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSUTF8StringEncoding
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSDictionary dictWithJson:str];
        if (success) {
            success(task,dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        NSLog(@"%@", error);
    }];
}

- (NSURLSessionDataTask *)XMLPOST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSUTF8StringEncoding
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:str error:nil];
        if (success) {
            success(task,doc);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        NSLog(@"%@", error);
    }];
}

- (NSURLSessionDataTask *)NSBDDownloadPOST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSDictionary dictWithJson:str];
        if (dict) {
            if (failure) {
                failure(task,nil);
            }
        }else
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
}
@end
