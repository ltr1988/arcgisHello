//
//  BDGeoAPI.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/24.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GDReverseGeoItem.h"

@interface GDGeoAPI : NSObject
+(void) reverseGeocodeLat:(CGFloat)lat lon:(CGFloat)lon completion:(void (^)(GDReverseGeoItem* item,NSError* error)) completion;
+(void) convertLocationLat:(CGFloat)lat lon:(CGFloat)lon completion:(void (^)(GDConvertLocationItem* item,NSError* error)) completion;
@end
