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

@interface RouteMapViewController()<AGSMapViewTouchDelegate>
{
    UIImageView * anchorView;
}

@end
@implementation RouteMapViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    
    
}

-(void) setupSubviews
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(actionPickPoint)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    self.mapView = [MapViewManager sharedRouteMapView];
    [self.mapView zoomToResolution:[MapViewManager sharedMapView].resolution withCenterPoint:[MapViewManager sharedMapView].mapAnchor animated:YES];
    [self.view addSubview:self.mapView];
    self.mapView.frame = self.view.bounds;
    
    anchorView = [UIImageView new];
    anchorView.bounds = CGRectMake(0, 0, 36,36);
    anchorView.center = self.view.center;
    anchorView.image = [UIImage imageNamed:@"icon_location"];
    self.mapView.touchDelegate = self;
    [self.mapView addSubview:anchorView];
    
    __weak UIView *weakView = self.mapView;
    [anchorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
        make.centerX.mas_equalTo(weakView.mas_centerX);
        make.bottom.mas_equalTo(weakView.mas_centerY);
    }];
    
    
}


- (void)mapView:(AGSMapView *)mapView didMoveTapAndHoldAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint features:(NSDictionary *)features
{
    
    CGAffineTransform translateUp =CGAffineTransformTranslate(CGAffineTransformIdentity,0.,-20);
    [UIView animateWithDuration:0.5 animations:^{
        anchorView.transform = translateUp;
    }];
    
}

- (void)mapView:(AGSMapView *)mapView didEndTapAndHoldAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint features:(NSDictionary *)features
{
    [UIView animateWithDuration:0.5 animations:^{
        anchorView.transform = CGAffineTransformIdentity;
    }];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)actionPickPoint
{
    
    AGSPoint *point = (AGSPoint *)[[AGSGeometryEngine defaultGeometryEngine] projectGeometry:self.mapView.mapAnchor
                                   
                                                                          toSpatialReference:[AGSSpatialReference wgs84SpatialReference]];
    
    if (point)
    {
        NSDictionary *userInfo = @{@"location":point};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification" object:self userInfo:userInfo];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
