//
//  DGQWellItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DNWellItem.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "AuthorizeManager.h"
#import "TitleDetailItem.h"

@implementation DNWellItem


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
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
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
    return @"dnwell";
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
                 @"group":@"手阀情况",
                 @"handgateleft":@[@(SheetUIStyle_Switch),@(1)],
                 @"handgateright":@[@(SheetUIStyle_Switch),@(2)],
                 },
             @{
                 @"group":@"空气阀情况",
                 @"airgateleft":@[@(SheetUIStyle_Switch),@(1)],
                 @"airgateright":@[@(SheetUIStyle_Switch),@(2)],
                 },
             @{
                 @"group":@"积水情况",
                 @"pondleft":@[@(SheetUIStyle_Switch),@(1)],
                 @"pondright":@[@(SheetUIStyle_Switch),@(2)],
                 },
             @{
                 @"group":@"保温设施",
                 @"warmleft":@[@(SheetUIStyle_Switch),@(1)],
                 @"warmright":@[@(SheetUIStyle_Switch),@(2)],
                 },
             @{
                 @"group":@"阴极保护",
                 @"negativeleft":@[@(SheetUIStyle_Switch),@(1)],
                 @"negativelright":@[@(SheetUIStyle_Switch),@(2)],
                 },
             @{
                 @"group":@"",
                 @"environment":@[@(SheetUIStyle_ShortText),@(1)],
                 @"weather":@[@(SheetUIStyle_ShortTextWeather),@(2)],
                 },
             @{
                 @"group":@"阀体温度",
                 @"gatetemperatureleft":@[@(SheetUIStyle_ShortTextNum),@(1)],
                 @"gatetemperatureright":@[@(SheetUIStyle_ShortTextNum),@(2)],
                 },
             
             @{
                 @"group":@"井内温度",
                 @"welltemperatureleft":@[@(SheetUIStyle_ShortTextNum),@(1)],
                 @"welltemperatureright":@[@(SheetUIStyle_ShortTextNum),@(2)],
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
             @"weather":@"天气情况",
             @"exedate":@"执行时间",
             @"handgateleft":@"左手阀",
             @"handgateright":@"右手阀",
             @"airgateleft":@"左手阀",
             @"airgateright":@"右手阀",
             @"pondleft":@"左手阀",
             @"pondright":@"右手阀",
             @"warmleft":@"左手阀",
             @"warmright":@"右手阀",
             @"negativeleft":@"左手阀",
             @"negativelright":@"右手阀",
             @"environment":@"环境设施",
             @"gatetemperatureleft":@"左线",
             @"gatetemperatureright":@"右线",
             @"welltemperatureleft":@"左线",
             @"welltemperatureright":@"右线",
             @"remark":@"备注情况说明",
             
             };
}

@end

