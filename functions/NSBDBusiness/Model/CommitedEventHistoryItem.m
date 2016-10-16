//
//  CommitedEventHistoryItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "CommitedEventHistoryItem.h"

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
             
             @"occurTime" :@"occurTime",
             @"status" :@"status",
             };
    
}

@end


