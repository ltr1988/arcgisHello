//
//  TitleDetailTextItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//


#import "TitleDetailItem.h"

@interface TitleDetailTextItem : TitleDetailItem<TitleDetailTextCellViewModel,NSCoding>
@property (nonatomic,strong) NSString *text;
+(instancetype) itemWithTitle:(NSString *)title detail:(NSString *)detail text:(NSString *)text;
@end
