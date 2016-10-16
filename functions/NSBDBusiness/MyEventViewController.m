//
//  MyEventViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventViewController.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "QRSeparatorCell.h"
#import "MyEventItem.h"
#import "MyEventItemCell.h"
#import "MJRefresh.h"
#import "MyEventDetailViewController.h"
#import "EventHttpManager.h"
#import "MyEventListModel.h"

@implementation MyEventViewController
{
    NSInteger pageNum;
    
    BOOL hasMore;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
    [self.myEventTableView.mj_header beginRefreshing];
}

-(void) setupModel
{
    hasMore = YES;
    pageNum = 1;
    _modelList = [NSArray array];
#ifdef NoServer
    MyEventItem *item = [MyEventItem new];
    item.title = @"待办应急事件1";
    item.date= @"2016.8.31 22:10:10";
    item.xingzhi = @"严重";
    item.level = @"一级";
    item.place = @"北京市海淀西三旗建材城";
    item.finder = @"小明";
    
    MyEventItem *item1 = [MyEventItem new];
    item1.title = @"待办应急事件2";
    item1.date= @"2016.8.22 06:10:10";
    item1.xingzhi = @"严重";
    item1.level = @"一级";
    item1.place = @"北京市海淀西二旗软件园";
    item1.finder = @"小东";
    
    _modelList = @[item,item1];
    return;
#endif
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.title = @"待办应急事件";
    
    self.myEventTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myEventTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.myEventTableView.backgroundColor = [UIColor seperatorColor];
    self.myEventTableView.delegate = self;
    self.myEventTableView.dataSource = self;
    self.myEventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myEventTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    self.myEventTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    
    [self.view addSubview:self.myEventTableView];
    
    [self.myEventTableView reloadData];
    
}

-(void) requestData
{
    pageNum = 1;
    @weakify(self)
    [[EventHttpManager sharedManager] requestMyEventWithPage:pageNum SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        //todo
        @strongify(self)
        MyEventListModel *item = [MyEventListModel objectWithKeyValues:dict];
        if (item.success)
        {
            pageNum ++;
            _modelList = [item.datalist copy];
            hasMore = [item hasMore];
            [self.myEventTableView reloadData];
            
        }else if (item.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        [self.myEventTableView.mj_header endRefreshing];
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        //todo
        [self.myEventTableView.mj_header endRefreshing];
        [ToastView popToast:@"刷新失败,请稍候再试"];
    }];
}

-(void) requestMoreData
{
    if (!hasMore) {
        [self.myEventTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    @weakify(self)
    [[EventHttpManager sharedManager] requestMyEventWithPage:pageNum SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        //todo
        @strongify(self)
        MyEventListModel *item = [MyEventListModel objectWithKeyValues:dict];
        if (item.success)
        {
            pageNum ++;
            _modelList = [_modelList arrayByAddingObjectsFromArray:item.datalist];
            hasMore = [item hasMore];
            if (hasMore) {
                [self.myEventTableView.mj_footer endRefreshing];
            }else
                [self.myEventTableView.mj_footer endRefreshingWithNoMoreData];
            
            [self.myEventTableView reloadData];
        }else if (item.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [self.myEventTableView.mj_footer endRefreshing];
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        //todo
        [self.myEventTableView.mj_footer endRefreshing];
        [ToastView popToast:@"刷新失败,请稍候再试"];
    }];

}
#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2 == 1) {
        
        return 8;
    }
    if (indexPath.row/2 <_modelList.count)
        return [MyEventItemCell heightForCell];
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelList.count*2-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    if (indexPath.row%2 == 1) {
        //sep cell
        QRSeparatorCell *cell = [self.myEventTableView dequeueReusableCellWithIdentifier:@"sepCell"];
        if (!cell) {
            cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"sepCell"];
            
        }
        return cell;
    }
    
    row = row/2;
    
    
    if (row < _modelList.count) {
        MyEventItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyEventItemCell"];
        if (!cell) {
            cell = [[MyEventItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyEventItemCell"];
        }
        cell.data = _modelList[row];
        return cell;
    }
    
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row%2 == 1) {
        return;
    }
    
    NSInteger row = indexPath.row /2;
    MyEventItem *item = _modelList[row];
    //todo push to new vc
    MyEventDetailViewController *vc = [[MyEventDetailViewController alloc] initWithEventId:item.eid departName:item.departName];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
