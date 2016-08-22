//
//  LocationManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/22.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager()
{
    CLLocationManager *locationManager;
}
@end

@implementation LocationManager
+(LocationManager *) shared
{
    static LocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LocationManager alloc] init];
    });
    return manager;
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
    NSLog(@"error");
}

// 6.0 以上调用这个函数
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"%lu", (unsigned long)[locations count]);
    
    CLLocation *newLocation = [locations lastObject];
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    
    //    CLLocation *newLocation = locations[1];
    //    CLLocationCoordinate2D newCoordinate = newLocation.coordinate;
    //    NSLog(@"经度：%f,纬度：%f",newCoordinate.longitude,newCoordinate.latitude);
    
    // 计算两个坐标距离
    //    float distance = [newLocation distanceFromLocation:oldLocation];
    //    NSLog(@"%f",distance);
    
    [manager stopUpdatingLocation];
    
    //------------------位置反编码---5.0之后使用-----------------
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       
                       for (CLPlacemark *place in placemarks) {

                           NSLog(@"name,%@",place.name);                       // 位置名
                           //
                           NSLog(@"thoroughfare,%@",place.thoroughfare);       // 街道
                           //
                           NSLog(@"subThoroughfare,%@",place.subThoroughfare); // 子街道
                           //
                           NSLog(@"locality,%@",place.locality);               // 市
                           //
                           NSLog(@"subLocality,%@",place.subLocality);         // 区
                           //
                           NSLog(@"country,%@",place.country);                 // 国家
                       }
                       
                   }];
    
}
@end
