//
//  WeatherManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/8/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "WeatherManager.h"
#import "HttpManager.h"

#define lbsyun_ak @"zXOpPbZr62FLVLqQtXp0RYZ7SpyCwqAS"

@implementation WeatherManager

+(instancetype) sharedInstance
{
    static WeatherManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WeatherManager new];
    });
    return instance;
}

-(void) requestData
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
    
    [formater setDateFormat:@"yyyy-MM-dd"];
    if ([self.date isEqualToString:[formater stringFromDate:now]]) {
        return;
    }
    
    // 将请求参数放在请求的字典里
    NSDictionary *param = @{@"ak":lbsyun_ak, @"output":@"json",@"location":@"北京"};
    // 创建请求类
    AFHTTPSessionManager *manager = [HttpManager jsonManager];
    [manager GET:@"http://api.map.baidu.com/telematics/v3/weather"
      parameters:param
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
             // 请求成功
             if(dict){
                 if ([dict[@"error"] integerValue] == 0)
                 {
                     self.date = dict[@"date"];
                     NSArray *weatherData = [dict[@"results"] firstObject][@"weather_data"];
                     self.weather = [weatherData firstObject][@"weather"];
                 }
             } else {
                 
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             // 请求失败
         }];
}
@end