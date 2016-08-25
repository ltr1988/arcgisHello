//
//  RouteSearchHistoryItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteSearchResultItem.h"

@implementation RouteSearchResultItem


-(instancetype) init
{
    if (self = [super init]) {
        self.location = CGPointMake(116., 40.);//beijing default
    }
    return self;
}

-(BOOL) isEqual:(id)object
{
    if (self && object) {
        if ([object isKindOfClass:[RouteSearchResultItem class]]) {
            RouteSearchResultItem *item = object;
            return [self.title isEqualToString:item.title];
        }
    }
    
    return NO;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"_title"];
    [aCoder encodeCGPoint:self.location forKey:@"_location"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"_title"];
        self.location = [aDecoder decodeCGPointForKey:@"_location"];
    }
    
    return self;
}
@end
