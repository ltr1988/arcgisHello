//
//  TianDiTuWMTSLayerInfoDelegate.m
//  CustomTiledLayerV10.11
//
//  Created by EsriChina_Mobile_MaY on 13-3-28.
//
//
#import "TianDiTuWMTSLayerInfoDelegate.h"
#import "CommonDefine.h"

//
#define SRID    4326

#define X_MIN_2000 115.416683
#define Y_MIN_2000 38.968037
#define X_MAX_2000 117.507897
#define Y_MAX_2000 41.059251


#define X_MIN_INIT 115.416683
#define Y_MIN_INIT 38.968037
#define X_MAX_INIT 117.507897
#define Y_MAX_INIT 41.059251

#define _minZoomLevel 0
#define _maxZoomLevel 16
#define _tileWidth 256
#define _tileHeight 256
#define _dpi 96


@implementation TianDiTuWMTSLayerInfoDelegate

-(TianDiTuWMTSLayerInfo*)getLayerInfo:(TianDiTuLayerTypes) tiandituType{
    
    TianDiTuWMTSLayerInfo *layerInfo = [[TianDiTuWMTSLayerInfo alloc]init];
    //normal parameters
    layerInfo.dpi = _dpi;
    layerInfo.tileHeight = _tileHeight;
    layerInfo.tileWidth = _tileWidth;
    layerInfo.minZoomLevel =_minZoomLevel;
    layerInfo.maxZoomLevel =_maxZoomLevel;
    layerInfo.mapType = tiandituType;
   
    layerInfo.url = [NSString stringWithFormat:@"http://%@:8080/gxpt/service/wmts",MAPIP];
    
    layerInfo.srid = SRID;
    layerInfo.xMax = X_MAX_2000;
    layerInfo.xMin = X_MIN_2000;
    layerInfo.yMax = Y_MAX_2000;
    layerInfo.yMin = Y_MIN_2000;
    
    layerInfo.xInitMax = X_MAX_INIT;
    layerInfo.xInitMin = X_MIN_INIT;
    layerInfo.yInitMax = Y_MAX_INIT;
    layerInfo.yInitMin = Y_MIN_INIT;
    
    layerInfo.origin = [AGSPoint pointWithX:115.416683 y:41.059251 spatialReference:[[AGSSpatialReference alloc]initWithWKID:SRID]];
    NSArray * scales = @[@(3241812.067640091),@(1620906.0338200454),@(810453.0169100227),@(405226.50845501135),@(202613.25422750568),@(101306.62711375284),@(50653.31355687642),@(25326.65677843821),@(12663.328389219105),@(6331.664194609552),@(3165.832097304776),@(1582.916048652388),@(791.458024326194),@(395.729012163097),@(197.8645060815485),@(98.93225304077426),@(49.46612652038713),@(24.733063260193564),@(12.366531630096782),@(6.183265815048391)];
    NSArray * resolutions = @[@(0.008168804687499975),@( 0.004084402343749988),@( 0.002042201171874994),@( 0.001021100585937497),@( 5.105502929687485E-4),@( 2.5527514648437423E-4),@( 1.2763757324218711E-4),@( 6.381878662109356E-5),@( 3.190939331054678E-5),@( 1.595469665527339E-5),@( 7.977348327636695E-6),@( 3.988674163818347E-6),@( 1.9943370819091737E-6),@( 9.971685409545868E-7),@( 4.985842704772934E-7),@( 2.492921352386467E-7),@( 1.2464606761932335E-7),@(6.232303380966168E-8),@( 3.116151690483084E-8),@( 1.558075845241542E-8)];
    
    layerInfo.lods = [NSMutableArray array];
    for (NSInteger i=0; i<scales.count; i++) {
        double scale = [scales[i] doubleValue];
        double res = [resolutions[i] doubleValue];
        AGSLOD *lod = [[AGSLOD alloc] initWithLevel:i resolution:res scale:scale];
        [layerInfo.lods addObject:lod];
    }

    
    return layerInfo;
}
@end
