//
//  TitleDetailItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleItem.h"
#import "TitleDetailCell.h"
#import "TitleTextInputCell.h"

@interface TitleDetailItem : TitleItem<TitleDetailCellViewModel>
@property (nonatomic,strong) NSString *detail;
+(instancetype) itemWithTitle:(NSString *)title detail:(NSString *)detail;
@end




@interface TitleDateItem : TitleItem<TitleDetailCellViewModel>
@property (nonatomic,strong) NSDate *date;
+(instancetype) itemWithTitle:(NSString *)title;
@end




@interface TitleInputItem : TitleDetailItem<TitleTextInputCellViewModel>
@property (nonatomic,strong) NSString *placeholder;
+(instancetype) itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder;
@end