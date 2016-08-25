//
//  LocationManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/22.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LocationManager.h"
#import "CommonDefine.h"

@interface LocationManager()
{
    CLLocationManager *locationManager;
}
@end

@implementation LocationManager


-(instancetype) initWthCallback:(InfoCallback) callback
{
    self = [super init];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        // 设置定位精度，十米，百米，最好
        
        [locationManager requestAlwaysAuthorization];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        locationManager.delegate = self;
        self.callback = callback;
    }
    return self;
}

-(instancetype) init
{
    self = [super init];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        // 设置定位精度，十米，百米，最好
        
        [locationManager requestAlwaysAuthorization];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        locationManager.delegate = self;
    }
    return self;
}

-(void) stopLocating
{
    [locationManager stopUpdatingLocation];
}

-(void) startLocating
{
    // 开始时时定位
    [locationManager requestLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    dispatch_main_async_safe(^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification"
                                                            object:self
                                                          userInfo:@{@"error":error}];
    });
}

// 6.0 以上调用这个函数
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"%lu", (unsigned long)[locations count]);
    
    CLLocation *newLocation = [locations lastObject];
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",coordinate.longitude,coordinate.latitude);
    
    //    CLLocation *newLocation = locations[1];
    //    CLLocationCoordinate2D newCoordinate = newLocation.coordinate;
    //    NSLog(@"经度：%f,纬度：%f",newCoordinate.longitude,newCoordinate.latitude);
    
    // 计算两个坐标距离
    //    float distance = [newLocation distanceFromLocation:oldLocation];
    //    NSLog(@"%f",distance);
    
    [manager stopUpdatingLocation];
    
    [self postLocationNotifcationWithLocation:newLocation];
    
}


-(void)postLocationNotifcationWithLocation:(CLLocation *)newLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       //                       for (CLPlacemark *place in placemarks) {
                       //
                       //                           NSLog(@"name,%@",place.name);                       // 位置名
                       //                           //
                       //                           NSLog(@"thoroughfare,%@",place.thoroughfare);       // 街道
                       //                           //
                       //                           NSLog(@"subThoroughfare,%@",place.subThoroughfare); // 子街道
                       //                           //
                       //                           NSLog(@"locality,%@",place.locality);               // 市
                       //                           //
                       //                           NSLog(@"subLocality,%@",place.subLocality);         // 区
                       //                           //
                       //                           NSLog(@"country,%@",place.country);                 // 国家
                       //                       }
                       //
                       
                       CLPlacemark *place = [placemarks firstObject];
                       
                       NSDictionary *userInfo;
                       if (place)
                       {
                           userInfo = @{@"location":newLocation,@"place":place.name};
                       }else
                       {
                           userInfo = @{@"location":newLocation};
                       }
                       
                       
                       dispatch_main_async_safe(^{
                           
                           [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification"
                                                                               object:self
                                                                             userInfo:userInfo];
                           
                           if (self.callback)
                           {
                               _callback(userInfo);
                           }
                           
                       });
                   }];

}
-(void)postLocationNotifcationWithLat:(CGFloat) lat lon:(CGFloat) lon
{
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    [self postLocationNotifcationWithLocation: newLocation];
}
@end
