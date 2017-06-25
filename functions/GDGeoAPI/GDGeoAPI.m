//
//  BDGeoAPI.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/24.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "GDGeoAPI.h"
#import "MJExtension.h"
#import "HttpManager.h"

@implementation GDGeoAPI

+(void) reverseGeocodeLat:(CGFloat)lat lon:(CGFloat)lon completion:(void (^)(GDReverseGeoItem* item,NSError* error)) completion
{
 
    // 将请求参数放在请求的字典里
    //http://api.map.baidu.com/geocoder/v2/?callback=renderReverse&location=39.983424,116.322987&output=json&pois=1&ak=您的ak
    
    [self convertLocationLat:lat lon:lon completion:^(GDConvertLocationItem *item, NSError *error) {
        if (item) {
            NSDictionary *param = @{@"location":[NSString stringWithFormat:@"%.6f,%.6f",item.location2D.longitude,item.location2D.latitude],
                                    @"key":gaode_ak};
            // 创建请求类
            AFHTTPSessionManager *manager = [HttpManager jsonManagerWithType:HttpTaskType_Quick];
            [manager GET:@"http://restapi.amap.com/v3/geocode/regeo"
              parameters:param
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
                     // 请求成功
                     GDReverseGeoItem *item = [GDReverseGeoItem objectWithKeyValues:dict];
                     if (completion) {
                         completion(item,nil);
                     }
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     if (completion) {
                         completion(nil,error);
                     }
                 }];
        }else
        {
            completion(nil,error);
        }
    }];
    
    
}

+(void) convertLocationLat:(CGFloat)lat lon:(CGFloat)lon completion:(void (^)(GDConvertLocationItem* item,NSError* error)) completion
{
    //http://restapi.amap.com/v3/assistant/coordinate/convert?parameters
    NSDictionary *param = @{@"locations":[NSString stringWithFormat:@"%.6f,%.6f",lon,lat],
                            @"coordsys":@"gps",
                            @"key":gaode_ak};
    // 创建请求类
    AFHTTPSessionManager *manager = [HttpManager jsonManagerWithType:HttpTaskType_Quick];
    [manager GET:@"http://restapi.amap.com/v3/assistant/coordinate/convert"
      parameters:param
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
             // 请求成功
             GDConvertLocationItem *item = [GDConvertLocationItem objectWithKeyValues:dict];
             if (completion) {
                 completion(item,nil);
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (completion) {
                 completion(nil,error);
             }
         }];
}

@end
