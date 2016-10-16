//
//  SearchSecondaryListViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/24.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@class SearchHomePageItem;
@interface SearchSecondaryListViewController : SupportRotationSelectBaseViewController<UITableViewDelegate,UITableViewDataSource>


-(instancetype) initWithSearchHomeItem:(SearchHomePageItem*) item;
-(instancetype) initReadonlyWithSearchHomeItem:(SearchHomePageItem*) item;

@property (nonatomic,copy) NSString *taskId;
@end
