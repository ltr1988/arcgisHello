//
//  SearchSessionItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSessionItem.h"
#import "NSDateFormatterHelper.h"
#import "MJExtension.h"

@implementation SearchSessionItem

MJCodingImplementation

-(instancetype) init
{
    if (self = [super init]) {
        _sessionId = @"";
        _sessionStartTime = [[NSDate date] timeIntervalSince1970];
        _sessionTime = 0;
        _pauseState = NO;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    SearchSessionItem *item = [SearchSessionItem new];
    item.sessionId = _sessionId;
    item.sessionTime = _sessionTime;
    item.sessionStartTime = _sessionStartTime;
    item.pauseState = _pauseState;
    item.basicInfo = _basicInfo;
    return item;
}

-(NSInteger) totalTime
{
    return _sessionTime + (_pauseState?0:([[NSDate date] timeIntervalSince1970] - (long long)_sessionStartTime));
}

-(void) resetTime:(BOOL)willPause
{
    if (willPause) {
        [self pause];
    }else
    {
        [self resume];
    }
    _pauseState = willPause;
}

-(void) pause
{
    _sessionTime = _sessionTime + ([[NSDate date] timeIntervalSince1970] - (long long)_sessionStartTime);
}

-(void) resume
{
    
    _sessionStartTime = [[NSDate date] timeIntervalSince1970];
}

-(NSString *) stringStartTime
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_sessionStartTime];
    
    NSDateFormatter *formater = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd-HH:mm:ss"];
    return [formater stringFromDate:date];
}
@end
