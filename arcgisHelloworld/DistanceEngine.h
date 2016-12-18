//
//  DistanceModel.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistanceEngine : NSObject
@property (nonatomic,strong,readonly) AGSGraphicsLayer *layer;
@property (nonatomic,strong,readonly) AGSGeometryEngine *engine;
@property (nonatomic,strong,readonly) AGSGraphic *g_poliLine;
@property (nonatomic,strong,readonly) NSMutableArray *points;
@property (nonatomic,strong,readonly) NSMutableArray *mercator_points;
@property (nonatomic,strong,readonly) AGSMutablePolyline *poliLine;
@property (nonatomic,assign,readonly) double distance;


-(instancetype) initWithGraphicsLayer:(AGSGraphicsLayer *)layer;
-(void) clearAll;
-(void) pushPoint:(AGSPoint *)point;
-(AGSPoint *) popPoint;

-(NSString *) distanceString;

@end
