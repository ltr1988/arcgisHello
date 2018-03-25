//
//  DGQWellItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NGQWellItem.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "AuthorizeManager.h"
#import "TitleDetailItem.h"

@implementation NGQWellItem


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
            info[item.key] = [item.data value];
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
    return @"ngqwell";
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
                 @"march":@[@(SheetUIStyle_Switch),@(4)],
                 @"crawl":@[@(SheetUIStyle_Switch),@(5)],
                 
                 @"personwell":@[@(SheetUIStyle_Switch),@(6)],
                 @"arihole":@[@(SheetUIStyle_Switch),@(7)],
                 @"temperatureinh":@[@(SheetUIStyle_ShortTextNum),@(8)],
                 @"temperatureinl":@[@(SheetUIStyle_ShortTextNum),@(9)],
                 @"welllid":@[@(SheetUIStyle_Switch),@(10)],
                 @"wellroom":@[@(SheetUIStyle_Switch),@(11)],
                 @"ladder":@[@(SheetUIStyle_Switch),@(12)],
                 @"repairgate":@[@(SheetUIStyle_Switch),@(13)],
                 @"workgate":@[@(SheetUIStyle_Switch),@(14)],
                 @"exitgate":@[@(SheetUIStyle_Switch),@(15)],
                 
                 @"wirerod_camera":@[@(SheetUIStyle_Switch),@(16)],
                 @"wirerod_audio":@[@(SheetUIStyle_Switch),@(17)],
                 @"wirerod_solar_panel":@[@(SheetUIStyle_Switch),@(18)],
                 @"wirerod_box_lock":@[@(SheetUIStyle_Switch),@(19)],
                 @"out_lock":@[@(SheetUIStyle_Switch),@(20)],
                 @"out_solar":@[@(SheetUIStyle_Switch),@(21)],
                 @"wellrunner":@[@(SheetUIStyle_ShortText),@(22)],
                 @"recorder":@[@(SheetUIStyle_ShortText),@(23)],
                 
                 @"remark":@[@(SheetUIStyle_Text),@(24)],
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
             @"deviceroom":@"户外设备间",
             @"personwell":@"人井",
             @"handwell":@"手井",
             @"arihole":@"通气孔",
             @"temperaturein":@"室内温度",
             @"temperatureout":@"室外温度",
             @"temperatureinh":@"室内最高温度",
             @"temperatureinl":@"室内最低温度",
             @"welllid":@"井盖",
             @"wellroom":@"井室",
             @"ladder":@"爬梯",
             @"repairgate":@"检修蝶阀",
             @"workgate":@"工作蝶阀",
             @"exitgate":@"出口蝶阀",
             
             @"wirerod_camera":@"线杆上摄像头",
             @"wirerod_audio":@"线杆上音响",
             @"wirerod_solar_panel":@"线杆上太阳能板",
             @"wirerod_box_lock":@"线杆上箱子门锁",
             @"out_lock":@"户外设备间门锁",
             @"out_solar":@"户外设备间太阳能板",
             @"wellrunner":@"下井人",
             @"recorder":@"记录人",
             
             @"remark":@"情况说明",
             };
}

@end

