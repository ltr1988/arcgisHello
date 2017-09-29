//
//  CustomLocationDataSource.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/9/9.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "CustomLocationDataSource.h"

@interface CustomLocationDataSource()<CLLocationManagerDelegate>

@property (nonatomic) AGSGeometryEngine *engine;
@property (nonatomic) CLLocationManager *locationMgr;
@property (nonatomic, getter = isStarted) BOOL started;
@property (nonatomic, strong) NSError *error;

-(void)start;

-(void)stop;
@end

@implementation CustomLocationDataSource
-(instancetype) init
{
    if (self = [super init]) {
        _locationMgr = [[CLLocationManager alloc] init];
        [_locationMgr setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        _locationMgr.delegate = self;
    }
    return self;
}

-(void) start
{
    [_locationMgr startUpdatingHeading];
    [_locationMgr startUpdatingLocation];
    _started = YES;
}

-(void) stop
{
    [_locationMgr stopUpdatingHeading];
    [_locationMgr stopUpdatingLocation];
    _started = NO;
}





- (void)locationManager:(CLLocationManager *)manager

       didUpdateHeading:(CLHeading *)newHeading{
    
    
    
    [self.delegate locationDisplayDataSource:self didUpdateWithHeading:newHeading.trueHeading];
    
}


// 6.0 以上调用这个函数
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    AGSLocation* location = [AGSLocation locationWithCLLocation:locations[0]];
    
    //实现客户化转换算法
    
    AGSPoint *mpoint = (AGSPoint *)[self.engine projectGeometry:location.point toSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:2415]];
    
    AGSPoint *verifyPoint = [AGSPoint pointWithX:mpoint.x - 62 y:mpoint.y - 30 spatialReference:[AGSSpatialReference spatialReferenceWithWKID:2415]];
    
    [location setPoint:verifyPoint];
    
    [self.delegate locationDisplayDataSource:self didUpdateWithLocation:location];
    
    
    
}

-(AGSGeometryEngine *)engine{
    if (!_engine) {
        _engine = [[AGSGeometryEngine alloc] init];
    }
    return _engine;
}

@end
