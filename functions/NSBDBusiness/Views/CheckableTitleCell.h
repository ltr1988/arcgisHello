//
//  CheckableTitleCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "BaseTitleCell.h"
#import "DCRoundSwitch.h"

@protocol CheckableTitleCellViewModel <TitleOnlyCellViewModel>

-(BOOL) checked;
-(void) setChecked:(BOOL)isOn;
@end


@interface CheckableTitleCell : BaseTitleCell
{
    DCRoundSwitch *switchView;
}

-(DCRoundSwitch *)switchView;
@end
