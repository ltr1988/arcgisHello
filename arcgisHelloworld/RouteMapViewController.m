//
//  RouteMapViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteMapViewController.h"
#import "MapViewManager.h"
#import "CommonDefine.h"
#import "Masonry.h"

@interface RouteMapViewController()
{
    UIImageView * anchorView;
}

@end
@implementation RouteMapViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(actionPickPoint)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    
}

-(void) setupSubviews
{
    anchorView = [UIImageView new];
    anchorView.bounds = CGRectMake(0, 0, 36,36);
    anchorView.center = self.view.center;
    anchorView.image = [UIImage imageNamed:@"RedPushpin"];
    
    [self.view addSubview:anchorView];
    
    __weak UIView *weakView = self.view;
    [anchorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
        make.centerX.mas_equalTo(weakView.mas_centerX);
        make.bottom.mas_equalTo(weakView.mas_centerY);
    }];
}

-(void)actionPickPoint
{
    
    AGSPoint *point = (AGSPoint *)[[AGSGeometryEngine defaultGeometryEngine] projectGeometry:self.mapView.mapAnchor
                                   
                                                                          toSpatialReference:[AGSSpatialReference wgs84SpatialReference]];
    
    NSDictionary *userInfo = @{@"location":point};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification" object:self userInfo:userInfo];
    [self.navigationController popViewControllerAnimated:YES];
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
