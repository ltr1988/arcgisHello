//
//  MapViewManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MapViewManager.h"
#import "CommonDefine.h"

@implementation MapViewManager
+(AGSMapView *) sharedMapView
{
    static AGSMapView *mapView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapView = [[AGSMapView alloc] init];
        mapView.gridLineWidth = 0.1;
        NSString *ip = HOSTIP;
        
        if ([mapView mapLayers].count>0) {
            for (AGSLayer *layer in [[mapView mapLayers] copy]) {
                [mapView removeMapLayer:layer];
            }
        }
        //AGSCredential *credentail = [[AGSCredential alloc] initWithUser:@"arcgis" password:@"arcgis"];
        AGSTiledMapServiceLayer *tiledLayer = [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:
                                                                                            [NSString stringWithFormat:WMTSRESTURL,ip]]];
        
        
        
        AGSWMSLayer *wmsLayer =  [[AGSWMSLayer alloc] initWithURL:[NSURL URLWithString:
                                                                   [NSString stringWithFormat:WMSURL,ip]]];
        
        
        AGSGraphicsLayer *glayer = [AGSGraphicsLayer graphicsLayer];
        
        //Add it to the map view
        [mapView addMapLayer:tiledLayer withName:@"Tiled Layer"];
        [mapView addMapLayer:wmsLayer withName:@"WMS Layer"];
        [mapView addMapLayer:glayer withName:@"Graphics Layer"];

    });
    return mapView;
}
@end
