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
#import "LocationManager.h"
#import "AFNetworkReachabilityManager.h"

@interface RouteMapViewController()<AGSMapViewTouchDelegate>
{
    UIImageView * anchorView;
    LocationManager *manager;
    NSInteger popNum; //返回跳几次
}

@end
@implementation RouteMapViewController

-(instancetype) init
{
    return [self initWithPopNumber:1];
}


-(instancetype) initWithPopNumber:(NSInteger) popNumber
{
    NSAssert(popNumber>0, @"popNumber can't be less than 1");
    self = [super init];
    if (self) {
        popNum = popNumber;
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    [self addObservers];
    manager = [[LocationManager alloc] init];
}

-(void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToEnvChange:) name:AGSMapViewDidEndPanningNotification object:self.mapView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToEnvChange:) name:AGSMapViewDidEndZoomingNotification object:self.mapView];
}

-(void) respondToEnvChange:(NSNotification *)noti
{
    [self shakeView:anchorView];
    
    AGSPoint *point = (AGSPoint *)[[AGSGeometryEngine defaultGeometryEngine] projectGeometry:self.mapView.mapAnchor
                                   
                                                                          toSpatialReference:[AGSSpatialReference wgs84SpatialReference]];
    
    if (point) {
        
        __weak __typeof(self) weakSelf= self;
        CLLocation * newLocation = [[CLLocation alloc]initWithLatitude:point.y longitude:point.x ];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:newLocation
                       completionHandler:^(NSArray *placemarks, NSError *error){
                           
                           CLPlacemark *place = [placemarks firstObject];
                           dispatch_main_async_safe(^{
                               weakSelf.title = place.name;
                           });
                           
                       }];

    }
}


-(void)shakeView:(UIView*)viewToShake
{
    CGFloat t =-10.0;
    CGAffineTransform translateUp  =CGAffineTransformTranslate(CGAffineTransformIdentity, 0.0,t);
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        viewToShake.transform = translateUp;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}


-(void) setupSubviews
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(actionPickPoint)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    self.mapView = [MapViewManager sharedRouteMapView];
    self.mapView.baseLayerType = NSBD_NORMAL;
    [self.mapView reloadLayers];
    [self.mapView zoomToResolution:[MapViewManager sharedMapView].resolution withCenterPoint:[MapViewManager sharedMapView].mapAnchor animated:YES];
    [self.view addSubview:self.mapView];
    self.mapView.frame = self.view.bounds;
    
    anchorView = [UIImageView new];
    anchorView.bounds = CGRectMake(0, 0, 36,36);
    anchorView.center = self.view.center;
    anchorView.image = [UIImage imageNamed:@"icon_location"];
    [self.view addSubview:anchorView];
    
    
    
    CGFloat btnsize = 36;
    
    CGFloat rightBtnOffsetX = self.view.frame.size.width- btnsize - 20;
    UIButton *btnChangMapType = [[UIButton alloc] initWithFrame:CGRectMake(rightBtnOffsetX, 20, btnsize, btnsize)];
    btnChangMapType.backgroundColor = [UIColor whiteColor];
    btnChangMapType.layer.cornerRadius = 5;
    btnChangMapType.titleLabel.font = [UIFont systemFontOfSize:12];
    //[btnChangMapType setTitle:@"影像" forState:UIControlStateNormal];
    [btnChangMapType setImage:[UIImage imageNamed:@"icon_mapchange"] forState:UIControlStateNormal];
    [btnChangMapType setImage:[UIImage imageNamed:@"icon_mapchange"] forState:UIControlStateHighlighted];
    [btnChangMapType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnChangMapType.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btnChangMapType addTarget:self action:@selector(actionSwitchMapType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangMapType];
    
    __weak UIView *weakView = self.view;
    [anchorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
        make.centerX.mas_equalTo(weakView.mas_centerX);
        make.bottom.mas_equalTo(weakView.mas_centerY);
    }];
    
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        CLLocation *location = [[CLLocation alloc]initWithLatitude:point.y longitude:point.x];
        if (![AFNetworkReachabilityManager sharedManager].reachable)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification" object:self userInfo:@{@"location":location}];
            return;
        }
        
        
        __block BOOL cancel = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (cancel) {
                return;
            }
            cancel = YES;
            NSDictionary *userInfo = @{@"location":location};
            
            dispatch_main_async_safe(^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification"
                                                                    object:self
                                                                  userInfo:userInfo];
                
            });
            int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
            
            if (index < popNum) {
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index - popNum)] animated:YES];
            }
        });
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location
                       completionHandler:^(NSArray *placemarks, NSError *error){
                           
                           if (cancel) {
                               return;
                           }
                           cancel = YES;
                           
                           CLPlacemark *place = [placemarks firstObject];
                           NSDictionary *userInfo;
                           if (place)
                               userInfo = @{@"location":location,
                                            @"place":place.name};
                           else
                               userInfo = @{@"location":location};
                           dispatch_main_async_safe(^{
                               
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification" object:self userInfo:userInfo];
                           });
                           int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                           
                           if (index < popNum) {
                               [self.navigationController popViewControllerAnimated:YES];
                           }else
                           {
                               [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index - popNum)] animated:YES];
                           }
                           
                       }];
    }
}

-(void) actionSwitchMapType:(id)sender
{
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
        //        [btn setTitle:@"电子" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_mapchange1"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_mapchange1"] forState:UIControlStateHighlighted];
    }else
    {
        //        [btn setTitle:@"影像" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_mapchange"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_mapchange"] forState:UIControlStateHighlighted];
    }
    
    [self.mapView switchLayerType];
}

@end
