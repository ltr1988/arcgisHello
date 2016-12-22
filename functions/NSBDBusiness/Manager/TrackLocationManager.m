//
//  TrackLocationManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/21.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TrackLocationManager.h"
#import "SearchSessionManager.h"

@implementation TrackLocationManager
{
    NSTimer *timer;
    CLLocationManager *locationManager;
}


+(instancetype) sharedInstance
{
    static TrackLocationManager *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[TrackLocationManager alloc] init];
    });
    return manger;
}

-(instancetype) init
{
    self = [super init];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        // 设置定位精度，十米，百米，最好
        
        [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        locationManager.delegate = self;
        
    }
    return self;
}

-(void) startTracking
{
    [self stopTimer];
    timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(reportLocation) userInfo:nil repeats:YES];
}

-(void) reportLocation
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
        [locationManager startUpdatingLocation];
}

-(void) stopTracking
{
    [self stopTimer];
}

-(void) stopTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [locationManager stopUpdatingLocation];
    NSLog(@"%lu", (unsigned long)[locations count]);
    
    CLLocation *newLocation = [locations lastObject];
    
    [[SearchSessionManager sharedManager] requestUpdateLocationWithX:newLocation.coordinate.latitude y:newLocation.coordinate.longitude height:newLocation.altitude successCallback:nil failCallback:nil];
}
@end
