//
//  TextPickerViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@interface TextPickerViewController : SupportRotationSelectBaseViewController<UIGestureRecognizerDelegate>
-(instancetype) initWithTitle:(NSString *)title;
-(instancetype) initWithTitle:(NSString *)title text:(NSString *)detail;
@end
