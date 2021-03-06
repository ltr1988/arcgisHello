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
#import "AuthorizeManager.h"
#import "TitleDetailItem.h"

@implementation DGQWellItem


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
    return @"dgqwell";
}

#pragma mark UILayout

-(NSArray *)defaultUIStyleMapping
{
    return @[
             @{
                 @"group":@"",
                 @"wellnum":@[@(SheetUIStyle_ReadonlyText),@(1)],
                 },
             @{
                 @"group":@"干井",
                 @"dry_creepwell":@[@(SheetUIStyle_Switch),@(2)],
                 @"dry_crawl":@[@(SheetUIStyle_Switch),@(3)],
                 @"dry_wall":@[@(SheetUIStyle_Switch),@(4)],
                 @"dry_bottom":@[@(SheetUIStyle_Switch),@(5)],
                 @"dry_health":@[@(SheetUIStyle_Switch),@(6)],
                 @"dry_flygate":@[@(SheetUIStyle_Switch),@(7)],
                 @"dry_connect":@[@(SheetUIStyle_Switch),@(8)],
                 @"dry_handgate":@[@(SheetUIStyle_Switch),@(9)],
                 @"dry_sluice":@[@(SheetUIStyle_Switch),@(10)],
                 },
             @{
                 @"group":@"湿井",
                 @"wet_creepwell":@[@(SheetUIStyle_Switch),@(1)],
                 @"wet_crawl":@[@(SheetUIStyle_Switch),@(2)],
                 @"wet_wall":@[@(SheetUIStyle_Switch),@(3)],
                 @"wet_bottom":@[@(SheetUIStyle_Switch),@(4)],
                 @"wet_health":@[@(SheetUIStyle_Switch),@(5)],
                 @"wet_drain":@[@(SheetUIStyle_Switch),@(6)],
                 },
             
             @{
                 @"group":@"出水阀井",
                 @"water_creepwell":@[@(SheetUIStyle_Switch),@(1)],
                 @"water_crawl":@[@(SheetUIStyle_Switch),@(2)],
                 @"water_wall":@[@(SheetUIStyle_Switch),@(3)],
                 @"water_bottom":@[@(SheetUIStyle_Switch),@(4)],
                 @"water_health":@[@(SheetUIStyle_Switch),@(5)],
                 @"water_flygate":@[@(SheetUIStyle_Switch),@(6)],
                 @"water_connect":@[@(SheetUIStyle_Switch),@(7)],
                 @"water_tillgate":@[@(SheetUIStyle_Switch),@(8)],
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
             @"wet_drain":@"潜水排污泵",
             
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

