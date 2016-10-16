//
//  MyDealedEventItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyDealedEventItem.h"

@implementation MyDealedEventItem
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{
             @"eid":@"id",
             @"title" :@"title",
             @"creator" :@"creator",
             @"departmentName" :@"departmentName",
             @"executorName" :@"executorName",
             @"alarmPersonContacts" :@"alarmPersonContacts",
             @"makeTime" :@"makeTime",
             @"name" :@"name",
             @"status" :@"status",
             };
    
}

//- (NSString *) title;
//- (NSString *) name

- (NSString *) date
{
    return _makeTime;
}

- (NSString *) executor
{
    return [NSString stringWithFormat:@"%@ - %@",_departmentName,_executorName];
}
@end
