//
//  NSString+Location.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/3.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSString+Location.h"

@implementation NSString (Location)
+(instancetype) stringWithLatitude:(CGFloat) lat Lontitude:(CGFloat) lon
{
    return [NSString stringWithFormat:@"%.2f,%.2f",lat,lon];
}

+(instancetype) stringWithLocationAGSPoint:(AGSPoint *) point
{
    return [NSString stringWithLatitude:point.x Lontitude:point.y];
}

+(instancetype) stringWithLocationPoint:(CGPoint) point
{
    return [NSString stringWithLatitude:point.x Lontitude:point.y];
}

@end
