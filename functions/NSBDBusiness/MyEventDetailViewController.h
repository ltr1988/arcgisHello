//
//  MyEventDetailViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@interface MyEventDetailViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) NSArray *modelList;
@end
