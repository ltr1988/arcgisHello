//
//  SearchHistoryHomeViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHistoryHomeViewController.h"
#import "SearchHistoryItem.h"
#import "SearchHistoryModel.h"
#import "SearchHistoryManager.h"
#import "MJRefresh.h"
#import "UIColor+ThemeColor.h"
#import "Masonry.h"
#import "SearchHistoryHomeTableViewCell.h"
#import "UITableView+EmptyView.h"
#import "SearchHomePageViewController.h"

@interface SearchHistoryHomeViewController ()
{
    BOOL hasMore;
}
@property (nonatomic,strong) SearchHistoryModel *model;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation SearchHistoryHomeViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupMembers];
    [self setupSubviews];
    [self.tableView.mj_header beginRefreshing];
}

-(void) setupMembers
{
    hasMore = YES;
}

-(void) requestData
{
    //mock
#ifdef NoServer
    id mock = @[
                @{@"startDate":@"2016-9-29",@"endDate":@"2016-9-29",@"id":@"1",@"name":@"任务1"},
                @{@"startDate":@"2016-9-19",@"endDate":@"2016-9-19",@"id":@"1",@"name":@"任务2"},
                @{@"startDate":@"2016-9-18",@"endDate":@"2016-9-18",@"id":@"1",@"name":@"任务3"},
                @{@"startDate":@"2016-9-17",@"endDate":@"2016-9-17",@"id":@"1",@"name":@"任务4"},
                ];
    NSDictionary *dict =@{@"status":@"100",@"data":mock};
    _model = [SearchHistoryModel objectWithKeyValues:dict];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    return;
#endif
    if (![[AFNetworkReachabilityManager sharedManager] isReachable])
    {
        [ToastView popToast:@"暂无网络，稍后再试"];
        return;
    }
    
    [[SearchHistoryManager sharedManager] requestSearchHistoryListSuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        _model = [SearchHistoryModel objectWithKeyValues:dict];
        if (_model.success)
        {
            [_tableView reloadData];
        }else if (_model.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        [ToastView popToast:@"获取失败，请稍后再试"];
    }];
    
}

-(void) requestMoreData
{
    
    //mock
#ifdef NoServer
    hasMore = NO;
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    return;
#endif
    if (!hasMore) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    if (![[AFNetworkReachabilityManager sharedManager] isReachable])
    {
        [ToastView popToast:@"暂无网络，稍后再试"];
        return;
    }
    
    [[SearchHistoryManager sharedManager] requestSearchHistoryListSuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        SearchHistoryModel *item = [SearchHistoryModel objectWithKeyValues:dict];
        if (item.success)
        {
            
            if (item.datalist && item.datalist.count>0) {
                NSMutableArray *list = [_model.datalist mutableCopy];
                [list addObjectsFromArray:item.datalist];
                _model.datalist = [list copy];
                [_tableView reloadData];
                [_tableView.mj_footer endRefreshing];
            }else
            {
                hasMore = NO;
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else if (_model.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        [ToastView popToast:@"获取失败，请稍后再试"];
        
        [_tableView.mj_footer endRefreshing];
    }];
    
}
-(void) setupSubviews
{
    self.title = @"巡查历史";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor backGroundGrayColor];
    _tableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0)];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    [self.view addSubview:_tableView];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SearchHistoryHomeTableViewCell heightForCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    if (!_model || _model.datalist.count == 0)
    {
        [tableView setEmptyView];
    }else
    {
        [tableView removeEmptyView];
    }

    return _model.datalist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    SearchHistoryHomeTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"SearchHistoryHomeTableViewCell"];
    if (!cell) {
        cell = [[SearchHistoryHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchHistoryHomeTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (row<_model.datalist.count) {
        
        SearchHistoryItem *item = _model.datalist[row];
        cell.data = item;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (row < _model.datalist.count) {
        SearchHistoryItem *item = _model.datalist[row];
        
        SearchHomePageViewController *vc = [[SearchHomePageViewController alloc] initWithTaskId:item.taskid];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
