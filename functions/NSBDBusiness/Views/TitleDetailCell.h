//
//  TitleDetailCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleOnlyCell.h"

@protocol TitleDetailCellViewModel <TitleOnlyCellViewModel>

-(NSString *) detail;
@end

@protocol TitleDetailTextCellViewModel <TitleDetailCellViewModel>

-(NSString *) text;

@end

@interface TitleDetailCell : TitleOnlyCell
{
    UILabel *detail;
}
@end
