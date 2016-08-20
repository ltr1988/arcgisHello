//
//  DGQAirItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSBDBaseUIItem.h"

@interface DGQAirItem : NSBDBaseUIItem



@property (strong,nonatomic) NSString *taskid;
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
@property (assign,nonatomic) NSInteger *stage; //0上段 1下段 2整段
@property (assign,nonatomic) NSInteger *state; //0暂存 1提交


@end
