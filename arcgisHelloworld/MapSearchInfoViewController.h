//
//  MapSearchInfoViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

#import "CommonDefine.h"

@interface MapSearchInfoViewController : SupportRotationSelectBaseViewController<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *searchField;

@property (nonatomic,copy) InfoCallback graphicSelectedCallback;
@end
