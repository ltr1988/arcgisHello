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

@interface TitleDetailItem : TitleItem<TitleDetailCellViewModel,NSCoding>
@property (nonatomic,strong) NSString *detail;
+(instancetype) itemWithTitle:(NSString *)title detail:(NSString *)detail;
@end


@interface TitleDateItem : TitleItem<TitleDetailCellViewModel,NSCoding>
@property (nonatomic,strong) NSDate *date;
+(instancetype) itemWithTitle:(NSString *)title;
@end


@interface TitleInputItem : TitleDetailItem<TitleTextInputCellViewModel,NSCoding>
@property (nonatomic,strong) NSString *placeholder;
+(instancetype) itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder;
@end


@interface TitleDetailTextItem : TitleDetailItem<TitleDetailTextCellViewModel,NSCoding>
@property (nonatomic,strong) NSString *text;
+(instancetype) itemWithTitle:(NSString *)title detail:(NSString *)detail text:(NSString *)text;
@end