//
//  MapViewManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MapViewManager.h"
#import "CommonDefine.h"
#import "TianDiTuWMTSLayer.h"

@implementation MapViewManager
static InfoAGSMapView *mapView;
static InfoAGSMapView *routeMapView;
static InfoAGSMapView *distanceMapView;
static NSString *ip;

+(InfoAGSMapView *) sharedRouteMapView
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        routeMapView = [[InfoAGSMapView alloc] init];
        routeMapView.gridLineWidth = 0.1;
        routeMapView.baseLayerType = NSBD_NORMAL;
        [MapViewManager resetLayer:routeMapView];
        
        
    });
    return routeMapView;
}

+(InfoAGSMapView *) sharedDistanceMapView
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        distanceMapView = [[InfoAGSMapView alloc] init];
        distanceMapView.gridLineWidth = 0.1;
        distanceMapView.baseLayerType = NSBD_NORMAL;
        [MapViewManager resetLayer:distanceMapView];
        
        
    });
    return routeMapView;
}

+(InfoAGSMapView *) sharedMapView
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapView = [[InfoAGSMapView alloc] init];
        mapView.gridLineWidth = 0.1;
        
        mapView.baseLayerType = NSBD_NORMAL;
        [MapViewManager resetLayer:mapView];
        
        
        __weak AGSMapView *weakView = mapView;
        mapView.mapViewTouchesCallback = ^{
//            AGSGraphicsLayer *glayer = (AGSGraphicsLayer *)[weakView mapLayerForName:@"Graphics Layer"];
//            if (glayer && glayer.graphics && glayer.graphics.count>0) {
//                [glayer removeAllGraphics];
//            }
        };

    });
    return mapView;
}

+(NSString *)IP
{
    if (!ip || ip.length==0 ) {
        ip = MAPIP;
    }
    return ip;
}

+(void) refreshVisibleLayer:(InfoAGSMapView *)aMapView
{
    TianDiTuWMTSLayer *tiledLayer = (TianDiTuWMTSLayer *)[aMapView mapLayerForName:@"Tiled Layer"];
    
    TianDiTuWMTSLayer *tiledLayer1 = (TianDiTuWMTSLayer *)[aMapView mapLayerForName:@"Tiled Layer1"];
    
    if (aMapView.baseLayerType == NSBD_NORMAL)
    {
        tiledLayer.visible = YES;
        tiledLayer1.visible = NO;
    }else
    {
        tiledLayer1.visible = YES;
        tiledLayer.visible = NO;
    }
    
    AGSLayer *wmsLayer = [aMapView mapLayerForName:@"WMS Layer"];
    wmsLayer.visible = aMapView.layerMask & LayerMaskNSBDLayer;
    
    AGSLayer *glayer = [aMapView mapLayerForName:@"Graphics Layer"];
    
    glayer.visible = aMapView.layerMask & LayerMaskGraphicLayer;
    
    
    AGSLayer *maishenLayer = [aMapView mapLayerForName:@"3DMaishen Layer"];
    maishenLayer.opacity = 0.5f;
    maishenLayer.visible = aMapView.layerMask & LayerMask3DLayer;
}

+(void) resetLayer:(InfoAGSMapView *)aMapView
{
    if (aMapView == nil) {
        return;
    }
    if ([aMapView mapLayers].count>0) {
        for (AGSLayer *layer in [[aMapView mapLayers] copy]) {
            [aMapView removeMapLayer:layer];
        }
    }
    
    
    //Add it to the map view
    TianDiTuWMTSLayer *tiledLayer = [[TianDiTuWMTSLayer alloc] initWithLayerType:NSBD_NORMAL error:nil];
    [aMapView addMapLayer:tiledLayer withName:@"Tiled Layer"];
    
    TianDiTuWMTSLayer *tiledLayer1 = [[TianDiTuWMTSLayer alloc] initWithLayerType:NSBD_IMAGE error:nil];
    
    [aMapView addMapLayer:tiledLayer1 withName:@"Tiled Layer1"];
    
    if (aMapView.baseLayerType == NSBD_NORMAL)
    {
        tiledLayer.visible = YES;
        tiledLayer1.visible = NO;
    }else
    {
        tiledLayer1.visible = YES;
        tiledLayer.visible = NO;
    }
    
    AGSWMSLayer *wmsLayer =  [[AGSWMSLayer alloc] initWithURL:[NSURL URLWithString:
                                                               [NSString stringWithFormat:WMSURL,[MapViewManager IP]]]];
    [aMapView addMapLayer:wmsLayer withName:@"WMS Layer"];
    
    

    AGSGraphicsLayer *glayer = [AGSGraphicsLayer graphicsLayer];
    [aMapView addMapLayer:glayer withName:@"Graphics Layer"];

    
    AGSWMSLayer *maishenLayer =  [[AGSWMSLayer alloc] initWithURL:[NSURL URLWithString:
                                                                   [NSString stringWithFormat:WMS3DURL,[MapViewManager IP]]]];
    [aMapView addMapLayer:maishenLayer withName:@"3DMaishen Layer"];
    
    aMapView.backgroundColor = [UIColor lightGrayColor];

    [self refreshVisibleLayer:aMapView];
}

+(void)SetIP:(NSString *)ip_new
{
    ip = [ip_new copy];
    
    [MapViewManager resetLayer:mapView];
    [MapViewManager resetLayer:routeMapView];
}



@end
