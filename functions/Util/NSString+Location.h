//
//  NSString+Location.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/3.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Location)
+(instancetype) stringWithLatitude:(CGFloat) lat Lontitude:(CGFloat) lon;
+(instancetype) stringWithLocationAGSPoint:(AGSPoint *) point;
+(instancetype) stringWithLocationPoint:(CGPoint) point;
@end
