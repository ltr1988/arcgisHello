//
//  EventReportModel.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventReportModel.h"
#import "EventDetailView.h"
#import "CheckableTitleItem.h"
#import "TitleDetailItem.h"
#import "TitleDateItem.h"
#import "TitleItem.h"
#import "TitleDetailTextItem.h"

@interface EventReportModel()<EventDetailViewDelegate>

@end

@implementation EventReportModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_eventName forKey:@"_eventName"];
    [aCoder encodeObject:_eventType forKey:@"_eventType"];
    [aCoder encodeObject:_eventXingzhi forKey:@"_eventXingzhi"];
    [aCoder encodeObject:_eventDate forKey:@"_eventDate"];
    [aCoder encodeObject:_level forKey:@"_level"];
    [aCoder encodeObject:_reason forKey:@"_reason"];
    [aCoder encodeObject:_place forKey:@"_place"];
    [aCoder encodeObject:_department forKey:@"_department"];
    
    [aCoder encodeObject:_reporter forKey:@"_reporter"];
    [aCoder encodeDouble:_location.x forKey:@"locationX"];
    [aCoder encodeDouble:_location.y forKey:@"locationY"];
    [aCoder encodeObject:_eventStatus forKey:@"_eventStatus"];
    [aCoder encodeObject:_eventPreprocess forKey:@"_eventPreprocess"];
    
    [aCoder encodeObject:_eventPic forKey:@"_eventPic"];
    [aCoder encodeObject:_eventVideo forKey:@"_eventVideo"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        _eventName = [aDecoder decodeObjectForKey:@"_eventName"];
        _eventType = [aDecoder decodeObjectForKey:@"_eventType"];
        _eventXingzhi = [aDecoder decodeObjectForKey:@"_eventXingzhi"];
        _eventDate = [aDecoder decodeObjectForKey:@"_eventDate"];
        _level = [aDecoder decodeObjectForKey:@"_level"];
        _reason = [aDecoder decodeObjectForKey:@"_reason"];
        _place = [aDecoder decodeObjectForKey:@"_place"];
        _department = [aDecoder decodeObjectForKey:@"_department"];
        
        _reporter = [aDecoder decodeObjectForKey:@"_reporter"];
        _location = CGPointMake([aDecoder decodeDoubleForKey:@"locationX"],
                                [aDecoder decodeDoubleForKey:@"locationY"]);
        _eventStatus = [aDecoder decodeObjectForKey:@"_eventStatus"];
        _eventPreprocess = [aDecoder decodeObjectForKey:@"_eventPreprocess"];
        
        _eventPic = [aDecoder decodeObjectForKey:@"_eventPic"];
        _eventVideo = [aDecoder decodeObjectForKey:@"_eventVideo"];
    }
    
    return self;
}

#pragma mark eventDetailViewDelegate
-(NSString *) eventDetailViewTitle
{
    if (_eventName.detail && _eventName.detail.length>0) {
        
        return _eventName.detail;
    }
    return @"";
}

-(NSString *) eventDetailViewDate
{
    if (_eventDate.detail && _eventName.detail.length>0) {
        
        return _eventDate.detail;
    }
    return @"";
}

-(NSString *) eventDetailViewPlace
{
    if (_place.detail && _place.detail.length>0) {
        
        return _place.detail;
    }
    return @"";
}

-(NSString *) eventDetailViewFinder
{
    if (_reporter.detail && _reporter.detail.length>0) {
        
        return _reporter.detail;
    }
    return @"";
}
@end
