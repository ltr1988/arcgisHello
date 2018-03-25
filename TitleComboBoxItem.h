//
//  TitleComboBoxItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2018/3/17.
//  Copyright © 2018年 fifila. All rights reserved.
//

#import "TitleItem.h"
#import "TitleComboBoxCell.h"

@interface TitleComboBoxItem : TitleItem<TitleComboBoxCellViewModel,NSCoding>
+(instancetype) itemWithTitle:(NSString *)title dataSource:(NSArray *)dataSource;
@property (nonatomic) NSString *selectText;
@property (nonatomic) NSArray *dataSource;
@end
