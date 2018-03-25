//
//  NGQAirDownItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/21.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NGQAirDownItem.h"

@implementation NGQAirDownItem


-(NSDictionary *)requestInfo{
    NSMutableDictionary *info = [[super requestInfo] mutableCopy];
    
    NSArray * ar =@[
                    @"right_welllid",
                    @"right_wellroom",
                    @"right_ladder",
                    @"right_gate",
                    @"right_temperatureinl",
                    @"right_temperatureinh",
                    @"left_welllid",
                    @"left_wellroom",
                    @"left_ladder"  ,
                    @"left_gate",
                    @"left_temperatureinl",
                    @"left_temperatureinh",
                    ];
    for (NSString *key in ar) {
        info[key] = @(0);
    }
    
    return info;
}

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
                 @"welllid":@[@(SheetUIStyle_Switch),@(5)],
                 @"terrace":@[@(SheetUIStyle_Switch),@(6)],
                 @"ladder":@[@(SheetUIStyle_Switch),@(7)],
                 @"wellroom":@[@(SheetUIStyle_Switch),@(8)],
                 @"gate":@[@(SheetUIStyle_Switch),@(9)],
                 @"temperatureinh":@[@(SheetUIStyle_ShortText),@(10)],
                 @"temperatureinl":@[@(SheetUIStyle_ShortText),@(11)],
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
@end
