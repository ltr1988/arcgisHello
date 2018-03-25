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
    NSMutableDictionary *info = [[super requestInfo] mutableCopy];
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
//             @{
//                 @"group":@"",
//                 @"wellnum":@[@(SheetUIStyle_ReadonlyText),@(1)],
//                 },
             @{
                 @"group":@"干线检修井",
                 @"dryline_creepwell":@[@(SheetUIStyle_Switch),@(1)],
                 @"dryline_crawl":@[@(SheetUIStyle_Switch),@(2)],
                 @"dryline_wall":@[@(SheetUIStyle_Switch),@(3)],
                 @"dryline_bottom":@[@(SheetUIStyle_Switch),@(4)],
                 @"dryline_health":@[@(SheetUIStyle_Switch),@(5)],
                 @"dryline_flygate":@[@(SheetUIStyle_Switch),@(6)],
                 @"dryline_connect":@[@(SheetUIStyle_Switch),@(7)],
                 @"dryline_handgate":@[@(SheetUIStyle_Switch),@(8)],
                 @"dryline_sluice":@[@(SheetUIStyle_Switch),@(9)],
                 },
             @{
                 @"group":@"支管检修井",
                 @"branch_creepwell":@[@(SheetUIStyle_Switch),@(1)],
                 @"branch_crawl":@[@(SheetUIStyle_Switch),@(2)],
                 @"branch_wall":@[@(SheetUIStyle_Switch),@(3)],
                 @"branch_bottom":@[@(SheetUIStyle_Switch),@(4)],
                 @"branch_health":@[@(SheetUIStyle_Switch),@(5)],
                 @"branch_connect":@[@(SheetUIStyle_Switch),@(6)],
                 @"branch_sluice":@[@(SheetUIStyle_Switch),@(7)],
                 },
             
             @{
                 @"group":@"支管测流井",
                 @"measure_creepwell":@[@(SheetUIStyle_Switch),@(1)],
                 @"measure_crawl":@[@(SheetUIStyle_Switch),@(2)],
                 @"measure_wall":@[@(SheetUIStyle_Switch),@(3)],
                 @"measure_bottom":@[@(SheetUIStyle_Switch),@(4)],
                 @"measure_health":@[@(SheetUIStyle_Switch),@(5)],
                 @"measure_connect":@[@(SheetUIStyle_Switch),@(6)],
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
             @"wellnum":@"分水口号",
             @"dryline_creepwell":@"爬井",
             @"dryline_crawl":@"围栏",
             @"dryline_wall":@"井壁",
             @"dryline_bottom":@"井底",
             @"dryline_health":@"卫生",
             @"dryline_flygate":@"电动蝶阀",
             @"dryline_connect":@"伸缩接头",
             @"dryline_handgate":@"手动蝶阀",
             @"dryline_sluice":@"手动球阀",
            
             
             @"branch_creepwell":@"爬井",
             @"branch_crawl":@"围栏",
             @"branch_wall":@"井壁",
             @"branch_bottom":@"井底",
             @"branch_health":@"卫生",
             @"branch_connect":@"伸缩接头",
             @"branch_sluice":@"电动蝶阀",
             
             @"measure_creepwell":@"爬井",
             @"measure_crawl":@"围栏",
             @"measure_wall":@"井壁",
             @"measure_bottom":@"井底",
             @"measure_health":@"卫生",
             @"measure_connect":@"流量计",
             
             @"remark":@"问题描述",
             };
}

@end

