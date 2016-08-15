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

typedef void (^SuccessBlock)(NSDictionary *resultDict, BOOL hasResult);

typedef void (^AFNErrorBlock)(NSError* error);

@interface HttpManager : NSObject
+(AFHTTPSessionManager *)manager;
+(AFHTTPSessionManager *)jsonManager;

+ (void)loginWithUserAccount:(NSString *)account password:(NSString *)password success:(SuccessBlock)success fail:(AFNErrorBlock)fail;

+(void) test;
@end
