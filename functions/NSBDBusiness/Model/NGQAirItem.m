//
//  NGQAirItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NGQAirItem.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "TitleDetailItem.h"
#import "AuthorizeManager.h"

@implementation NGQAirItem
-(instancetype) init
{
    self = [super init];
    if (self) {
        self.wellnum = @"";
        self.wellname = @"";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.wellnum forKey:@"wellnum"];
    [aCoder encodeObject:self.wellname forKey:@"wellname"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.wellname = [aDecoder decodeObjectForKey:@"wellname"];
        self.wellnum = [aDecoder decodeObjectForKey:@"wellnum"];
    }
    
    return self;
}

-(void) setWellnum:(NSString *)wellnum
{
    _wellnum = wellnum;
    for (SearchSheetGroupItem *group in self.infolist) {
        for (SearchSheetInfoItem *item in group.items) {
            if ([item.key isEqualToString:@"wellnum"]) {
                TitleDetailItem *detailItem = (TitleDetailItem *)item.data;
                detailItem.detail = wellnum;
            }
        }
    }
}

#pragma mark protocal
-(NSDictionary *)requestInfo
{
    NSMutableDictionary *info = [[super requestInfo] mutableCopy];
    for (SearchSheetGroupItem *group in self.infolist) {
        for (SearchSheetInfoItem *item in group.items) {
            if (item.uiStyle == SheetUIStyle_Switch) {
                info[item.key] = @([[item.data value] integerValue]);
            }else
            {
                info[item.key] = [item.data value];
            }
        }
    }
    info[@"taskid"] = self.taskid;
    info[@"id"] = self.itemId;
    info[@"wellname"] = self.wellname;
    info[@"operate"] = @"insert";
    info[@"userName"] = [AuthorizeManager sharedInstance].userName;

    
    return info;
}

-(NSString *) actionKey
{
    return @"ngqair";
}
#pragma mark UILayout

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
                 @"group":@"右",
                 @"right_temperatureinh":@[@(SheetUIStyle_ShortText),@(1)],
                 @"right_welllid":@[@(SheetUIStyle_Switch),@(2)],
                 @"right_wellroom":@[@(SheetUIStyle_Switch),@(3)],
                 @"right_ladder":@[@(SheetUIStyle_Switch),@(4)],
                 @"right_gate":@[@(SheetUIStyle_Switch),@(5)],
                 @"right_temperatureinl":@[@(SheetUIStyle_ShortText),@(6)],
                 },
             @{
                 @"group":@"左",
                 @"left_temperatureinh":@[@(SheetUIStyle_ShortText),@(1)],
                 @"left_welllid":@[@(SheetUIStyle_Switch),@(2)],
                 @"left_wellroom":@[@(SheetUIStyle_Switch),@(3)],
                 @"left_ladder":@[@(SheetUIStyle_Switch),@(4)],
                 @"left_gate":@[@(SheetUIStyle_Switch),@(5)],
                 @"left_temperatureinl":@[@(SheetUIStyle_ShortText),@(6)],
                 },
             @{
                 @"group":@"xx",
                 @"temperaturein":@[@(SheetUIStyle_ShortText),@(1)],
                 @"temperatureout":@[@(SheetUIStyle_ShortText),@(2)],
                 @"welllid":@[@(SheetUIStyle_Switch),@(3)],
                 @"wellroom":@[@(SheetUIStyle_Switch),@(4)],
                 @"ladder":@[@(SheetUIStyle_Switch),@(5)],
                 @"gate":@[@(SheetUIStyle_Switch),@(6)],
                 
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
             @"exedate":@"执行时间",
             @"march":@"进场路",
             @"crawl":@"围栏",
             @"deviceroom":@"户外设备间",
             @"handwell":@"手井",
             @"arihole":@"通气孔",
             @"right_temperatureinh":@"室内温度高",
             @"right_welllid":@"井盖",
             @"right_wellroom":@"井室",
             @"right_ladder":@"爬梯",
             @"right_gate":@"阀体",
             @"right_temperatureinl":@"室内温度低",
             @"left_temperatureinh":@"室内温度高",
             @"left_welllid":@"井盖",
             @"left_wellroom":@"井室",
             @"left_ladder":@"爬梯",
             @"left_gate":@"阀体",
             @"left_temperatureinl":@"室内温度低",
             @"temperaturein":@"室内温度",
             @"temperatureout":@"室外温度",
             @"welllid":@"井盖",
             @"wellroom":@"井室",
             @"ladder":@"扶梯",
             @"gate":@"阀体",
             @"remark":@"备注",
             };
}


@end
