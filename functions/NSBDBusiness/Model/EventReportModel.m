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
#import "TitleInputItem.h"
#import "TitleItem.h"
#import "TitleDetailTextItem.h"
#import "CommitedEventHistoryItem.h"
#import "NSString+UUID.h"

@interface EventReportModel()<EventDetailViewDelegate>

@end

@implementation EventReportModel

-(instancetype) init
{
    if (self = [super init]) {
        _uuid = [NSString stringWithUUID];
    }
    return self;
}
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
    [aCoder encodeObject:_uuid forKey:@"uuid"];
}



-(instancetype) initWithMyEventHistoryItem:(CommitedEventHistoryItem *)item
{
    self = [super init];
    if (self)
    {
        self.eventName = [TitleInputItem itemWithTitle:@"事件名称" placeholder:@"请输入事件名称"];
        self.eventName.detail = item.title;
        self.eventType = [TitleDetailItem itemWithTitle:@"事件类型" detail:@"未填写"];
        self.eventType.detail = item.category;
        
        self.eventXingzhi = [TitleDetailItem itemWithTitle:@"事件性质" detail:@"未填写"];
        self.level = [TitleDetailItem itemWithTitle:@"等级初判" detail:item.responseLevel];
        self.reason = [TitleDetailItem itemWithTitle:@"初步原因" detail:@"未填写"];
        
        
        self.eventDate = [TitleDateItem itemWithTitle:@"事发时间"];
        self.place = [TitleInputItem itemWithTitle:@"事发地点" placeholder:@"请输入地点名称"];
        self.place.detail = item.occurLocation;
        
        self.department = [TitleInputItem itemWithTitle:@"填报部门" placeholder:@"请输入部门名称"];
        self.department.detail = item.alarmPersonContacts;
        
        self.location = CGPointMake([item.spacePosition_x floatValue], [item.spacePosition_y floatValue]);
        
        self.reporter = [TitleInputItem itemWithTitle:@"填报人员" placeholder:@"请输入人员名称"];
        self.reporter.detail = item.alarmPerson;
        
        self.eventStatus = [TitleDetailTextItem itemWithTitle:@"事件情况" detail:@"未填写" text:@""];
        self.eventPreprocess = [TitleDetailTextItem itemWithTitle:@"先期处置情况" detail:@"未填写"  text:@""];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _uuid = [aDecoder decodeObjectForKey:@"uuid"];
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
