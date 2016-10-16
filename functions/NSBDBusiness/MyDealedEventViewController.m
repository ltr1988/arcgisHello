//
//  MyDealedEventViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyDealedEventViewController.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "QRSeparatorCell.h"
#import "MyDealedEventItem.h"
#import "MyDealedEventItemCell.h"
#import "MJRefresh.h"
#import "MyEventDetailViewController.h"
#import "EventHttpManager.h"
#import "MyDealedEventListModel.h"

@interface MyDealedEventViewController ()

@end

@implementation MyDealedEventViewController
{
    NSInteger pageNum;
    
    BOOL hasMore;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
    [self.myDealedEventTableView.mj_header beginRefreshing];
}

-(void) setupModel
{
    hasMore = YES;
    pageNum = 1;
    _modelList = [NSArray array];
#ifdef NoServer
    MyDealedEventItem *item = [MyDealedEventItem new];
    item.title = @"测试事件任务1";
    item.makeTime = @"2016.8.31 22:10:10";
    item.executorName = @"执行人";
    item.departmentName = @"执行部门";
    item.name =@"任务A";
    item.creator = @"";
    
    MyDealedEventItem *item1 = [MyDealedEventItem new];
    item1.title = @"测试事件任务2";
    item1.makeTime = @"2016.8.31 22:10:10";
    item1.executorName = @"执行人2";
    item1.departmentName = @"执行部门2";
    item1.name =@"任务B";
    item1.creator = @"";
    
    
    _modelList = @[item,item1];
    return;
#endif
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.title = @"待办应急事件";
    
    self.myDealedEventTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myDealedEventTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.myDealedEventTableView.backgroundColor = [UIColor seperatorColor];
    self.myDealedEventTableView.delegate = self;
    self.myDealedEventTableView.dataSource = self;
    self.myDealedEventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myDealedEventTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    self.myDealedEventTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    
    [self.view addSubview:self.myDealedEventTableView];
    
    [self.myDealedEventTableView reloadData];
    
}

-(void) requestData
{
    pageNum = 1;
    @weakify(self)
    [[EventHttpManager sharedManager] requestMyDealedEventListWithPage:pageNum SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        //todo
        @strongify(self)
        MyDealedEventListModel *item = [MyDealedEventListModel objectWithKeyValues:dict];
        if (item.success)
        {
            pageNum ++;
            _modelList = [item.datalist copy];
            hasMore = [item hasMore];
            [self.myDealedEventTableView reloadData];
            
        }else if (item.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        [self.myDealedEventTableView.mj_header endRefreshing];
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        //todo
        [self.myDealedEventTableView.mj_header endRefreshing];
        [ToastView popToast:@"刷新失败,请稍候再试"];
    }];
}

-(void) requestMoreData
{
    if (!hasMore) {
        [self.myDealedEventTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    @weakify(self)
    [[EventHttpManager sharedManager] requestMyEventWithPage:pageNum SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        //todo
        @strongify(self)
        MyDealedEventListModel *item = [MyDealedEventListModel objectWithKeyValues:dict];
        if (item.success)
        {
            pageNum ++;
            _modelList = [_modelList arrayByAddingObjectsFromArray:item.datalist];
            hasMore = [item hasMore];
            if (hasMore) {
                [self.myDealedEventTableView.mj_footer endRefreshing];
            }else
                [self.myDealedEventTableView.mj_footer endRefreshingWithNoMoreData];
            
            [self.myDealedEventTableView reloadData];
        }else if (item.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [self.myDealedEventTableView.mj_footer endRefreshing];
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        //todo
        [self.myDealedEventTableView.mj_footer endRefreshing];
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
        return [MyDealedEventItemCell heightForCell];
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelList.count*2-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    if (indexPath.row%2 == 1) {
        //sep cell
        QRSeparatorCell *cell = [self.myDealedEventTableView dequeueReusableCellWithIdentifier:@"sepCell"];
        if (!cell) {
            cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"sepCell"];
            
        }
        return cell;
    }
    
    row = row/2;
    
    
    if (row < _modelList.count) {
        MyDealedEventItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDealedEventItemCell"];
        if (!cell) {
            cell = [[MyDealedEventItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyDealedEventItemCell"];
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
    MyDealedEventItem *item = _modelList[row];
    //todo push to new vc
   
//    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
