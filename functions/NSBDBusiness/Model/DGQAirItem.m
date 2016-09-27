//
//  DGQAirItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DGQAirItem.h"

@implementation DGQAirItem


-(NSDictionary *)requestInfo
{
    return @{};
}

-(NSArray *)defaultUIStyleMapping
{
    return @[@{
                 @"group":@"",
                 @"wellnum":@(SheetUIStyle_ShortText),
                 @"wellname":@(SheetUIStyle_ShortText),
                 },
             @{
                 @"group":@"a",
                 @"over_ground":@(SheetUIStyle_Switch),
                 @"over_crawl":@(SheetUIStyle_Switch),
                 @"over_blowhole":@(SheetUIStyle_Switch),
                 @"over_welllid":@(SheetUIStyle_Switch),
                 @"over_health":@(SheetUIStyle_Switch),
                 @"under_ladder":@(SheetUIStyle_Switch),
                 @"under_guardrail":@(SheetUIStyle_Switch),
                 @"under_wall":@(SheetUIStyle_Switch),
                 @"unde_health":@(SheetUIStyle_Switch),
                 @"unde_airgate":@(SheetUIStyle_Switch),
                 @"unde_sluicegate":@(SheetUIStyle_Switch),
                 @"unde_ballgate":@(SheetUIStyle_Switch),
                 @"under_bottom":@(SheetUIStyle_Switch),},
             @{
                 @"group":@"",
                 @"remark":@(SheetUIStyle_Text),
                 @"stage":@(SheetUIStyle_ShortText),
                 },
             ];

}

-(instancetype) init
{
    self = [super init];
    if (self) {
        
        self.taskid = @"";
        self.wellnum = @"";
        self.wellname = @"";
        self.over_ground = NO;
        self.over_crawl = NO;
        self.over_blowhole = NO;
        self.over_welllid = NO;
        self.over_health = NO;
        self.under_ladder = NO;
        self.under_guardrail = NO;
        self.under_wall = NO;
        self.unde_health = NO;
        self.unde_airgate = NO;
        self.unde_sluicegate = NO;
        self.unde_ballgate = NO;
        self.under_bottom = NO;
        self.remark = @"";
    }
    return self;
}

-(NSDictionary *)defaultUITextMapping
{
    return @{
             @"taskid":@"任务外键",
             @"wellnum":@"井号",
             @"wellname":@"井名称",
             @"over_ground":@"地上_地面",
             @"over_crawl":@"地上_围栏",
             @"over_blowhole":@"地上_气孔",
             @"over_welllid":@"地上_井盖",
             @"over_health":@"地上_卫生",
             @"under_ladder":@"地下_爬梯",
             @"under_guardrail":@"地下_护栏",
             @"under_wall":@"地下_井壁",
             @"unde_health":@"地下_卫生",
             @"unde_airgate":@"地下_气阀",
             @"unde_sluicegate":@"地下_闸阀",
             @"unde_ballgate":@"地下_球阀",
             @"under_bottom":@"地下_井底",
             @"remark":@"备注",
             @"stage":@"所属段" ,
             };
    
}

@end
