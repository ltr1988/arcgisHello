//
//  TitleComboBoxCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2018/3/17.
//  Copyright © 2018年 fifila. All rights reserved.
//

#import "BaseTitleCell.h"
#import "ComboBox.h"

@protocol TitleComboBoxCellViewModel <TitleOnlyCellViewModel>

-(NSString *) selectText;
-(NSArray *) dataSource;
@end

@interface TitleComboBoxCell : BaseTitleCell
{
    ComboBox *detail;
}
@end
