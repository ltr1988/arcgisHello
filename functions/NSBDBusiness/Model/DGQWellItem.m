//
//  DGQWellItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DGQWellItem.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"

@implementation DGQWellItem


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
    info[@"type"] = @"东干渠排空井";
    info[@"starttime"] = [[[SearchSessionManager sharedManager] session] stringStartTime];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
    
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    info[@"exedate"] = [formater stringFromDate:[NSDate date]];
    return info;
}



-(NSString *) actionKey
{
    return @"dgqwell";
}

#pragma mark UILayout
-(NSArray *)defaultUIStyleMapping
{
    return @[
             @{
                 @"group":@"地上部分",
                 @"dry_creepwell":@(SheetUIStyle_Switch),
                 @"dry_crawl":@(SheetUIStyle_Switch),
                 @"dry_wall":@(SheetUIStyle_Switch),
                 @"dry_bottom":@(SheetUIStyle_Switch),
                 @"dry_health":@(SheetUIStyle_Switch),
                 @"dry_flygate":@(SheetUIStyle_Switch),
                 @"dry_connect":@(SheetUIStyle_Switch),
                 @"dry_handgate":@(SheetUIStyle_Switch),
                 @"dry_sluice":@(SheetUIStyle_Switch),
                 },
             @{
                 @"group":@"地下部分",
                 @"wet_creepwell":@(SheetUIStyle_Switch),
                 @"wet_crawl":@(SheetUIStyle_Switch),
                 @"wet_wall":@(SheetUIStyle_Switch),
                 @"wet_bottom":@(SheetUIStyle_Switch),
                 @"wet_health":@(SheetUIStyle_Switch),
                 },
             
             @{
                 @"group":@"地下部分",
                 @"water_creepwell":@(SheetUIStyle_Switch),
                 @"water_crawl":@(SheetUIStyle_Switch),
                 @"water_wall":@(SheetUIStyle_Switch),
                 @"water_bottom":@(SheetUIStyle_Switch),
                 @"water_health":@(SheetUIStyle_Switch),
                 @"water_flygate":@(SheetUIStyle_Switch),
                 @"water_connect":@(SheetUIStyle_Switch),
                 @"water_tillgate":@(SheetUIStyle_Switch),
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
             @"dry_creepwell":@"爬井",
             @"dry_crawl":@"围栏",
             @"dry_wall":@"井壁",
             @"dry_bottom":@"井底",
             @"dry_health":@"卫生",
             @"dry_flygate":@"电动蝶阀",
             @"dry_connect":@"伸缩接头",
             @"dry_handgate":@"手动蝶阀",
             @"dry_sluice":@"电动闸阀",
             
             @"wet_creepwell":@"爬井",
             @"wet_crawl":@"围栏",
             @"wet_wall":@"井壁",
             @"wet_bottom":@"井底",
             @"wet_health":@"卫生",
             
             @"water_creepwell":@"爬井",
             @"water_crawl":@"围栏",
             @"water_wall":@"井壁",
             @"water_bottom":@"井底",
             @"water_health":@"卫生",
             @"water_flygate":@"电动蝶阀",
             @"water_connect":@"伸缩接头",
             @"water_tillgate":@"蝶式止回阀",
             
             @"remark":@"备注",
             };
    



}

@end

