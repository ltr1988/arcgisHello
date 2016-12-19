//
//  DistanceModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DistanceEngine.h"
#import "UIColor+ThemeColor.h"

#define FIX_RATIO 0.767
@implementation DistanceEngine

-(instancetype) initWithGraphicsLayer:(AGSGraphicsLayer *)layer
{
    if (self = [super init]) {
        _layer = layer;
        _distance = 0;
        _points = [NSMutableArray array];
        _mercator_points = [NSMutableArray array];//agspoint
        _poliLine = [[AGSMutablePolyline alloc] init];
        
        [_poliLine addPathToPolyline];
        _engine = [[AGSGeometryEngine alloc] init];
    }
    return self;
}


-(void) pushPoint:(AGSPoint *)point
{
    AGSPoint *lastPoint = nil;
    [_poliLine addPointToPath:point];

    
    
    AGSSymbol *symbol = [AGSSimpleMarkerSymbol simpleMarkerSymbolWithColor:[UIColor themeBlueColor]];
    AGSGraphic *g_point = [[AGSGraphic alloc] initWithGeometry:point symbol:symbol attributes:nil];
    
    if (_points.count > 0 ) {
        lastPoint = _mercator_points.lastObject;
        
    }
    
    AGSPoint *mpoint = (AGSPoint *)[_engine projectGeometry:point toSpatialReference:[AGSSpatialReference webMercatorSpatialReference]];
    
    [_points addObject:g_point];
    [_mercator_points addObject:mpoint];
    
    [_layer addGraphic:g_point];
    
    if (_g_poliLine) {
        [_layer removeGraphic:_g_poliLine];
    }
    symbol = [AGSSimpleLineSymbol simpleLineSymbolWithColor:[UIColor themeBlueColor] width:4];
    _g_poliLine = [[AGSGraphic alloc] initWithGeometry:_poliLine symbol:symbol attributes:nil];
    [_layer addGraphic:_g_poliLine];
    
    if (_points.count > 1) {
        _distance += [mpoint distanceToPoint:lastPoint] *FIX_RATIO;
    }
}

-(AGSPoint *) popPoint
{
    if (_points.count == 0) {
        return nil;
    }
    if (_points.count == 1) {
        [self clearAll];
        return nil;
    }
    [_poliLine removePointOnPath:0 atIndex:_points.count-1];
    if (_g_poliLine) {
        [_layer removeGraphic:_g_poliLine];
    }
    AGSSymbol *symbol = [AGSSimpleLineSymbol simpleLineSymbolWithColor:[UIColor themeBlueColor] width:4];
    _g_poliLine = [[AGSGraphic alloc] initWithGeometry:_poliLine symbol:symbol attributes:nil];
    [_layer addGraphic:_g_poliLine];
    
    [_layer removeGraphic:_points.lastObject];
    [_points removeLastObject];
    
    
    AGSPoint *mlastPoint = _mercator_points.lastObject;
    
    [_mercator_points removeLastObject];
    AGSPoint *mlast2ndPoint = _mercator_points.lastObject;
    _distance -= [mlastPoint distanceToPoint:mlast2ndPoint] *FIX_RATIO;

    return (AGSPoint *)[_engine projectGeometry:mlast2ndPoint toSpatialReference:[AGSSpatialReference wgs84SpatialReference]];
}

-(void) clearAll
{
    _distance = 0;
    [_points removeAllObjects];
    [_mercator_points removeAllObjects];
    _g_poliLine = nil;
    _poliLine = [[AGSMutablePolyline alloc] init];
    [_poliLine addPathToPolyline];
    [_layer removeAllGraphics];
}


-(NSString *) distanceString
{
    if (_distance<1000) {
        return [NSString stringWithFormat:@"%zd m",(NSUInteger)_distance];
    }
    
    return [NSString stringWithFormat:@"%.1f km",_distance/1000];
}
@end
