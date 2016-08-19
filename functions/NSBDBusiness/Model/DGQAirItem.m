//
//  DGQAirItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DGQAirItem.h"

@implementation DGQAirItem


+(NSDictionary *)defaultMapping
{
    return @{@"任务外键":@"任务外键",
             @"井号":@"井号",
             @"井名称":@"井名称",
             @"地上_地面":@"地上_地面",
             @"地上_围栏",
             @"地上_气孔",
             @"地上_井盖",
             @"地上_卫生",
             @"地下_爬梯",
             @"地下_护栏",
             @"地下_井壁",
             @"地下_卫生",
             @"地下_气阀",
             @"地下_闸阀",
             @"地下_球阀",
             @"地下_井底",
             @"备注",
             @"所属段" ,
             @"0"};

}

+(NSDictionary *)defaultJSON
{
    return @{@"taskid":@"任务外键",
             @"wellnum":@"井号",
             @"wellname":@"井名称",
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
             @"stage":@"所属段" ,
             @"state":@"0"};
    
}

@end
