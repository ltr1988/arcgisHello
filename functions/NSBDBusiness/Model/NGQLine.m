//
//  DGQLine.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NGQLine.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "TitleDetailItem.h"
#import "AuthorizeManager.h"
#import "TitleInputItem.h"
#import "NSDateFormatterHelper.h"

@implementation NGQLine

-(BOOL) isLine
{
    return YES;
}
#pragma mark protocal
-(NSDictionary *)requestInfo
{
    NSMutableDictionary *info = [[super requestInfo] mutableCopy];
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
    
    NSDateFormatter *formater = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd HH:mm:ss"]; 
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
    return @"ngqline";
}
#pragma mark UILayout

-(NSArray *)defaultUIStyleMapping
{
    return @[
             @{
                 @"group":@"",
                 @"partfrom":@[@(SheetUIStyle_ShortText),@(1)],
                 @"partto":@[@(SheetUIStyle_ShortText),@(2)],
                 @"exedate":@[@(SheetUIStyle_Date),@(3)],
                 @"weather":@[@(SheetUIStyle_ShortTextWeather),@(4)],
                
                 @"situation":@[@(SheetUIStyle_Text),@(5)],
                 @"remark":@[@(SheetUIStyle_Text),@(6)],
                 },
             ];
}

-(NSDictionary *)defaultUITextMapping
{
    return @{
             @"partfrom":@"开始路段",
             @"partto":@"结束路段",
             @"exedate":@"时间",
             @"weather":@"天气",
             @"situation":@"情况说明",
             @"remark":@"备注",
             };
}
@end
