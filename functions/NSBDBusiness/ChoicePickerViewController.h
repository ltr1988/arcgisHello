//
//  ChoicePickerViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/4.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"
#import "CommonDefine.h"


@interface ChoicePickerViewController : SupportRotationSelectBaseViewController<UITableViewDelegate,UITableViewDataSource>

-(instancetype) initWithChoices:(NSArray *)choices  saveCallback:(InfoCallback) callback;
-(instancetype) initWithChoices:(NSArray *)choices checkedIndex:(NSInteger) index  saveCallback:(InfoCallback) callback;
@end
