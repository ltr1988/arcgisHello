//
//  DGQAirItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSBDBaseUIItem.h"

//东干渠 排气阀井
@interface DGQAirItem : NSBDBaseUIItem<NSCoding>

@property (strong,nonatomic) NSString *wellnum;
@property (strong,nonatomic) NSString *exedate;

//"taskid", "id", "type", "createtime", "starttime", "isupload", "wellnum", "over_crawl", "over_ground", "over_blowhole", "over_welllid", "over_health", "under_ladder", "under_guardrail", "under_wall", "unde_health", "unde_airgate", "unde_sluicegate", "unde_ballgate", "under_bottom", "remark", "exedate"
@end
