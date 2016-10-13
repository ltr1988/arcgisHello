//
//  LocationManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/22.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"

@interface LocationManager : NSObject<CLLocationManagerDelegate>

+(void) checkAuthority;


-(instancetype) initWthCallback:(InfoCallback) callback;
-(void) startLocating;
-(void) stopLocating;
-(void)postLocationNotifcationWithLat:(CGFloat) lat lon:(CGFloat) lon;


@property (nonatomic,copy) InfoCallback callback;
@end
