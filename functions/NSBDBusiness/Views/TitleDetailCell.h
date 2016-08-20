//
//  TitleDetailCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "BaseTitleCell.h"

@protocol TitleDetailCellViewModel <TitleOnlyCellViewModel>

-(NSString *) detail;
@end

@protocol TitleDetailTextCellViewModel <TitleDetailCellViewModel>

-(NSString *) text;

@end

@interface TitleDetailCell : BaseTitleCell
{
    UILabel *detail;
}
@end
