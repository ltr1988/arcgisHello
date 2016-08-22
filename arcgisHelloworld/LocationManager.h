//
//  LocationManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/22.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject<CLLocationManagerDelegate>
+(LocationManager *) shared;
-(void) startLocating;
-(void) stopLocating;
@end
