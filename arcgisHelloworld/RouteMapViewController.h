//
//  RouteMapViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoAGSMapView.h"

#define LocateInMapNotifcation @"LocateInMapNotifcation"

@interface RouteMapViewController : SupportRotationSelectBaseViewController

@property (nonatomic,weak) InfoAGSMapView* mapView;
@end
