//
//  DGQWater.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DGQWaterItem.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "AuthorizeManager.h"
#import "TitleDetailItem.h"

@implementation DGQWaterItem


-(instancetype) init
{
    self = [super init];
    if (self) {
        self.wellnum = @"";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.wellnum forKey:@"wellnum"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
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
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    for (SearchSheetGroupItem *group in self.infolist) {
        for (SearchSheetInfoItem *item in group.items) {
            info[item.key] = [item.data value];
        }
    }
    info[@"taskid"] = self.taskid;
    info[@"id"] = self.itemId;
    info[@"operate"] = @"insert";
    info[@"userName"] = [AuthorizeManager sharedInstance].userName;
    
    return info;
}



-(NSString *) actionKey
{
    return @"dgqwater";
}

#pragma mark UILayout


-(NSArray *)defaultUIStyleMapping
{
    
    return @[
             @{
                 @"group":@"",
                 @"wellnum":@(SheetUIStyle_ReadonlyText),
                 },
             @{
                 @"group":@"干线检修井",
                 @"dryline_creepwell":@(SheetUIStyle_Switch),
                 @"dryline_crawl":@(SheetUIStyle_Switch),
                 @"dryline_wall":@(SheetUIStyle_Switch),
                 @"dryline_bottom":@(SheetUIStyle_Switch),
                 @"dryline_health":@(SheetUIStyle_Switch),
                 @"dryline_flygate":@(SheetUIStyle_Switch),
                 @"dryline_connect":@(SheetUIStyle_Switch),
                 @"dryline_handgate":@(SheetUIStyle_Switch),
                 @"dryline_sluice":@(SheetUIStyle_Switch),
                 },
             @{
                 @"group":@"支管检修井",
                 @"branch_creepwell":@(SheetUIStyle_Switch),
                 @"branch_crawl":@(SheetUIStyle_Switch),
                 @"branch_wall":@(SheetUIStyle_Switch),
                 @"branch_bottom":@(SheetUIStyle_Switch),
                 @"branch_health":@(SheetUIStyle_Switch),
                 @"branch_connect":@(SheetUIStyle_Switch),
                 @"branch_sluice":@(SheetUIStyle_Switch),
                 },
             
             @{
                 @"group":@"支管测流井",
                 @"measure_creepwell":@(SheetUIStyle_Switch),
                 @"measure_crawl":@(SheetUIStyle_Switch),
                 @"measure_wall":@(SheetUIStyle_Switch),
                 @"measure_bottom":@(SheetUIStyle_Switch),
                 @"measure_health":@(SheetUIStyle_Switch),
                 @"measure_connect":@(SheetUIStyle_Switch),
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
             @"wellnum":@"分水口号",
             @"dryline_creepwell":@"爬井",
             @"dryline_crawl":@"围栏",
             @"dryline_wall":@"井壁",
             @"dryline_bottom":@"井底",
             @"dryline_health":@"卫生",
             @"dryline_flygate":@"电动蝶阀",
             @"dryline_connect":@"伸缩接头",
             @"dryline_handgate":@"手动蝶阀",
             @"dryline_sluice":@"电动闸阀",
            
             
             @"branch_creepwell":@"爬井",
             @"branch_crawl":@"围栏",
             @"branch_wall":@"井壁",
             @"branch_bottom":@"井底",
             @"branch_health":@"卫生",
             @"branch_connect":@"伸缩接头",
             @"branch_sluice":@"电动闸阀",
             
             @"measure_creepwell":@"爬井",
             @"measure_crawl":@"围栏",
             @"measure_wall":@"井壁",
             @"measure_bottom":@"井底",
             @"measure_health":@"卫生",
             @"measure_connect":@"流量计",
             
             @"remark":@"备注",
             };
}

@end

