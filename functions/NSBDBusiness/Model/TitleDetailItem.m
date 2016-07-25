//
//  TitleDetailItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleDetailItem.h"

@implementation TitleDetailItem
+(instancetype) itemWithTitle:(NSString *)title detail:(NSString *)detail
{
    TitleDetailItem *item = [TitleDetailItem new];
    item.title = title;
    item.detail = detail;
    return item;
}
@end



@implementation TitleDateItem
-(NSString *) detail
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *str=[outputFormatter stringFromDate:_date];
    return str;
}

+(instancetype) itemWithTitle:(NSString *)title
{
    TitleDateItem *item = [TitleDateItem new];
    item.title = title;
    item.date = [NSDate date];
    return item;
}
@end



@implementation TitleInputItem
+(instancetype) itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder
{
    TitleInputItem *item = [TitleInputItem new];
    item.title = title;
    item.detail = @"";
    item.placeholder = placeholder;
    return item;
}
@end
