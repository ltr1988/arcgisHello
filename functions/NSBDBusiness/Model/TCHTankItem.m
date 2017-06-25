//
//  TCHTankItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/25.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "TCHTankItem.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "AuthorizeManager.h"
#import "TitleDetailItem.h"
@implementation TCHTankItem


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
    return @"tchtank";
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
                 @"group":@"管理房主体结构",
                 @"mainneat":@[@(SheetUIStyle_Switch),@(3)],
                 @"mainsolid":@[@(SheetUIStyle_Switch),@(4)],
                 @"mainwhole":@[@(SheetUIStyle_Switch),@(5)],
                 @"mainserious":@[@(SheetUIStyle_Switch),@(6)],
                 @"mainvoid":@[@(SheetUIStyle_Switch),@(7)],
                 },
             @{
                 @"group":@"管理房门窗",
                 @"doorsolid":@[@(SheetUIStyle_Switch),@(8)],
                 @"doorneat":@[@(SheetUIStyle_Switch),@(9)],
                 @"doorwhole":@[@(SheetUIStyle_Switch),@(10)],
                 },
             
             @{
                 @"group":@"管理房水电、采暖设施",
                 @"conduitsolid":@[@(SheetUIStyle_Switch),@(11)],
                 @"conduitserious":@[@(SheetUIStyle_Switch),@(12)],
                 @"conduitleakage":@[@(SheetUIStyle_Switch),@(13)],
                 @"conduitshort":@[@(SheetUIStyle_Switch),@(14)],
                 @"conduitdamage":@[@(SheetUIStyle_Switch),@(15)],
                 },
             
             @{
                 @"group":@"管理房装饰装修",
                 
                 @"decorateneat":@[@(SheetUIStyle_Switch),@(16)],
                 @"decorateclear":@[@(SheetUIStyle_Switch),@(17)],
                 @"decoratedamage":@[@(SheetUIStyle_Switch),@(18)],
                 },
             
             @{
                 @"group":@"电缆夹层主体结构",
                 
                 @"cablemainvoid":@[@(SheetUIStyle_Switch),@(19)],
                 @"cablemainserious":@[@(SheetUIStyle_Switch),@(20)],
                 @"cablemainfreeze":@[@(SheetUIStyle_Switch),@(21)],
                 },
             
             @{
                 @"group":@"电缆夹层设备",
                 
                 @"cableequipserious":@[@(SheetUIStyle_Switch),@(22)],
                 @"cableequipleakage":@[@(SheetUIStyle_Switch),@(23)],
                 @"cableequipsolid":@[@(SheetUIStyle_Switch),@(24)],
                 },
             
             @{
                 @"group":@"庭院外观检查",
                 
                 @"courtyardneat":@[@(SheetUIStyle_Switch),@(25)],
                 },
             
             @{
                 @"group":@"三闸广场",
                 
                 @"squareneat":@[@(SheetUIStyle_Switch),@(26)],
                 },
             
             @{
                 @"group":@"围栏护网",
                 
                 @"enclosurewhole":@[@(SheetUIStyle_Switch),@(27)],
                 },
             @{
                 @"group":@"围栏围墙",
                 
                 @"enclowallwhole":@[@(SheetUIStyle_Switch),@(28)],
                 },
             @{
                 @"group":@"道路、护坡、护栏爬梯外观检查",
                 
                 @"roadcollapse":@[@(SheetUIStyle_Switch),@(29)],
                 @"roaddefect":@[@(SheetUIStyle_Switch),@(30)],
                 @"roadserious":@[@(SheetUIStyle_Switch),@(31)],
                 },
             @{
                 @"group":@"检测设备外观检查",
                 
                 @"equipappear":@[@(SheetUIStyle_Switch),@(32)],
                 },
             
             @{
                 @"group":@"",
                 @"remark":@[@(SheetUIStyle_Text),@(33)],
                 @"solution":@[@(SheetUIStyle_Text),@(34)],
                 },
             ];
    
}


-(NSDictionary *)defaultUITextMapping
{
    return @{
             @"weather":@"天气情况",
             @"exedate":@"执行时间",
             @"remark":@"问题描述",
             @"wellname":@"名称",
             @"mainneat":@"墙面、地面整洁完好",
             @"mainsolid":@"装饰面层粘接牢固，无开裂、粉化、脱落",
             @"mainwhole":@"整体无掉角、露筋、塌陷、漏水、沉降现象",
             @"mainserious":@"无危及结构安全的裂缝",
             @"mainvoid":@"混凝土表面无蜂窝、麻面、孔洞、漏筋",
             @"doorsolid":@"安装牢固，数量无缺失",
             @"doorneat":@"外观整洁完好，无开裂、脱落",
             @"doorwhole":@"开关平顺、严密、无阻涩，不漏风、漏水",
             @"conduitsolid":@"管路通畅，无阻塞；安装牢固，无松动",
             @"conduitserious":@"外观整洁完好，无严重锈蚀",
             @"conduitleakage":@"无明显跑冒滴漏现象",
             @"conduitshort":@"无接触不良、断路、短路",
             @"conduitdamage":@"零部件齐备，无丢失破损",
             @"decorateneat":@"屋面涂料及瓦齐全整洁",
             @"decorateclear":@"外墙砖完成；内墙面洁净",
             @"decoratedamage":@"地砖、踢脚无破损",
             @"cablemainvoid":@"混凝土表面无蜂窝、麻面、孔洞、露筋",
             @"cablemainserious":@"无危及结构安全的裂缝",
             @"cablemainfreeze":@"无积水、结冰",
             @"cableequipserious":@"无严重锈蚀",
             @"cableequipleakage":@"无明显渗漏",
             @"cableequipsolid":@"安装牢固；数量齐全，无丢失",
             @"courtyardneat":@"路面整洁，无大面积破损；无塌陷",
             @"squareneat":@"路面整洁，无大面积破损；无塌陷",
             @"enclosurewhole":@"护网牢固可靠、无破损、无锈蚀、护网下部缝隙均匀无大孔隙、护网周边无垃圾",
             @"enclowallwhole":@"围墙牢固可靠、无破损、墙面洁净、围墙土体稳定平整、围墙周边无垃圾",
             @"roadcollapse":@"无大面积破损；无塌陷",
             @"roaddefect":@"路牙、路面砖、护坡砌块无缺失",
             @"roadserious":@"护栏爬梯无大面积锈蚀",
             @"equipappear":@"浮子水位计、渗压计、沉降标点、观测基点等安装牢固、可正常使用、保护盖板无锈蚀",
             @"solution":@"解决方法",
             };
}

@end

