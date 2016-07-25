//
//  EventReportTextInputCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleOnlyCell.h"

@interface TitleTextInputCell : TitleOnlyCell
{
    UITextField *textField;
}

-(NSString *) textForInput;
@end
