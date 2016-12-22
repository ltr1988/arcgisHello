//
//  TitleDateItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitleItem.h"
#import "TitleDetailCell.h"

@interface TitleDateItem : TitleItem<TitleDetailCellViewModel,NSCoding>
@property (nonatomic,strong) NSDate *date;
+(instancetype) itemWithTitle:(NSString *)title;

-(NSString *) detailDate;
@end
