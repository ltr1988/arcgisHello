//
//  MapViewManager.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoAGSMapView.h"

@interface MapViewManager : NSObject
+(InfoAGSMapView *) sharedMapView;
+(InfoAGSMapView *) sharedRouteMapView;
+(NSString *)IP;

+(void)SetIP:(NSString *)ip_new;
@end
