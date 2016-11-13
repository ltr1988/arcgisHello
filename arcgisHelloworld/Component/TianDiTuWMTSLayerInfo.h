//
//  TianDiTuWMTSLayerInfo.h
//  CustomTiledLayerV10.11
//
//  Created by EsriChina_Mobile_MaY on 13-3-28.
//
//

#import <Foundation/Foundation.h>
@class AGSPoint;

@interface TianDiTuWMTSLayerInfo : NSObject

@property (nonatomic,strong) NSString *url;
@property (nonatomic,assign) int minZoomLevel;
@property (nonatomic,assign) int maxZoomLevel;
@property (nonatomic,assign) double xMin;
@property (nonatomic,assign) double yMin;
@property (nonatomic,assign) double xMax;
@property (nonatomic,assign) double yMax;
@property (nonatomic,assign) double xInitMin;
@property (nonatomic,assign) double yInitMin;
@property (nonatomic,assign) double xInitMax;
@property (nonatomic,assign) double yInitMax;
@property (nonatomic,assign) int tileWidth;
@property (nonatomic,assign) int tileHeight;
@property (nonatomic,strong) NSMutableArray *lods;
@property (nonatomic,assign) int dpi;
@property (nonatomic,assign) int srid;
@property (nonatomic,strong) AGSPoint *origin;
@property (nonatomic,assign) int mapType;

@end
