//
//  SearchSecondaryListViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/24.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@class SearchCategoryItem;
@interface SearchSecondaryListViewController : SupportRotationSelectBaseViewController<UITableViewDelegate,UITableViewDataSource>


-(instancetype) initWithSearchCategoryItem:(SearchCategoryItem*) item;
@end
