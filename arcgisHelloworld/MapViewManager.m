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
static NSString *ip;

+(InfoAGSMapView *) sharedRouteMapView
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        routeMapView = [[InfoAGSMapView alloc] init];
        routeMapView.gridLineWidth = 0.1;
        
        [MapViewManager resetLayer:routeMapView];
        
        
    });
    return routeMapView;
}

+(InfoAGSMapView *) sharedMapView
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapView = [[InfoAGSMapView alloc] init];
        mapView.gridLineWidth = 0.1;
        
        mapView.layerType = NSBD_NORMAL;
        [MapViewManager resetLayer:mapView];
        
        
        __weak AGSMapView *weakView = mapView;
        mapView.mapViewTouchesCallback = ^{
            AGSGraphicsLayer *glayer = (AGSGraphicsLayer *)[weakView mapLayerForName:@"Graphics Layer"];
            if (glayer && glayer.graphics && glayer.graphics.count>0) {
                [glayer removeAllGraphics];
            }
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
    
//    AGSTiledMapServiceLayer *tiledLayer = [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:
//                                                                                        [NSString stringWithFormat:WMTSRESTURL,[MapViewManager IP]]]];
//    
//    NSBDCustomMapLayer *tiledLayer = [[NSBDCustomMapLayer alloc] initWithMapType:CIVGPS];
    TianDiTuWMTSLayer *tiledLayer = [[TianDiTuWMTSLayer alloc] initWithLayerType:mapView.layerType error:nil];
    
    AGSWMSLayer *wmsLayer =  [[AGSWMSLayer alloc] initWithURL:[NSURL URLWithString:
                                                               [NSString stringWithFormat:WMSURL,[MapViewManager IP]]]];
    

    AGSGraphicsLayer *glayer = [AGSGraphicsLayer graphicsLayer];
    
    //Add it to the map view
    [aMapView addMapLayer:tiledLayer withName:@"Tiled Layer"];
    [aMapView addMapLayer:wmsLayer withName:@"WMS Layer"];
    [aMapView addMapLayer:glayer withName:@"Graphics Layer"];
    
    
    aMapView.backgroundColor = [UIColor lightGrayColor];

}

+(void)SetIP:(NSString *)ip_new
{
    ip = [ip_new copy];
    
    [MapViewManager resetLayer:mapView];
    [MapViewManager resetLayer:routeMapView];
}



@end
