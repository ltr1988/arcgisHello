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

@interface InfoAGSMapView : AGSMapView
@property (nonatomic,strong) UIView *infoView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,assign) TianDiTuLayerTypes layerType;
@property (nonatomic,copy) ActionCallback mapViewTouchesCallback;

-(void) switchLayerType;
-(void) showInfoView:(BOOL)animated;
@end
