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
                 @"wellnum":@[@(SheetUIStyle_ReadonlyText),@(1)],
                 @"exedate":@[@(SheetUIStyle_Date),@(2)],
                 @"weather":@[@(SheetUIStyle_ShortTextWeather),@(3)],
                 @"march":@[@(SheetUIStyle_Switch),@(4)],
                 @"crawl":@[@(SheetUIStyle_Switch),@(5)],
                 @"deviceroom":@[@(SheetUIStyle_Switch),@(6)],
                 @"handwell":@[@(SheetUIStyle_Switch),@(7)],
                 @"arihole":@[@(SheetUIStyle_Switch),@(8)],
                 @"temperaturein":@[@(SheetUIStyle_ShortText),@(9)],
                 @"temperatureout":@[@(SheetUIStyle_ShortText),@(10)],
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
             @"temperatureout":@"室外温度",
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

