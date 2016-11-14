//
//  MyChuanKuaYueDetailViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@interface MyChuanKuaYueDetailViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTableView;
-(instancetype) initWithId:(NSString *)theID;
-(instancetype) initWithId:(NSString *)theID isHistory:(BOOL)history;
@end
