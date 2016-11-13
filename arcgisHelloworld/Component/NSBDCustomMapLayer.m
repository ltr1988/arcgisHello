//
//  AGSTianDiTuLayer.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSBDCustomMapLayer.h"
#import "CommonDefine.h"

@implementation NSBDCustomMapLayer
{
    NSBDCustomLayerType _mapType;
    AGSTileInfo *_tileInfo;
    AGSEnvelope *_fullenvelope;
}
-(instancetype) initWithMapType:(NSBDCustomLayerType) mapType
{
    _mapType = mapType;
    self = [super init];
    return self;
}


-(AGSSpatialReference *)spatialReference
{
    return [self fullEnvelope].spatialReference;
}

- (AGSEnvelope *)fullEnvelope
{
    if (!_fullenvelope) {
        _fullenvelope = [AGSEnvelope envelopeWithXmin:-180 ymin:-90 xmax:180 ymax:90 spatialReference:[AGSSpatialReference wgs84SpatialReference]];
    }
    return _fullenvelope;
}


-(NSURL* ) urlForTileKey:(AGSTileKey *)key
{
    NSString *urlString = @"";

    switch (_mapType) {
        case CIVGPS:
            urlString = NEWWMTS_NORMAL_URL((long)key.column,(long)key.row,(long)key.level);
            break;
        case CIVYINGXIANG:
            urlString = NEWWMTS_IMAGE_URL((long)key.column,(long)key.row,(long)key.level);
            break;
    }
    return [NSURL URLWithString:urlString];
}

-(AGSEnvelope *)initialEnvelope{
    return [AGSEnvelope envelopeWithXmin:102.869399 ymin:35.258727 xmax:130.055181 ymax:49.897225 spatialReference:[AGSSpatialReference wgs84SpatialReference]];
}

-(AGSTileInfo *)tileInfo
{
    if (!_tileInfo) {
        AGSPoint *originalPoint= [[AGSPoint alloc] initWithX:115.416683 y:41.059251 spatialReference:[AGSSpatialReference spatialReferenceWithWKID:4326]];
        NSArray * scales = @[@(3241812.067640091),@(1620906.0338200454),@(810453.0169100227),@(405226.50845501135),@(202613.25422750568),@(101306.62711375284),@(50653.31355687642),@(25326.65677843821),@(12663.328389219105),@(6331.664194609552),@(3165.832097304776),@(1582.916048652388),@(791.458024326194),@(395.729012163097),@(197.8645060815485),@(98.93225304077426),@(49.46612652038713),];
        NSArray * resolutions = @[@(0.008168804687499975),@( 0.004084402343749988),@( 0.002042201171874994),@( 0.001021100585937497),@( 5.105502929687485E-4),@( 2.5527514648437423E-4),@( 1.2763757324218711E-4),@( 6.381878662109356E-5),@( 3.190939331054678E-5),@( 1.595469665527339E-5),@( 7.977348327636695E-6),@( 3.988674163818347E-6),@( 1.9943370819091737E-6),@( 9.971685409545868E-7),@( 4.985842704772934E-7),@( 2.492921352386467E-7),@( 1.2464606761932335E-7),];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i=0; i<scales.count; i++) {
            double scale = [scales[i] doubleValue];
            double res = [resolutions[i] doubleValue];
            AGSLOD *lod = [[AGSLOD alloc] initWithLevel:i resolution:res scale:scale];
            [array addObject:lod];
        }
        
        
        _tileInfo = [[AGSTileInfo alloc] initWithDpi:96 format:@"png" lods:array origin:originalPoint spatialReference:[self spatialReference] tileSize:CGSizeMake(256, 256)];
    }
    
    return _tileInfo;
}
@end
