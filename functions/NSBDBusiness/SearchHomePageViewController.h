//
//  SearchHomePageViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"
@class SearchHomePageModel;

@interface SearchHomePageViewController : SupportRotationSelectBaseViewController <UITableViewDelegate,UITableViewDataSource>

-(instancetype) initWithTaskId:(NSString *) taskid;
@property (nonatomic,strong) SearchHomePageModel *model;
@property (nonatomic,strong) NSString *taskid;
@end
