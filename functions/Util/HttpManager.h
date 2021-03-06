//
//  HttpManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "HttpHost.h"
#import "CommonDefine.h"

#define kLoginTimeout           10.0     //登陆超时时间
#define kForegroundTimeout      15.0    //有前台展现的超时时间
#define kAsynchronousTimeout    30.0    //异步通信超时时间
#define kSynchronousTimeout     180.0   //同步通信超时时间
#define kFileRequestTimeout     300.0   //文件，图片请求的超时时间

typedef void (^HttpSuccessCallback)(NSURLSessionDataTask * task, id dict);
typedef void (^HttpFailCallback)(NSURLSessionDataTask * task, NSError * error);

typedef NS_ENUM(NSUInteger, HttpTaskType) {
    HttpTaskType_Quick,
    HttpTaskType_Foreground,
    HttpTaskType_Asynchronous,
    HttpTaskType_Synchronous,
    HttpTaskType_FileRequest,
    
};

@interface HttpManager : NSObject
+(AFHTTPSessionManager *)loginManager;
+(AFHTTPSessionManager *)NSBDManager;
+(AFHTTPSessionManager *)NSBDFileManager;
+(AFHTTPSessionManager *)jsonManager;
+(AFHTTPSessionManager *)SceneManager;


+(AFHTTPSessionManager *)managerWithType:(HttpTaskType)type;
+(AFHTTPSessionManager *)jsonManagerWithType:(HttpTaskType)type;

@end
