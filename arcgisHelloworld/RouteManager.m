//
//  RouteManager.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteManager.h"

@implementation RouteManager
+(instancetype) sharedInstance
{
    static RouteManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [RouteManager new];
    });
    return manager;
}
@end
