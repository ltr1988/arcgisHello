//
//  CheckableTitleCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleOnlyCell.h"


@protocol CheckableTitleCellViewModel <TitleOnlyCellViewModel>

-(BOOL) checked;
@end


@interface CheckableTitleCell : TitleOnlyCell
{
    UIImageView *checkImgView;
}
@end
