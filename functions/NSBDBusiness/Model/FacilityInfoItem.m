//
//  FacilityInfoItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "FacilityInfoItem.h"
#import "HttpMetaData.h"

@implementation FacilityInfoItem

-(instancetype) initWithArray:(NSArray *)infoArray
{
    if (self = [super init]) {
        NSMutableArray *keyids= [NSMutableArray array];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (HttpMetaData *data in infoArray) {
            [keyids addObject:data.dataID];
            dict[data.dataID] = data;
        }
        _info = [dict copy];
        _orderedKeyIds = [keyids copy];
    }
    return self;
}
@end
