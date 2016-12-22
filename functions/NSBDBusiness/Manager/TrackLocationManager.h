//
//  TrackLocationManager.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/21.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackLocationManager : NSObject<CLLocationManagerDelegate>

+(instancetype) sharedInstance;
-(void) startTracking;
-(void) stopTracking;
@end
