//
//  MyChuanKuaYueHistoryListViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@interface MyChuanKuaYueHistoryListViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSArray *modelList;
-(instancetype) initHistoryControllerWithID:(NSString *)theID;
@end
