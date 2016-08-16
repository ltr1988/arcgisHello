//
//  HttpManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"


#define kForegroundTimeout      15.0    //有前台展现的超时时间
#define kAsynchronousTimeout    30.0    //异步通信超时时间
#define kSynchronousTimeout     180.0   //同步通信超时时间
#define kFileRequestTimeout     300.0   //文件，图片请求的超时时间

typedef NS_ENUM(NSUInteger, HttpTaskType) {
    HttpTaskType_Foreground,
    HttpTaskType_Asynchronous,
    HttpTaskType_Synchronous,
    HttpTaskType_FileRequest,
    
};

@interface HttpManager : NSObject
+(AFHTTPSessionManager *)manager;
+(AFHTTPSessionManager *)jsonManager;


+(AFHTTPSessionManager *)managerWithType:(HttpTaskType)type;
+(AFHTTPSessionManager *)jsonManagerWithType:(HttpTaskType)type;

@end
