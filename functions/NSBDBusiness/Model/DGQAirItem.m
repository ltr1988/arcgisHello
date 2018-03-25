//
//  DGQAirItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DGQAirItem.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "TitleDetailItem.h"
#import "AuthorizeManager.h"

@implementation DGQAirItem

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
    //info[@"type"] = @"东干渠排气井";

    return info;
}

-(NSString *) actionKey
{
    return @"dgqair";
}
#pragma mark UILayout

-(NSArray *)defaultUIStyleMapping
{
    return @[
//             @{
//                 @"group":@"",
//                 @"wellnum":@[@(SheetUIStyle_ReadonlyText),@(1)],
//                 },
             @{
                 @"group":@"地上部分",
                 @"over_ground":@[@(SheetUIStyle_Switch),@(1)],
                 @"over_crawl":@[@(SheetUIStyle_Switch),@(2)],
                 @"over_blowhole":@[@(SheetUIStyle_Switch),@(3)],
                 @"over_welllid":@[@(SheetUIStyle_Switch),@(4)],
                 @"over_health":@[@(SheetUIStyle_Switch),@(5)],
                 },
             @{
                 @"group":@"地下部分",
                 @"under_ladder":@[@(SheetUIStyle_Switch),@(1)],
                 @"under_guardrail":@[@(SheetUIStyle_Switch),@(2)],
                 @"under_wall":@[@(SheetUIStyle_Switch),@(3)],
                 @"unde_health":@[@(SheetUIStyle_Switch),@(4)],
                 @"unde_airgate":@[@(SheetUIStyle_Switch),@(5)],
                 @"unde_sluicegate":@[@(SheetUIStyle_Switch),@(6)],
                 @"unde_ballgate":@[@(SheetUIStyle_Switch),@(7)],
                 @"under_bottom":@[@(SheetUIStyle_Switch),@(8)],
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
             @"over_ground":@"地面",
             @"over_crawl":@"围栏",
             @"over_blowhole":@"气孔",
             @"over_welllid":@"井盖",
             @"over_health":@"卫生",
             @"under_ladder":@"爬梯",
             @"under_guardrail":@"护栏",
             @"under_wall":@"井壁",
             @"unde_health":@"卫生",
             @"unde_airgate":@"气阀",
             @"unde_sluicegate":@"闸阀",
             @"unde_ballgate":@"球阀",
             @"under_bottom":@"井底",
             @"remark":@"问题描述",
             };
}



@end
