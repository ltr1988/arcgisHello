//
//  MyDealedEventDetailViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@class MyDealedEventItem;
@interface MyDealedEventDetailViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,UITableViewDelegate>

-(instancetype) initWithDealedEventItem:(MyDealedEventItem *)item;
@end
