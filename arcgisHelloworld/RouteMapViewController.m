//
//  RouteMapViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteMapViewController.h"
#import "MapViewManager.h"

@interface RouteMapViewController()
{
    UIImageView * anchorView;
}

@end
@implementation RouteMapViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    anchorView = [UIImageView new];
    anchorView.bounds = CGRectMake(0, 0, 36,36);
    anchorView.center = self.view.center;
    anchorView.image = [UIImage imageNamed:@"RedPushpin"];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView = [MapViewManager sharedMapView];
    if (anchorView) {
        [self.mapView addSubview:anchorView];
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (anchorView) {
        [anchorView removeFromSuperview];
    }
    self.mapView = nil;
}
@end
