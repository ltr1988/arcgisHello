//
//  AuthorizeManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "AuthorizeManager.h"
#import "LoginModel.h"

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
        _userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"current user"];
    }
    return  self;
}

-(void) requestLoginWithUser:(NSString *)user password:(NSString *)psw callback:(InfoCallback) callback
{
    //to be deleted=======
    if (callback) {
        callback(@{@"success":@(YES),
                   @"department":@"daning"});
    }
    return;
    //to be deleted=======
    
    // 将请求参数放在请求的字典里
    NSDictionary *param = [HttpHost loginParamWithUser:user password:psw];
    // 创建请求类
  
    AFHTTPSessionManager *manager = [HttpManager jsonManager];
    [manager GET:[HttpHost hostURL]
      parameters:param
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
             // 请求成功
             LoginModel *item = [LoginModel objectWithKeyValues:dict];
             if (item.success)
             {
                 
                 if (item.loginInfo) {
                     if (callback) {
                         callback(@{@"success":@(item.success),
                                    @"department":item.loginInfo.department});
                     }
                 }else
                 {
                     if (callback) {
                         callback(@{@"success":@(item.success)});
                     }
                 }
             }
             else
             {
                 if (callback) {
                     callback(@{@"success":@(item.success)});
                 }
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
