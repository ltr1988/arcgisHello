//
//  TiandituWMTSLayer_Vec.h
//  CustomTiledLayerSample
//
//  Created by EsriChina_Mobile_MaY on 13-3-27.
//
//
#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>
#import "TianDiTuWMTSLayerInfo.h"
typedef enum {
    NSBD_NORMAL,
    NSBD_IMAGE,
} TianDiTuLayerTypes;

@interface TianDiTuWMTSLayer : AGSTiledLayer
{
    @protected
	AGSTileInfo* _tileInfo;
	AGSEnvelope* _fullEnvelope;
    
	AGSUnits _units;
    TianDiTuWMTSLayerInfo* layerInfo;
    NSOperationQueue* requestQueue;
}
/* ogc wmts url,like ""
//LocalServiceURL can be nil if use "http://t0.tianditu.cn/vec_c/wmts",otherwise input your local service url.
 */
-(instancetype)initWithLayerType:(TianDiTuLayerTypes) tiandituType error:(NSError**) outError;
@end
