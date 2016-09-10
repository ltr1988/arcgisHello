//
//  MyUploadEventViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@interface MyUploadEventViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *localEventTableView;
@property (nonatomic,strong) UITableView *uploadedEventTableView;
@property (nonatomic,strong) NSArray *localEventModel;
@property (nonatomic,strong) NSArray *uploadedEventModel;
@end
