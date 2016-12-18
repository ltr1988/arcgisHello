//
//  DistanceMapViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DistanceMapViewController.h"
#import "MapViewManager.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "DistanceEngine.h"
#import "DistanceCalloutView.h"

@interface DistanceMapViewController ()<AGSMapViewTouchDelegate>
{
    DistanceEngine *d_engine;
}
@end

@implementation DistanceMapViewController

-(BOOL) customBackAction
{
    [self clearAll];
    return YES;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
}


-(void) setupSubviews
{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(clearAll)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    self.mapView = [MapViewManager sharedRouteMapView];
    [self.mapView zoomToResolution:[MapViewManager sharedMapView].resolution withCenterPoint:[MapViewManager sharedMapView].mapAnchor animated:YES];
    [self.view addSubview:self.mapView];
    self.mapView.frame = self.view.bounds;
    self.mapView.touchDelegate = self;
    
    
    d_engine = [[DistanceEngine alloc] initWithGraphicsLayer:(AGSGraphicsLayer *)[self.mapView mapLayerForName:@"Graphics Layer"]];
    
    CGFloat btnsize = 36;
    
    CGFloat rightBtnOffsetX = self.view.frame.size.width- btnsize - 20;
    UIButton *btnChangMapType = [[UIButton alloc] initWithFrame:CGRectMake(rightBtnOffsetX, 20, btnsize, btnsize)];
    btnChangMapType.backgroundColor = [UIColor whiteColor];
    btnChangMapType.layer.cornerRadius = 5;
    btnChangMapType.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnChangMapType setTitle:@"影像" forState:UIControlStateNormal];
    [btnChangMapType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnChangMapType.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btnChangMapType addTarget:self action:@selector(actionSwitchMapType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangMapType];

}


-(void) distancePop
{
    AGSPoint *p = [d_engine popPoint];
    if (d_engine.points.count > 1) {
        DistanceCalloutView *callout = [[DistanceCalloutView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [callout.btnClose addTarget:self action:@selector(distancePop) forControlEvents:UIControlEventTouchUpInside];
        callout.lbDistance.text = [d_engine distanceString];
        self.mapView.callout.customView = callout;
        [self.mapView.callout showCalloutAt:p screenOffset:CGPointMake(0, 0) animated:YES];
    }else
    {
        [self.mapView.callout dismiss];
    }
}

- (void) clearAll
{
    [self.mapView.callout dismiss];
    [d_engine clearAll];
}

- (void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint features:(NSDictionary *)features{
    
    
    [d_engine pushPoint:mappoint];
    
    if (d_engine.points.count > 1) {
        DistanceCalloutView *callout = [[DistanceCalloutView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [callout.btnClose addTarget:self action:@selector(distancePop) forControlEvents:UIControlEventTouchUpInside];
        callout.lbDistance.text = [d_engine distanceString];
        self.mapView.callout.customView = callout;
        
        [self.mapView.callout showCalloutAt:mappoint screenOffset:CGPointMake(0, 0) animated:YES];
    }
}


-(void) actionSwitchMapType:(id)sender
{
    [self clearAll];
    UIButton *btn = sender;
    
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.2;
    
    //设置运动type
    animation.type = @"oglFlip";
    
    animation.subtype = kCATransitionFromLeft;
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [btn.layer addAnimation:animation forKey:@"animation"];
    
    if (self.mapView.baseLayerType == NSBD_NORMAL) {
        [btn setTitle:@"电子" forState:UIControlStateNormal];
    }else
    {
        [btn setTitle:@"影像" forState:UIControlStateNormal];
    }
    
    [self.mapView switchLayerType];
}

@end
