//
//  DGQWellItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSBDBaseUIItem.h"


//东干渠 排空井
@interface DGQWellItem : NSBDBaseUIItem<NSCoding>

@property (strong,nonatomic) NSString *wellnum;
@property (strong,nonatomic) NSString *wellname;
@property (strong,nonatomic) NSString *exedate;


//"taskid", "id", "type", "createtime", "starttime", "isupload", "wellnum", "dry_creepwell", "dry_crawl", "dry_wall", "dry_bottom", "dry_health", "dry_flygate", "dry_connect", "dry_handgate", "dry_sluice", "wet_creepwell", "wet_crawl", "wet_wall", "wet_bottom", "wet_health", "wet_drain", "water_creepwell", "water_crawl", "water_wall", "water_bottom", "water_health", "water_tillgate", "water_flygate", "water_connect", "remark", "exedate"
@end