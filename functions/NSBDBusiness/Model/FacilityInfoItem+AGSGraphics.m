//
//  FacilityInfoItem+AGSGraphics.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "FacilityInfoItem+AGSGraphics.h"
#import "HttpMetaData.h"

@implementation FacilityInfoItem (AGSGraphics)
-(AGSGraphic *) graphics
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    CGFloat x=0,y=0;
    for (NSString *key in self.orderedKeyIds) {
        HttpMetaData *data = self.info[key];
        if (data.value) {
            dict[key] = data.value;
        }
        if ([key isEqualToString:@"POIY"]) {
            y = [data.value floatValue];
        }else
        if ([key isEqualToString:@"POIX"]) {
            x = [data.value floatValue];
        }
    }
    AGSPoint *point = [AGSPoint pointWithX:x y:y spatialReference:[AGSSpatialReference wgs84SpatialReference]];
    AGSGraphic *graphic = [[AGSGraphic alloc] initWithGeometry:point symbol:nil attributes:dict];
    return graphic;
}
@end
