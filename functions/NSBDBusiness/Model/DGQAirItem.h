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
@property (strong,nonatomic) NSString *wellname;

@end
