//
//  DGQAirItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSBDBaseUIItem.h"

@interface DGQAirItem : NSBDBaseUIItem<NSCoding>

@property (strong,nonatomic) NSString *wellnum;
@property (strong,nonatomic) NSString *wellname;
@property (assign,nonatomic) BOOL over_ground;
@property (assign,nonatomic) BOOL over_crawl;
@property (assign,nonatomic) BOOL over_blowhole;
@property (assign,nonatomic) BOOL over_welllid;
@property (assign,nonatomic) BOOL over_health;
@property (assign,nonatomic) BOOL under_ladder;
@property (assign,nonatomic) BOOL under_guardrail;
@property (assign,nonatomic) BOOL under_wall;
@property (assign,nonatomic) BOOL unde_health;
@property (assign,nonatomic) BOOL unde_airgate;
@property (assign,nonatomic) BOOL unde_sluicegate;


@property (assign,nonatomic) BOOL unde_ballgate;
@property (assign,nonatomic) BOOL under_bottom;
@property (strong,nonatomic) NSString *remark;
@property (strong,nonatomic) NSString *exedate;


//{"taskid", "id", "type", "createtime", "starttime", "isupload", "wellnum", "over_crawl", "over_ground", "over_blowhole", "over_welllid", "over_health", "under_ladder", "under_guardrail", "under_wall", "unde_health", "unde_airgate", "unde_sluicegate", "unde_ballgate", "under_bottom", "remark", "exedate"};
@end
