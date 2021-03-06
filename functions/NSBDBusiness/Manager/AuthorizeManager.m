//
//  AuthorizeManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "AuthorizeManager.h"
#import "LoginModel.h"
#import "NSDictionary+JSON.h"
#import "NSString+MD5Addition.h"
#import "AFHTTPSessionManager+NSBD.h"

@implementation AuthorizeManager
+(instancetype) sharedInstance
{
    static AuthorizeManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AuthorizeManager new];
    });
    return instance;
}

-(instancetype) init
{
    self = [super init];
    if (self) {
        _userid = @"unknown";
        _userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"current user"];
        _token = @"100";
    }
    return  self;
}

-(NSMutableDictionary *) loginParamWithUser:(NSString *)user password:(NSString *)psw
{
    
    
    NSDictionary *info = @{@"userName":user,
                           @"userPwd":[[psw stringFromMD5] stringFromMD5],
                           @"model":[UIDevice currentDevice].model,
                           @"serialnumber":[UIDevice currentDevice].identifierForVendor.UUIDString,
                           @"devicename":[UIDevice currentDevice].name,
                           @"appcode":@"nsbd"};
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"login" method:@"doInDto" req:info];
    return dict;
}

-(NSMutableDictionary *) bindParamWithUserId:(NSString *)userid
{
    NSDictionary *info = @{@"userid":userid,
                            @"model":[UIDevice currentDevice].model,
                            @"serialnumber":[UIDevice currentDevice].identifierForVendor.UUIDString,
                            @"devicename":[UIDevice currentDevice].name,
                            @"systemnumber":[NSString stringWithFormat:@"%@ %@",[[UIDevice currentDevice] systemName],[[UIDevice currentDevice] systemVersion]],
                            @"appcode":@"nsbd"};
    
    
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"binding" method:@"mdBinding" req:info];
    return dict;
}

-(void) requestLoginWithUser:(NSString *)user password:(NSString *)psw callback:(InfoCallback) callback
{
//    if (callback) {
//        [AuthorizeManager sharedInstance].userName = user;
//        [AuthorizeManager sharedInstance].userPsw = psw;
//        [AuthorizeManager sharedInstance].token = @"100";
//        callback(@{@"success":@(YES),
//                   @"token":@"100"});
//    }
//    return;

#ifdef NoServer
    if (callback) {
        [AuthorizeManager sharedInstance].userName = user;
        [AuthorizeManager sharedInstance].userPsw = psw;
        [AuthorizeManager sharedInstance].token = @"100";
        callback(@{@"success":@(YES),
                   @"token":@"100"});
    }
    return;
#endif
    

    // 将请求参数放在请求的字典里
    NSDictionary *param = [self loginParamWithUser:user password:psw];
    // 创建请求类
  
    AFHTTPSessionManager *manager = [HttpManager loginManager];
    
    [manager NSBDPOST:[HttpHost hostAURLWithParam:param]
                             parameters:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
                                    // 请求成功
                                    LoginModel *item = [LoginModel objectWithKeyValues:dict];
                                    if (item.success)
                                    {
                                        
                                        
                                        if (item.token) {
                                            [AuthorizeManager sharedInstance].userid = item.userid;
                                            [AuthorizeManager sharedInstance].userName = user;
                                            [AuthorizeManager sharedInstance].token = item.token;
                                            [AuthorizeManager sharedInstance].userPsw = psw;
                                            
                                            if (callback) {
                                                callback(@{@"success":@(YES),
                                                           @"code":item.bindingcode,
                                                           @"tip":item.bindingpoint});
                                            }
                                        }else
                                        {
                                            if (callback) {
                                                callback(@{@"success":@(NO)});
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (callback) {
                                            callback(@{@"success":@(NO)});
                                        }
                                    }

                                    
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    // 请求失败
                                    if (callback) {
                                        callback(@{@"success":@(NO)});
                                    }
                                }];
}



-(void) requestBindDeviceWithCallback:(InfoCallback) callback
{
    NSDictionary *param = [self bindParamWithUserId:[AuthorizeManager sharedInstance].userid?:@"unknown"];
    AFHTTPSessionManager *manager = [HttpManager loginManager];
    
    [manager NSBDPOST:[HttpHost hostAURLWithParam:param]
           parameters:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
                  // 请求成功
                  HttpBaseModel *item = [HttpBaseModel objectWithKeyValues:dict];
                  
                  if (callback) {
                      callback(@{@"success":@(item.success)});
                  }
                  
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  // 请求失败
                  if (callback) {
                      callback(@{@"success":@(NO)});
                  }
              }];
}

-(void) setUserName:(NSString *)userName
{
    _userName = userName;
    [[NSUserDefaults standardUserDefaults] setObject:_userName forKey:@"current user"];
    
}
@end
