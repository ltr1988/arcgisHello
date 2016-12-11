//
//  MyEventItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventItem.h"

@implementation MyEventItem

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
             @"addTime":@"addTime",
             @"status" :@"status",
             };
    
}
- (NSString *) title{
    return _title;
}
- (NSString *) date{
    return _addTime;
}
- (NSString *) place{
    return _occurLocation;
}

- (NSString *) finder{
    return [NSString stringWithFormat:@"%@ - %@",_departName,_creatorName];
}
- (NSString *) xingzhi{
    
    if ([_category isEqualToString:@"SZWR"]) {
        return @"水质污染";
    }else if ([_category isEqualToString:@"GCAQ"]) {
        return @"工程安全";
    }else if ([_category isEqualToString:@"YJDD"]) {
        return @"应急调度";
    }else if ([_category isEqualToString:@"FXQX"]) {
        return @"防汛抢险";
    }
    return _category;
}
- (NSString *) level{
    switch ([_responseLevel intValue]) {
        case 1:
            return @"一级响应";
        case 2:
            return @"二级响应";
        case 3:
            return @"三级响应";
        case 4:
            return @"四级响应";
        default:
            break;
    }
    return _responseLevel;
}

@end
