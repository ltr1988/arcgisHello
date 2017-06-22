//
//  WeatherManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/8/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "WeatherManager.h"
#import "HttpManager.h"
#import "NSDateFormatterHelper.h"

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
    
    NSDateFormatter *formater = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd"];
    
    if ([self.date isEqualToString:[formater stringFromDate:now]]) {
        return;
    }
    
    // 将请求参数放在请求的字典里
    NSDictionary *param = @{@"ak":lbsyun_ak, @"output":@"json",@"location":@"北京"};
    // 创建请求类
    AFHTTPSessionManager *manager = [HttpManager jsonManagerWithType:HttpTaskType_Quick];
    [manager GET:[HttpHost weatherURL]
      parameters:param
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
             // 请求成功
             if(dict && [dict[@"error"] integerValue] == 0){
                 self.date = dict[@"date"];
                 NSArray *weatherData = [dict[@"results"] firstObject][@"weather_data"];
                 self.weather = [weatherData firstObject][@"weather"];
             } else {
                 self.date = @"not set";
                 self.weather = @"未知";
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             // 请求失败
             self.date = @"not set";
             self.weather = @"未知";
         }];
}
@end
