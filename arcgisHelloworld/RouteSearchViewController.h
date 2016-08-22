//
//  RouteSearchViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/22.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@interface RouteSearchViewController : SupportRotationSelectBaseViewController<UITextFieldDelegate>

-(instancetype) initWithPointFlag:(BOOL) isStartPoint;

@property (nonatomic,strong) UITextField *searchField;

@end
