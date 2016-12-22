//
//  NGQWellUpItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/21.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NGQWellUpItem.h"

@implementation NGQWellUpItem


-(NSDictionary *)requestInfo
{
    NSMutableDictionary *info = [[super requestInfo] mutableCopy];
    info[@"temperatureout"] = @"";
    return info;
}

-(NSArray *)defaultUIStyleMapping
{
    return @[
             @{
                 @"group":@"",
                 @"wellnum":@[@(SheetUIStyle_ReadonlyText),@(1)],
                 @"exedate":@[@(SheetUIStyle_Date),@(2)],
                 @"weather":@[@(SheetUIStyle_ShortTextWeather),@(3)],
                 @"march":@[@(SheetUIStyle_Switch),@(4)],
                 @"crawl":@[@(SheetUIStyle_Switch),@(5)],
                 @"deviceroom":@[@(SheetUIStyle_Switch),@(6)],
                 @"handwell":@[@(SheetUIStyle_Switch),@(7)],
                 @"arihole":@[@(SheetUIStyle_Switch),@(8)],
                 @"temperaturein":@[@(SheetUIStyle_ShortText),@(9)],
                 @"welllid":@[@(SheetUIStyle_Switch),@(11)],
                 @"wellroom":@[@(SheetUIStyle_Switch),@(12)],
                 @"ladder":@[@(SheetUIStyle_Switch),@(13)],
                 @"repairgate":@[@(SheetUIStyle_Switch),@(14)],
                 @"workgate":@[@(SheetUIStyle_Switch),@(15)],
                 @"exitgate":@[@(SheetUIStyle_Switch),@(16)],
                 
                 @"remark":@[@(SheetUIStyle_Text),@(17)],
                 },
             ];
    
}


-(NSDictionary *)defaultUITextMapping
{
    return @{
             @"wellnum":@"井号",
             @"weather":@"天气情况",
             @"exedate":@"执行时间",
             @"march":@"进场路",
             @"crawl":@"围栏",
             @"deviceroom":@"户外设备间",
             @"handwell":@"手井",
             @"arihole":@"通气孔",
             @"temperaturein":@"室内温度",
             @"welllid":@"井盖",
             @"wellroom":@"井室",
             @"ladder":@"爬梯",
             @"repairgate":@"检修蝶阀",
             @"workgate":@"工作蝶阀",
             @"exitgate":@"出口蝶阀",
             @"remark":@"备注",
             };
}
@end
