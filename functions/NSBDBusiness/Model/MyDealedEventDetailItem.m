//
//  MyDealedEventDetailItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyDealedEventDetailItem.h"
#import "AttachmentItem.h"

@implementation MyDealedEventDetailItem
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
             @"content":@"content",
             @"fileList":@"fileList",
             };
    
}

+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[AttachmentItem class] forKey:@"fileList"];
    return dict;
}
@end
