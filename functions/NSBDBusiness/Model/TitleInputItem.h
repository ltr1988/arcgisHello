//
//  TitleInputItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitleDetailItem.h"

@interface TitleInputItem : TitleDetailItem<TitleTextInputCellViewModel,NSCoding>
@property (nonatomic,strong) NSString *placeholder;
+(instancetype) itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder;
@end

