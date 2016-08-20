//
//  CheckableTitleItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleItem.h"
#import "CheckableTitleCell.h"

@interface CheckableTitleItem : TitleItem<CheckableTitleCellViewModel>
@property (nonatomic,assign) BOOL checked;

+(instancetype) itemWithTitle:(NSString *)title  checked:(BOOL)checked;
@end
