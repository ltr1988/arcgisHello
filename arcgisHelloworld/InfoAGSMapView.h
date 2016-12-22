//
//  InfoAGSMapView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Arcgis/Arcgis.h>
#import "CommonDefine.h"
#import "TianDiTuWMTSLayer.h"

enum {
    LayerMaskBaseLayer      = 1 <<0,
    LayerMaskNSBDLayer      = 1 << 1,
    LayerMaskGraphicLayer   = 1 << 2,
    LayerMask3DLayer        = 1 << 3,
};

@interface InfoAGSMapView : AGSMapView
@property (nonatomic,strong) UIView *infoView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,assign) TianDiTuLayerTypes baseLayerType;
@property (nonatomic,assign) NSUInteger layerMask;
@property (nonatomic,copy) ActionCallback mapViewTouchesCallback;

-(void) switchLayerType;
-(void) showInfoView:(BOOL)animated;
-(void) reloadLayers;
-(void) locate;
@end
