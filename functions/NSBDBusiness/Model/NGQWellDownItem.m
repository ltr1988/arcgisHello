//
//  NGQWellDownItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/21.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NGQWellDownItem.h"

@implementation NGQWellDownItem
-(NSArray *)defaultUIStyleMapping
{
    return @[
             @{
                 @"group":@"",
                 // @"wellnum":@[@(SheetUIStyle_ReadonlyText),@(1)],
                 
                 @"exedate":@[@(SheetUIStyle_Date),@(2)],
                 @"weather":@[@(SheetUIStyle_ShortTextWeather),@(3)],
                 },
             @{
                 
                 @"group":@"",
                 @"march":@[@(SheetUIStyle_Switch),@(1)],
                 @"crawl":@[@(SheetUIStyle_Switch),@(2)],
                 @"personwell":@[@(SheetUIStyle_Switch),@(3)],
                 @"arihole":@[@(SheetUIStyle_Switch),@(4)],
                 @"temperatureinh":@[@(SheetUIStyle_ShortTextNum),@(5)],
                 @"temperatureinl":@[@(SheetUIStyle_ShortTextNum),@(6)],
                 @"welllid":@[@(SheetUIStyle_Switch),@(7)],
                 @"wellroom":@[@(SheetUIStyle_Switch),@(8)],
                 @"ladder":@[@(SheetUIStyle_Switch),@(9)],
                 },
             @{
                 @"group":@"自动化设备",
                 @"wirerod_camera":@[@(SheetUIStyle_Switch),@(1)],
                 @"wirerod_audio":@[@(SheetUIStyle_Switch),@(2)],
                 @"wirerod_solar_panel":@[@(SheetUIStyle_Switch),@(3)],
                 @"wirerod_box_lock":@[@(SheetUIStyle_Switch),@(4)],
                 @"out_lock":@[@(SheetUIStyle_Switch),@(5)],
                 @"out_solar":@[@(SheetUIStyle_Switch),@(6)],
                 },
             @{
                 @"group":@"",
                 @"wellrunner":@[@(SheetUIStyle_ShortText),@(1)],
                 @"recorder":@[@(SheetUIStyle_ShortText),@(2)],
                 },
             @{
                 @"group":@"",
                 @"remark":@[@(SheetUIStyle_Text),@(1)],
                 },
             ];
    
}


-(NSDictionary *)defaultUITextMapping
{
    return @{
             @"wellnum":@"井号",
             @"weather":@"天气情况",
             @"exedate":@"时间",
             @"march":@"进场路",
             @"crawl":@"围栏",
             @"personwell":@"人井",
             @"arihole":@"通气孔",
             @"temperatureinh":@"室内最高温度",
             @"temperatureinl":@"室内最低温度",
             @"welllid":@"井盖",
             @"wellroom":@"井室",
             @"ladder":@"扶梯",
             @"wirerod_camera":@"线杆上摄像头",
             @"wirerod_audio":@"线杆上音响",
             @"wirerod_solar_panel":@"线杆上太阳能板",
             @"wirerod_box_lock":@"线杆上箱子门锁",
             @"out_lock":@"户外设备间门锁",
             @"out_solar":@"户外设备间上太阳能板",
             @"recorder":@"记录人",
             @"wellrunner":@"下井人",
             @"remark":@"问题描述",
             };
}
@end
