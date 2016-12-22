//
//  NGQAirUpItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/21.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NGQAirUpItem.h"

@implementation NGQAirUpItem


-(NSDictionary *)requestInfo{
    NSMutableDictionary *info = [[super requestInfo] mutableCopy];
    
    NSArray * ar =@[@"temperaturein",
                    @"temperatureout",
                    @"welllid",
                    @"wellroom",
                    @"ladder",
                    @"gate",];
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
                 @"wellnum":@[@(SheetUIStyle_ReadonlyText),@(1)],
                 @"exedate":@[@(SheetUIStyle_Date),@(2)],
                 @"weather":@[@(SheetUIStyle_ShortTextWeather),@(3)],
                 },
             @{
                 @"group":@"",
                 @"march":@[@(SheetUIStyle_Switch),@(1)],
                 @"crawl":@[@(SheetUIStyle_Switch),@(2)],
                 @"deviceroom":@[@(SheetUIStyle_Switch),@(3)],
                 @"handwell":@[@(SheetUIStyle_Switch),@(4)],
                 @"arihole":@[@(SheetUIStyle_Switch),@(5)],
                 },
             @{
                 @"group":@"右线",
                 @"right_welllid":@[@(SheetUIStyle_Switch),@(1)],
                 @"right_wellroom":@[@(SheetUIStyle_Switch),@(2)],
                 @"right_ladder":@[@(SheetUIStyle_Switch),@(3)],
                 @"right_gate":@[@(SheetUIStyle_Switch),@(4)],
                 @"right_temperatureinl":@[@(SheetUIStyle_ShortText),@(5)],
                 
                 @"right_temperatureinh":@[@(SheetUIStyle_ShortText),@(6)],
                 },
             @{
                 @"group":@"左线",
                 @"left_welllid":@[@(SheetUIStyle_Switch),@(1)],
                 @"left_wellroom":@[@(SheetUIStyle_Switch),@(2)],
                 @"left_ladder":@[@(SheetUIStyle_Switch),@(3)],
                 @"left_gate":@[@(SheetUIStyle_Switch),@(4)],
                 @"left_temperatureinl":@[@(SheetUIStyle_ShortText),@(5)],
                 @"left_temperatureinh":@[@(SheetUIStyle_ShortText),@(6)],
                 },
             @{
                 @"group":@"",
                 @"remark":@[@(SheetUIStyle_Text),@(1)],
                 },
             ];
    
    
}

@end
