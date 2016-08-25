//
//  SearchSessionItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSessionItem.h"

@implementation SearchSessionItem

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.sessionId forKey:@"_sessionId"];
    [aCoder encodeInteger:self.sessionTime forKey:@"_sessionTime"];
    [aCoder encodeDouble:self.sessionStartTime forKey:@"_sessionStartTime"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.sessionId = [aDecoder decodeObjectForKey:@"_sessionId"];
        self.sessionTime = [aDecoder decodeIntegerForKey:@"_sessionTime"];
        self.sessionStartTime = [aDecoder decodeDoubleForKey:@"_sessionStartTime"];
    }
    
    return self;
}

-(instancetype) init
{
    if (self = [super init]) {
        _sessionId = @"";
        _sessionStartTime = 0.;
        _sessionTime = 0;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    SearchSessionItem *item = [SearchSessionItem new];
    item.sessionId = _sessionId;
    item.sessionTime = _sessionTime;
    item.sessionStartTime = _sessionStartTime;
    return item;
}
@end
