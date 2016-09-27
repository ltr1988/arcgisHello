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

@implementation DGQAirItem


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
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
    
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    info[@"exedate"] = [formater stringFromDate:[NSDate date]];
    return info;
}

-(NSArray *)defaultUIStyleMapping
{
    return @[
             @{
                 @"group":@"干井",
                 @"over_ground":@(SheetUIStyle_Switch),
                 @"over_crawl":@(SheetUIStyle_Switch),
                 @"over_blowhole":@(SheetUIStyle_Switch),
                 },
             @{
                 @"group":@"湿井",
                 @"over_welllid":@(SheetUIStyle_Switch),
                 @"over_health":@(SheetUIStyle_Switch),
                 @"under_ladder":@(SheetUIStyle_Switch),
                 },
             @{
                 @"group":@"出水阀井",
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

-(instancetype) init
{
    self = [super init];
    if (self) {
        self.wellnum = @"";
        self.wellname = @"";
        self.exedate = @"";
    }
    return self;
}

-(NSString *) actionKey
{
    return @"dgqair";
}

-(NSDictionary *)defaultUITextMapping
{
    return @{
             @"taskid":@"任务外键",
             @"wellnum":@"井号",
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
             };
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.wellnum forKey:@"wellnum"];
    [aCoder encodeObject:self.wellname forKey:@"wellname"];
    [aCoder encodeObject:self.exedate forKey:@"exedate"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.exedate = [aDecoder decodeObjectForKey:@"exedate"];
        self.wellname = [aDecoder decodeObjectForKey:@"wellname"];
        self.wellnum = [aDecoder decodeObjectForKey:@"wellnum"];
    }
    
    return self;
}
@end
