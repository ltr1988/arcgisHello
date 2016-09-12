//
//  TextPickerViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@class TitleDetailTextItem;

@interface TextPickerViewController : SupportRotationSelectBaseViewController<UIGestureRecognizerDelegate>
-(instancetype) initWithData:(TitleDetailTextItem *)data;
-(instancetype) initWithData:(TitleDetailTextItem *)data readOnly:(BOOL) readOnly;
@end
