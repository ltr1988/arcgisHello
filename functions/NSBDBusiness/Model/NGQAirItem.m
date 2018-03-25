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
                 //@"wellnum":@[@(SheetUIStyle_ReadonlyText),@(1)],
                 @"exedate":@[@(SheetUIStyle_Date),@(2)],
                 @"weather":@[@(SheetUIStyle_ShortTextWeather),@(3)],
                 },
             @{
                 @"group":@"",
                 @"march":@[@(SheetUIStyle_Switch),@(1)],
                 @"crawl":@[@(SheetUIStyle_Switch),@(2)],
//                 @"deviceroom":@[@(SheetUIStyle_Switch),@(3)],
                 @"personwell":@[@(SheetUIStyle_Switch),@(4)],
                 @"arihole":@[@(SheetUIStyle_Switch),@(5)],
                 },
             @{
                 @"group":@"左线",
                 @"left_welllid":@[@(SheetUIStyle_Switch),@(1)],
                 @"left_ladder":@[@(SheetUIStyle_Switch),@(2)],
                 @"left_wellroom":@[@(SheetUIStyle_Switch),@(3)],
                 @"left_gate":@[@(SheetUIStyle_Switch),@(4)],
                 },
             @{
                 @"group":@" 室内温度",
                 @"left_temperatureinh":@[@(SheetUIStyle_ShortTextNum),@(1)],
                 @"left_temperatureinl":@[@(SheetUIStyle_ShortTextNum),@(2)],
                 },
             @{
                 @"group":@"右线",
                 @"right_welllid":@[@(SheetUIStyle_Switch),@(1)],
                 @"right_ladder":@[@(SheetUIStyle_Switch),@(2)],
                 @"right_wellroom":@[@(SheetUIStyle_Switch),@(3)],
                 @"right_gate":@[@(SheetUIStyle_Switch),@(4)],
                 },
             @{
                 @"group":@" 室内温度",
                 @"right_temperatureinh":@[@(SheetUIStyle_ShortTextNum),@(1)],
                 @"right_temperatureinl":@[@(SheetUIStyle_ShortTextNum),@(2)],
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
                 @"group":@"下井人",
                 @"left_wellrunner":@[@(SheetUIStyle_ShortText),@(1)],
                 @"right_wellrunner":@[@(SheetUIStyle_ShortText),@(2)],
                 },
             @{
                 @"group":@"",
                 @"recorder":@[@(SheetUIStyle_ShortText),@(1)],
                 },
             @{
                 @"group":@"xx",
                 @"temperatureinh":@[@(SheetUIStyle_ShortTextNum),@(1)],
                 @"temperatureinl":@[@(SheetUIStyle_ShortTextNum),@(2)],
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
             @"exedate":@"时间",
             @"march":@"进场路",
             @"crawl":@"围栏",
//             @"deviceroom":@"户外设备间",
             @"handwell":@"手井",
             @"personwell":@"人井",
             @"arihole":@"通气孔",
             @"right_temperatureinh":@"  最高",
             @"right_welllid":@"井盖",
             @"right_wellroom":@"井室",
             @"right_ladder":@"扶梯",
             @"right_gate":@"阀体",
             @"right_temperatureinl":@"  最低",
             @"left_temperatureinh":@"  最高",
             @"left_welllid":@"井盖",
             @"left_wellroom":@"井室",
             @"left_ladder":@"扶梯",
             @"left_gate":@"阀体",
             @"left_temperatureinl":@"  最低",
             @"temperatureinh":@"室内最高温度",
             @"temperatureinl":@"室内最低温度",
             @"welllid":@"井盖",
             @"terrace":@"平台",
             @"wellroom":@"井室",
             @"ladder":@"扶梯",
             @"gate":@"阀体",
             @"remark":@"问题描述",
             @"wirerod_camera":@"线杆上摄像头",
             @"wirerod_audio":@"线杆上音响",
             @"wirerod_solar_panel":@"线杆上太阳能板",
             @"wirerod_box_lock":@"线杆上箱子门锁",
             @"out_lock":@"户外设备间门锁",
             @"out_solar":@"户外设备间上太阳能板",
             @"recorder":@"记录人",
             @"wellrunner":@"下井人",
             @"left_wellrunner":@"左线下井人",
             @"right_wellrunner":@"右线下井人",
             };
}


@end
