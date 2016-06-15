//
//  RouteManager.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteManager.h"

@implementation RouteManager

static RouteManager *manager;
+(instancetype) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [RouteManager new];
        manager.startText=@"";
        manager.endText=@"";
        manager.startPoint = CGPointMake(0, 0);
        manager.endPoint = CGPointMake(0, 0);
        manager.pickingStartPoint = NO;
        manager.pickingEndPoint = NO;
    });
    return manager;
}

-(void) setPoint:(CGPoint) value
{
    
    if (_pickingStartPoint)
    {
        _startPoint = value;
        _pickingStartPoint = NO;
    }else if (_pickingEndPoint)
    {
        _endPoint = value;
        _pickingEndPoint = NO;
    }
}
@end
