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
                           @"devicename":[UIDevice currentDevice].name};
    
    NSMutableDictionary *dict = [HttpHost paramWithAction:@"login" method:@"doInDto" req:info];
    return dict;
}

-(void) requestLoginWithUser:(NSString *)user password:(NSString *)psw callback:(InfoCallback) callback
{
#ifdef NoServer
    if (callback) {
        callback(@{@"success":@(YES),
                   @"token":@"daning"});
    }
    return;
#endif
    
    @weakify(self)
    // 将请求参数放在请求的字典里
    NSDictionary *param = [self loginParamWithUser:user password:psw];
    // 创建请求类
  
    AFHTTPSessionManager *manager = [HttpManager loginManager];
    [manager POST:[HttpHost hostAURLWithParam:param]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
            @strongify(self)
             // 请求成功
             NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSDictionary *dict = [NSDictionary dictWithJson:str];
             LoginModel *item = [LoginModel objectWithKeyValues:dict];
             if (item.success)
             {
                 
                 if (item.token) {
                     [AuthorizeManager sharedInstance].userName = user;
                     [AuthorizeManager sharedInstance].token = item.token;
                     
                     
                     if (callback) {
                         callback(@{@"success":@(item.success)});
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

-(void) setUserName:(NSString *)userName
{
    _userName = userName;
    [[NSUserDefaults standardUserDefaults] setObject:_userName forKey:@"current user"];
    
}
@end
