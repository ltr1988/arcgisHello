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


-(void) setupMembers
{
    locationManager = [[CLLocationManager alloc] init];
    // 设置定位精度，十米，百米，最好
    
    [locationManager requestAlwaysAuthorization];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    locationManager.delegate = self;
}

-(instancetype) initWthCallback:(InfoCallback) callback
{
    self = [super init];
    if (self) {
        [self setupMembers];
        self.callback = callback;
    }
    return self;
}

-(instancetype) init
{
    self = [super init];
    if (self) {
        [self setupMembers];
    }
    return self;
}

-(void) stopLocating
{
    [locationManager stopUpdatingLocation];
}

-(void) startLocating
{
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    dispatch_main_async_safe(^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pickMyLocationNotification"
                                                            object:self
                                                          userInfo:@{@"error":error}];
    });
}

// 6.0 以上调用这个函数
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [locationManager stopUpdatingLocation];
    NSLog(@"%lu", (unsigned long)[locations count]);
    
    CLLocation *newLocation = [locations lastObject];
    
    [self postLocationNotifcationWithLocation:newLocation];
    
}


-(void)postLocationNotifcationWithLocation:(CLLocation *)newLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       
                       CLPlacemark *place = [placemarks firstObject];
                       
                       NSDictionary *userInfo;
                       if (place)
                       {
                           userInfo = @{@"mylocation":@"我的位置",@"location":newLocation,@"place":place.name};
                       }else
                       {
                           userInfo = @{@"mylocation":@"我的位置",@"location":newLocation};
                       }
                       
                       
                       dispatch_main_async_safe(^{
                           
                           [[NSNotificationCenter defaultCenter] postNotificationName:@"pickMyLocationNotification"
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
