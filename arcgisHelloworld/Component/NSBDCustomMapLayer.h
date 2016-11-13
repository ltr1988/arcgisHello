//
//  AGSTianDiTuLayer.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Arcgis/Arcgis.h>


typedef enum : NSUInteger {
    CIVGPS,
    CIVYINGXIANG,
} NSBDCustomLayerType;

@interface NSBDCustomMapLayer : AGSTiledServiceLayer

-(instancetype) initWithMapType:(NSBDCustomLayerType) mapType;
@end
