//
//  InfoAGSMapView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "InfoAGSMapView.h"
#import "MapViewManager.h"
#import "CustomLocationDataSource.h"
#define ANIMATION_DURATION 1



@implementation InfoAGSMapView

-(instancetype) init
{
    self = [super init];
    if (self) {
        _layerMask = LayerMaskBaseLayer|LayerMaskNSBDLayer|LayerMaskGraphicLayer;
        //self是个MapView
        self.locationDisplay.dataSource = [CustomLocationDataSource new];
    }
    return self;
}

-(void) switchLayerType
{
    _baseLayerType = NSBD_NORMAL + NSBD_IMAGE - _baseLayerType;
    [MapViewManager refreshVisibleLayer:self];
}

-(void) reloadLayers
{
    [MapViewManager refreshVisibleLayer:self];
}

#pragma mark - touch
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event]; // Message superclass
    
    if (self.mapViewTouchesCallback) {
        _mapViewTouchesCallback();
    }
    
    if (self.infoView && self.infoView.hidden == NO) {
        UITouch *touch = [touches anyObject]; // Get touch from set
        
        if (touch.view != self.infoView) {
            
            __weak __typeof(self) weakself = self;
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
                weakself.infoView.alpha = 0;
            } completion:^(BOOL finished) {
                weakself.infoView.hidden = YES;
            }];
            
        }

    }
    
}

-(void) setBottomView:(UIView *)bottomView
{
    if (_bottomView && (_bottomView!= bottomView)) {
        [_bottomView removeFromSuperview];
    }
    _bottomView = bottomView;
    
    if (bottomView == nil)
        return;
    CGRect frame = self.bounds;
    frame.origin.y = self.bounds.size.height - bottomView.frame.size.height;
    frame.size.height = bottomView.frame.size.height;
    _bottomView.frame = frame;
    
    _bottomView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:_bottomView];

}

-(void) setInfoView:(UIView *)infoView
{
    if (_infoView && (_infoView!= infoView)) {
        [_infoView removeFromSuperview];
    }
    _infoView = infoView;
    if (infoView == nil)
        return;
    CGRect frame = self.bounds;
    frame.origin.y = self.bounds.size.height - infoView.frame.size.height;
    frame.size.height = infoView.frame.size.height;
    _infoView.frame = frame;
    
    _infoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:_infoView];
    
    [self bringSubviewToFront:_infoView];
}



-(void) showInfoView:(BOOL)animated
{
    if (_infoView) {
        
        _infoView.hidden = NO;
        self.infoView.alpha = 0;
        __weak __typeof(self) weakself = self;
        
        if (animated) {
            [UIView animateWithDuration:ANIMATION_DURATION/2.f animations:^{
                weakself.infoView.alpha = 1;
            }];
        }
        else
            self.infoView.alpha = 1;
    }
}


-(void) locate
{
    [self.locationDisplay startDataSource];
    
    self.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeDefault;
    
    //Set a wander extent equal to 75% of the map's envelope
    //The map will re-center on the location symbol only when
    //the symbol moves out of the wander extent
    self.locationDisplay.wanderExtentFactor = 0.75;
    //    self.mapView.locationDisplay.zoomScale = 1000;
    AGSPoint *p = self.locationDisplay.location.point;
    if (p)
    {
        [self zoomToScale:10000 withCenterPoint:p animated:YES];
    }
}
@end
