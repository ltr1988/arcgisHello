//
//  SearchHomePageViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"
#import "SearchStartModel.h"
@class SearchHomePageModel;

@interface SearchHomePageViewController : SupportRotationSelectBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) SearchStartModel *basicInfoModel;
@property (nonatomic,strong) SearchHomePageModel *model;
@property (nonatomic,copy) NSString *taskid;

-(instancetype) initWithTaskId:(NSString *) taskid;
@end
