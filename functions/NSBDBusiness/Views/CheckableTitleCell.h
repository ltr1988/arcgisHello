//
//  CheckableTitleCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "BaseTitleCell.h"


@protocol CheckableTitleCellViewModel <TitleOnlyCellViewModel>

-(BOOL) checked;
@end


@interface CheckableTitleCell : BaseTitleCell
{
    UISwitch *switchView;
}
@end
