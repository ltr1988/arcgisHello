//
//  MyDealedEventViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@interface MyDealedEventViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myDealedEventTableView;
@property (nonatomic,strong) NSArray *modelList;

@end
