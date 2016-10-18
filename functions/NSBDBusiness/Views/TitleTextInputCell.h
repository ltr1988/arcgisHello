//
//  EventReportTextInputCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTitleCell.h"
#import "TitleDetailCell.h"


@protocol TitleTextInputCellViewModel <TitleDetailCellViewModel>

-(NSString *) placeholder;
@end

@interface TitleTextInputCell : BaseTitleCell<UITextFieldDelegate>
{
    UITextField *inputTextField;
}
-(void) setKeyBoardType:(UIKeyboardType) type;
@end
