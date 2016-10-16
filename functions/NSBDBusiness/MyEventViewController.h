//
//  MyEventViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

//待办应急
@interface MyEventViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myEventTableView;
@property (nonatomic,strong) NSArray *modelList;
@end
