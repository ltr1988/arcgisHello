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
#import "UploadAttachmentModel.h"

@interface EventReportModel()<EventDetailViewDelegate>

@end

@implementation EventReportModel

-(BOOL) isEqual:(id)object
{
    if (object && [object isKindOfClass:[self class]]) {
        EventReportModel *model =(EventReportModel*) object;
        return [model.uuid isEqual:self.uuid];
    }
    return NO;
}

-(instancetype) init
{
    if (self = [super init]) {
        _uuid = [NSString stringWithUUID];
    }
    return self;
}


-(void) parseEventModelToHttpModel
{
    if ([self.eventType.detail isEqualToString:@"水质污染"]) {
        self.eventType.detail = @"SZWR";
    }else if ([self.eventType.detail isEqualToString:@"工程安全"]) {
        self.eventType.detail = @"GCAQ";
    }else if ([self.eventType.detail isEqualToString:@"应急调度"]) {
        self.eventType.detail = @"YJDD";
    }else if ([self.eventType.detail isEqualToString:@"防汛抢险"]) {
        self.eventType.detail = @"FXQX";
    }
    
    if ([self.level.detail isEqualToString:@"一级响应"]) {
        self.level.detail = @"1";
    }else if ([self.level.detail isEqualToString:@"二级响应"]) {
        self.level.detail = @"2";
    }else if ([self.level.detail isEqualToString:@"三级响应"]) {
        self.level.detail = @"3";
    }else if ([self.level.detail isEqualToString:@"四级响应"]) {
        self.level.detail = @"4";
    }else if ([self.level.detail isEqualToString:@"五级响应"]) {
        self.level.detail = @"5";
    }
}

-(void) parseHttpModelToEventModel
{
    if ([self.eventType.detail isEqualToString:@"SZWR"]) {
        self.eventType.detail = @"水质污染";
    }else if ([self.eventType.detail isEqualToString:@"GCAQ"]) {
        self.eventType.detail = @"工程安全";
    }else if ([self.eventType.detail isEqualToString:@"YJDD"]) {
        self.eventType.detail = @"应急调度";
    }else if ([self.eventType.detail isEqualToString:@"FXQX"]) {
        self.eventType.detail = @"防汛抢险";
    }
    
    if ([self.level.detail isEqualToString:@"1"]) {
        self.level.detail = @"一级响应";
    }else if ([self.level.detail isEqualToString:@"2"]) {
        self.level.detail = @"二级响应";
    }else if ([self.level.detail isEqualToString:@"3"]) {
        self.level.detail = @"三级响应";
    }else if ([self.level.detail isEqualToString:@"4"]) {
        self.level.detail = @"四级响应";
    }else if ([self.level.detail isEqualToString:@"5"]) {
        self.level.detail = @"五级响应";
    }
}

-(instancetype) initWithMyEventHistoryItem:(CommitedEventHistoryItem *)item
{
    self = [super init];
    if (self)
    {
        self.uuid = item.eid;
        self.eventName = [TitleInputItem itemWithTitle:@"事件名称" placeholder:@"请输入事件名称"];
        self.eventName.detail = item.title;
        self.eventType = [TitleDetailItem itemWithTitle:@"事件类型" detail:@"未填写"];
        self.eventType.detail = item.category;
//        
//        self.eventXingzhi = [TitleDetailItem itemWithTitle:@"事件性质" detail:@"未填写"];
        self.level = [TitleDetailItem itemWithTitle:@"等级初判" detail:item.responseLevel];
        self.reason = [TitleDetailItem itemWithTitle:@"初步原因" detail:@"未填写"];
        
        
        self.eventDate = [TitleDateItem itemWithTitle:@"事发时间"];
        self.place = [TitleInputItem itemWithTitle:@"事发地点" placeholder:@"请输入地点名称"];
        self.place.detail = item.occurLocation;
        
//        self.department = [TitleInputItem itemWithTitle:@"填报部门" placeholder:@"请输入部门名称"];
//        self.department.detail = item.alarmPersonContacts;
        
        self.location = CGPointMake([item.spacePosition_x floatValue], [item.spacePosition_y floatValue]);
        
        self.reporter = [TitleInputItem itemWithTitle:@"填报人员" placeholder:@"请输入人员名称"];
        self.reporter.detail = [NSString stringWithFormat:@"%@-%@",item.departName,item.creatorName];
        
        self.eventStatus = [TitleDetailTextItem itemWithTitle:@"事件情况" detail:@"未填写" text:@""];
        [self parseHttpModelToEventModel];
    }
    
    return self;
}
-(UploadAttachmentModel *)attachmentModel
{
    if (!_attachmentModel) {
        _attachmentModel = [[UploadAttachmentModel alloc] init];
    }
    return _attachmentModel;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_eventName forKey:@"_eventName"];
    [aCoder encodeObject:_eventType forKey:@"_eventType"];
//    [aCoder encodeObject:_eventXingzhi forKey:@"_eventXingzhi"];
    [aCoder encodeObject:_eventDate forKey:@"_eventDate"];
    [aCoder encodeObject:_level forKey:@"_level"];
    [aCoder encodeObject:_reason forKey:@"_reason"];
    [aCoder encodeObject:_place forKey:@"_place"];
//    [aCoder encodeObject:_department forKey:@"_department"];
    
//    [aCoder encodeObject:_reporter forKey:@"_reporter"];
    [aCoder encodeDouble:_location.x forKey:@"locationX"];
    [aCoder encodeDouble:_location.y forKey:@"locationY"];
    [aCoder encodeObject:_eventStatus forKey:@"_eventStatus"];
    
    [aCoder encodeObject:_attachmentModel forKey:@"_attachmentModel"];
    [aCoder encodeObject:_uuid forKey:@"uuid"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _uuid = [aDecoder decodeObjectForKey:@"uuid"];
        _eventName = [aDecoder decodeObjectForKey:@"_eventName"];
        _eventType = [aDecoder decodeObjectForKey:@"_eventType"];
//        _eventXingzhi = [aDecoder decodeObjectForKey:@"_eventXingzhi"];
        _eventDate = [aDecoder decodeObjectForKey:@"_eventDate"];
        _level = [aDecoder decodeObjectForKey:@"_level"];
        _reason = [aDecoder decodeObjectForKey:@"_reason"];
        _place = [aDecoder decodeObjectForKey:@"_place"];
//        _department = [aDecoder decodeObjectForKey:@"_department"];
        
//        _reporter = [aDecoder decodeObjectForKey:@"_reporter"];
        _location = CGPointMake([aDecoder decodeDoubleForKey:@"locationX"],
                                [aDecoder decodeDoubleForKey:@"locationY"]);
        _eventStatus = [aDecoder decodeObjectForKey:@"_eventStatus"];
        
        _attachmentModel = [aDecoder decodeObjectForKey:@"_attachmentModel"];
    }
    
    return self;
}

#pragma mark eventDetailViewDelegate
-(NSString *) eventDetailViewTitle
{
    if (_eventName.detail && _eventName.detail.length>0) {
        
        return _eventName.detail;
    }
    return @"未填写";
}

-(NSString *) eventDetailViewDate
{
    if (_eventDate.detail && _eventName.detail.length>0) {
        
        return _eventDate.detail;
    }
    return @"未填写";
}

-(NSString *) eventDetailViewPlace
{
    if (_place.detail && _place.detail.length>0) {
        
        return _place.detail;
    }
    return @"未填写";
}

-(NSString *) eventDetailViewFinder
{
    if (_reporter.detail && _reporter.detail.length>0) {
        
        return _reporter.detail;
    }
    return @"未填写上报人";
}
@end
