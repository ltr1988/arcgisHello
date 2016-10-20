//
//  DGQLine.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DNLine.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "TitleDetailItem.h"
#import "AuthorizeManager.h"
#import "TitleInputItem.h"

@implementation DNLine

-(BOOL) isLine
{
    return YES;
}
#pragma mark protocal
-(NSDictionary *)requestInfo
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
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
    info[@"operate"] = @"insert";
    info[@"userName"] = [AuthorizeManager sharedInstance].userName;
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
    
    [formater setDateFormat:@"yyyy-MM-dd"];
    info[@"exedate"] = [formater stringFromDate:[NSDate date]];
    
    return info;
}



-(NSString *) title
{
    if (!_title) {
        for (SearchSheetGroupItem *group in self.infolist) {
            for (SearchSheetInfoItem *item in group.items) {
                if ([item.key isEqualToString:@"stakestart"])
                {
                    TitleInputItem *inputItem = (TitleInputItem *)item.data;
                    _title = [NSString stringWithFormat:@"开始桩号 %@",inputItem.detail];
                    return _title;
                }
            }
        }
    }
    return _title;
}


-(NSString *) actionKey
{
    return @"dnline";
}
#pragma mark UILayout

-(NSArray *)defaultUIStyleMapping
{
    return @[
             @{
                 @"group":@"巡查范围",
                 @"stakestart":@[@(SheetUIStyle_ShortText),@(1)],
                 @"stakeend":@[@(SheetUIStyle_ShortText),@(2)],
                 @"exedate":@[@(SheetUIStyle_Date),@(3)],
                 @"weather":@[@(SheetUIStyle_ShortTextWeather),@(4)],
                 },
             @{
                 @"group":@"巡查内容",
                 @"issurvey":@[@(SheetUIStyle_Switch),@(5)],
                 @"isbuild":@[@(SheetUIStyle_Switch),@(6)],
                 @"ishavewater":@[@(SheetUIStyle_Switch),@(7)],
                 @"isdamage":@[@(SheetUIStyle_Switch),@(8)],
                 @"istrap":@[@(SheetUIStyle_Switch),@(9)],
                 @"ischange":@[@(SheetUIStyle_Switch),@(10)],
                 },
             @{
                 @"group":@"",
                 @"problem":@[@(SheetUIStyle_Text),@(11)],
                 @"dealmethod":@[@(SheetUIStyle_Text),@(12)],
                 },
             ];
}

-(NSDictionary *)defaultUITextMapping
{
    return @{
             @"stakestart":@"起始桩号",
             @"stakeend":@"结束桩号",
             @"exedate":@"执行时间",
             @"weather":@"天气",
             @"issurvey":@"保护区范围是否有工程勘测",
             @"isbuild":@"保护区范围是否有新增施工",
             @"ishavewater":@"保护区范围是否有积水",
             @"isdamage":@"管线中心桩有无损毁",
             @"istrap":@"管线上方是否有沉陷",
             @"ischange":@"原遗留违章是否有新变化",
             @"problem":@"问题描述",
             @"dealmethod":@"处理方法",
             };
}
@end
