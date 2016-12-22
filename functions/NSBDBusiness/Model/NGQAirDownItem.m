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
                 @"temperaturein":@[@(SheetUIStyle_ShortText),@(6)],
                 @"temperatureout":@[@(SheetUIStyle_ShortText),@(7)],
                 @"welllid":@[@(SheetUIStyle_Switch),@(8)],
                 @"wellroom":@[@(SheetUIStyle_Switch),@(9)],
                 @"ladder":@[@(SheetUIStyle_Switch),@(10)],
                 @"gate":@[@(SheetUIStyle_Switch),@(11)],
                 
                 },
             @{
                 @"group":@"",
                 @"remark":@[@(SheetUIStyle_Text),@(1)],
                 },
             ];
    
    
}
@end
