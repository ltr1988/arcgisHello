//
//  TCHWaterItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/25.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "TCHWaterItem.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "AuthorizeManager.h"
#import "TitleDetailItem.h"

@implementation TCHWaterItem



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
    return @"tchsluice";
}

#pragma mark UILayout

-(NSArray *)defaultUIStyleMapping
{
    return @[
             @{
                 @"group":@"",
                 @"exedate":@[@(SheetUIStyle_Date),@(1)],
                 @"weather":@[@(SheetUIStyle_ShortTextWeather),@(2)],
                 },
             @{
                 @"group":@"建筑物主体结构",
                 @"mainneat":@[@(SheetUIStyle_Switch),@(3)],
                 @"mainwhole":@[@(SheetUIStyle_Switch),@(4)],
                 @"mainserious":@[@(SheetUIStyle_Switch),@(5)],
                 @"mainvoid":@[@(SheetUIStyle_Switch),@(6)],
                 
                 },
             @{
                 @"group":@"涵洞",
                 
                 @"culvertneat":@[@(SheetUIStyle_Switch),@(7)],
                 @"culvertwhole":@[@(SheetUIStyle_Switch),@(8)],
                 @"culvertserious":@[@(SheetUIStyle_Switch),@(9)],
                 @"culvertvoid":@[@(SheetUIStyle_Switch),@(10)],
                 },
             
             @{
                 @"group":@"设备运行状态检查",
                 @"devicerun":@[@(SheetUIStyle_Switch),@(11)],
                 @"devicedisplay":@[@(SheetUIStyle_Switch),@(12)],
                 @"devicepressure":@[@(SheetUIStyle_Switch),@(13)],
                 @"deviceshort":@[@(SheetUIStyle_Switch),@(14)],
                 },
             @{
                 @"group":@"",
                 @"remark":@[@(SheetUIStyle_Text),@(15)],
                 @"solution":@[@(SheetUIStyle_Text),@(16)],
                 },
             ];
    
}


-(NSDictionary *)defaultUITextMapping
{
    return @{
             @"weather":@"天气情况",
             @"exedate":@"执行时间",
             @"remark":@"问题描述",
             @"solution":@"解决方法",
             @"mainneat":@"墙面、地面整洁完好，无破损",
             @"mainwhole":@"整体无缺角、掉角、脱落、漏筋、塌陷、漏水、沉降现象",
             @"mainserious":@"无危及结构安全的裂缝",
             @"mainvoid":@"混凝土表面无蜂窝、麻面、孔洞、漏筋",
             @"culvertneat":@"洞顶、墙面、地面完好，无破损",
             @"culvertwhole":@"整体无缺角、掉角、脱落、漏筋、塌陷、漏水、沉降现象",
             @"culvertserious":@"无危及结构安全的裂缝",
             @"culvertvoid":@"混凝土表面无蜂窝、麻面、孔洞、漏筋",
             @"devicerun":@"设备运转无异常声音、震动；无卡阻，无异味",
             @"devicedisplay":@"信号灯显示正常；仪表读数正常",
             @"devicepressure":@"系统工作压力正常；开关状态正常",
             @"deviceshort":@"元器件无短路、断路、烧蚀、损坏现象",

             };
    

}
@end
