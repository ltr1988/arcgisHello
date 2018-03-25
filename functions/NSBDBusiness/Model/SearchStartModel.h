//
//  SearchStartModel.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitleDetailItem.h"
#import "TitleItem.h"
#import "TitleInputItem.h"
#import "TitleDateItem.h"
#import "TitleComboBoxItem.h"

@interface SearchStartModel : NSObject<NSCoding>
@property (nonatomic,strong) TitleComboBoxItem *taskTypeName;
@property (nonatomic,strong) TitleInputItem *searcher;
@property (nonatomic,strong) TitleDetailItem *searchAdmin;
@property (nonatomic,strong) TitleDetailItem *weather;
@property (nonatomic,strong) TitleDateItem *date;

@end
