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

@implementation DGQAirItem

-(instancetype) init
{
    self = [super init];
    if (self) {
        self.wellnum = @"";
        self.exedate = @"";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.wellnum forKey:@"wellnum"];
    [aCoder encodeObject:self.exedate forKey:@"exedate"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.exedate = [aDecoder decodeObjectForKey:@"exedate"];
        self.wellnum = [aDecoder decodeObjectForKey:@"wellnum"];
    }
    
    return self;
}


#pragma mark protocal
-(NSDictionary *)requestInfo
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    for (SearchSheetGroupItem *group in self.infolist) {
        for (SearchSheetInfoItem *item in group.items) {
            info[item.key] = [item.data value];
        }
    }
    info[@"taskid"] = self.taskid;
    info[@"id"] = self.itemId;
    info[@"type"] = @"东干渠排气井";
    info[@"starttime"] = [[[SearchSessionManager sharedManager] session] stringStartTime];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
    
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    info[@"exedate"] = [formater stringFromDate:[NSDate date]];
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
             @{
                 @"group":@"地上部分",
                 @"over_ground":@(SheetUIStyle_Switch),
                 @"over_crawl":@(SheetUIStyle_Switch),
                 @"over_blowhole":@(SheetUIStyle_Switch),
                 @"over_welllid":@(SheetUIStyle_Switch),
                 @"over_health":@(SheetUIStyle_Switch),
                 },
             @{
                 @"group":@"地下部分",
                 @"under_ladder":@(SheetUIStyle_Switch),
                 @"under_guardrail":@(SheetUIStyle_Switch),
                 @"under_wall":@(SheetUIStyle_Switch),
                 @"unde_health":@(SheetUIStyle_Switch),
                 @"unde_airgate":@(SheetUIStyle_Switch),
                 @"unde_sluicegate":@(SheetUIStyle_Switch),
                 @"unde_ballgate":@(SheetUIStyle_Switch),
                 @"under_bottom":@(SheetUIStyle_Switch),
                 },
             @{
                 @"group":@"",
                 @"remark":@(SheetUIStyle_Text),
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
             @"remark":@"备注",
             };
}



@end
