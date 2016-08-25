//
//  SearchLocationReportManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchLocationReportManager.h"
#import "CommonDefine.h"

@interface SearchLocationReportManager()
{
    CLLocationManager *locationManager;
    CLLocation *myLocation;
    NSTimer *timer;
    NSInteger timerInterval;
}
@end

@implementation SearchLocationReportManager
-(instancetype) initWithTimeInterval:(NSInteger) interval
{
    if (self = [super init]) {
        
        timerInterval = interval;
        [self setupMembers];
    }
    return self;
}

-(void) setupMembers
{
    myLocation = nil;
    
    
    locationManager = [[CLLocationManager alloc] init];
    // 设置定位精度，十米，百米，最好
    
    [locationManager requestAlwaysAuthorization];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    locationManager.delegate = self;
}

-(void) startUpdating
{
    timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(actionTimer) userInfo:nil repeats:YES];
    [locationManager startUpdatingLocation];
}

-(void) stopUpdating
{
    [timer invalidate];
    timer = nil;
    [locationManager stopUpdatingLocation];
}

-(void) actionTimer
{
    if (myLocation) {
        //report mylocation to server
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //react nothing
}

// 6.0 以上调用这个函数
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"%lu", (unsigned long)[locations count]);
    
    CLLocation *newLocation = [locations lastObject];
    
    myLocation = newLocation;
}

@end
