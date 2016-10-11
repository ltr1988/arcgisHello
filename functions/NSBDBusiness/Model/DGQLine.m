//
//  DGQLine.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DGQLine.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "TitleDetailItem.h"
#import "AuthorizeManager.h"

@implementation DGQLine

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
    return @"东干渠管线 - 本地暂存";
}


-(NSString *) actionKey
{
    return @"dgqline";
}
#pragma mark UILayout

-(NSArray *)defaultUIStyleMapping
{
    return @[
             @{
                 @"group":@"巡查范围",
                 @"stakestart":@(SheetUIStyle_ShortText),
                 @"stakeend":@(SheetUIStyle_ShortText),
                 @"exedate":@(SheetUIStyle_Date),
                 @"weather":@(SheetUIStyle_ShortText),
                 },
             @{
                 @"group":@"巡查内容",
                 @"issurvey":@(SheetUIStyle_Switch),
                 @"isbuild":@(SheetUIStyle_Switch),
                 @"ishavewater":@(SheetUIStyle_Switch),
                 @"isdamage":@(SheetUIStyle_Switch),
                 @"istrap":@(SheetUIStyle_Switch),
                 @"ischange":@(SheetUIStyle_Switch),
                 },
             @{
                 @"group":@"",
                 @"problem":@(SheetUIStyle_Text),
                 @"dealmethod":@(SheetUIStyle_Text),
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
