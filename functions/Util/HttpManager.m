//
//  HttpManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager
#pragma mark - 创建请求者

+(AFHTTPSessionManager *)loginManager
{
    return [HttpManager managerWithType:HttpTaskType_Quick];
}

+(AFHTTPSessionManager *)NSBDManager
{
    return [HttpManager managerWithType:HttpTaskType_Foreground];
}

+(AFHTTPSessionManager *)jsonManager
{
    return [HttpManager jsonManagerWithType:HttpTaskType_Foreground];
}

+(AFHTTPSessionManager *)managerWithType:(HttpTaskType)type
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    switch (type) {
            
        case HttpTaskType_Quick: {
            
            manager.requestSerializer.timeoutInterval = kLoginTimeout;
            break;
        }
        case HttpTaskType_Foreground: {
            
            manager.requestSerializer.timeoutInterval = kForegroundTimeout;
            break;
        }
        case HttpTaskType_Asynchronous: {
            
            manager.requestSerializer.timeoutInterval = kAsynchronousTimeout;
            break;
        }
        case HttpTaskType_Synchronous: {
            
            manager.requestSerializer.timeoutInterval = kSynchronousTimeout;
            break;
        }
        case HttpTaskType_FileRequest: {
            
            manager.requestSerializer.timeoutInterval = kFileRequestTimeout;
            break;
        }
        default:
        {
            
            manager.requestSerializer.timeoutInterval = kForegroundTimeout;
            break;
        }
    }
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}

+(AFHTTPSessionManager *)jsonManagerWithType:(HttpTaskType)type
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    switch (type) {
        case HttpTaskType_Foreground: {
            
            manager.requestSerializer.timeoutInterval = kForegroundTimeout;
            break;
        }
        case HttpTaskType_Asynchronous: {
            
            manager.requestSerializer.timeoutInterval = kAsynchronousTimeout;
            break;
        }
        case HttpTaskType_Synchronous: {
            
            manager.requestSerializer.timeoutInterval = kSynchronousTimeout;
            break;
        }
        case HttpTaskType_FileRequest: {
            
            manager.requestSerializer.timeoutInterval = kFileRequestTimeout;
            break;
        }
        default:
        {
            
            manager.requestSerializer.timeoutInterval = kForegroundTimeout;
            break;
        }
    }
    
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return manager;
}
@end

