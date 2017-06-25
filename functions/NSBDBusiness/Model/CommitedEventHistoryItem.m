//
//  CommitedEventHistoryItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "CommitedEventHistoryItem.h"
#import "EventDetailView.h"

@interface CommitedEventHistoryItem()<EventDetailViewDelegate>

@end

@implementation CommitedEventHistoryItem

+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{
             @"eid":@"id",
             @"title" :@"title",
             @"category" :@"category",
             @"responseLevel" :@"responseLevel",
             @"alarmPerson" :@"alarmPerson",
             @"alarmPersonContacts" :@"alarmPersonContacts",
             @"occurLocation" :@"occurLocation",
             @"spacePosition_x" :@"spacePosition_x",
             @"spacePosition_y" :@"spacePosition_y",
             @"departName" :@"departName",
             @"creatorName" :@"creatorName",
             @"reasons":@"reasons",
             @"desc":@"description",
             @"occurTime" :@"occurTime",
             @"status" :@"status",
             };
    
}

-(NSString *) eventDetailViewTitle
{
    if (_title && _title.length>0) {
        
        return _title;
    }
    return @"未填写";
}

-(NSString *) eventDetailViewDate
{
    return _occurTime?:@"";
}

-(NSString *) eventDetailViewPlace
{
    return _occurLocation?:@"";
}

-(NSString *) eventDetailViewFinder
{
    return [NSString stringWithFormat:@"%@-%@",_departName?:@"",_creatorName?:@""];
}

@end


