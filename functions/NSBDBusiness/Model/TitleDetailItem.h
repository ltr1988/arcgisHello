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
@property (nonatomic,copy) NSString *detail;
+(instancetype) itemWithTitle:(NSString *)title detail:(NSString *)detail;
@end




