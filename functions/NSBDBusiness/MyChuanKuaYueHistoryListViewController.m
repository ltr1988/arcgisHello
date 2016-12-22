//
//  MyChuanKuaYueHistoryListViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueHistoryListViewController.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "QRSeparatorCell.h"
#import "MJRefresh.h"
#import "EventHttpManager+ChuanKuaYue.h"
#import "MyChuanKuaYueListModel.h"
#import "MyChuanKuaYueItem.h"
#import "MyChuanKuaYueDetailViewController.h"
#import "MyChuanKuaYueListItemCell.h"

@interface MyChuanKuaYueHistoryListViewController ()
{
    NSInteger pageNum;
    
    BOOL hasMore;
    NSString *historyID;
}
@end

@implementation MyChuanKuaYueHistoryListViewController

-(instancetype) initHistoryControllerWithID:(NSString *)theID
{
    if (self = [super init]) {
        historyID = theID;
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
    [self.myTableView.mj_header beginRefreshing];
}

-(void) setupModel
{
    hasMore = YES;
    pageNum = 1;
    _modelList = [NSArray array];
#ifdef NoServer
    MyChuanKuaYueItem *item = [MyChuanKuaYueItem new];
    item.constructionUnit = @"单位1";
    item.other = @"地址1";
    
    MyChuanKuaYueItem *item1 = [MyChuanKuaYueItem new];
    item1.constructionUnit = @"单位2";
    item1.other = @"地址2";
    
    _modelList = @[item,item1];
    
    return;
#endif
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.title = @"变更记录";
    
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.myTableView.backgroundColor = [UIColor seperatorColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    self.myTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    
    [self.view addSubview:self.myTableView];
    
    [self.myTableView reloadData];
    
}

-(void) requestData
{
    pageNum = 1;
    @weakify(self)
    HttpSuccessCallback successCallback =^(NSURLSessionDataTask *task, id dict) {
        @strongify(self)
        MyChuanKuaYueListModel *model = [MyChuanKuaYueListModel objectWithKeyValues:dict];
        if (model.success)
        {
            pageNum ++;
            _modelList = [model.datalist copy];
            hasMore = [model hasMore];
            [self.myTableView reloadData];
            
        }else if (model.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        [self.myTableView.mj_header endRefreshing];
        
    };
    
    HttpFailCallback failCallback = ^(NSURLSessionDataTask *task, NSError *error) {
        @strongify(self)
        [self.myTableView.mj_header endRefreshing];
        [ToastView popToast:@"刷新失败,请稍候再试"];
    };
    
    [[EventHttpManager sharedManager] requestQueryHistoryChuanKuaYueWithPage:pageNum ID:historyID SuccessCallback:successCallback failCallback:failCallback];
}

-(void) requestMoreData
{
    if (!hasMore) {
        [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    @weakify(self)
    [[EventHttpManager sharedManager] requestQueryHistoryChuanKuaYueWithPage:pageNum ID:historyID SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        //todo
        @strongify(self)
        MyChuanKuaYueListModel *model = [MyChuanKuaYueListModel objectWithKeyValues:dict];
        if (model.success)
        {
            pageNum ++;
            _modelList = [_modelList arrayByAddingObjectsFromArray:model.datalist];
            hasMore = [model hasMore];
            if (hasMore) {
                [self.myTableView.mj_footer endRefreshing];
            }else
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            
            [self.myTableView reloadData];
        }else if (model.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [self.myTableView.mj_footer endRefreshing];
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        //todo
        [self.myTableView.mj_footer endRefreshing];
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
        return [MyChuanKuaYueListItemCell heightForHistoryCell];
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelList.count*2-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    if (indexPath.row%2 == 1) {
        //sep cell
        QRSeparatorCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"sepCell"];
        if (!cell) {
            cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"sepCell"];
            
        }
        return cell;
    }
    
    row = row/2;
    
    
    if (row < _modelList.count) {
        MyChuanKuaYueListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyChuanKuaYueListItemCell"];
        if (!cell) {
            cell = [[MyChuanKuaYueListItemCell alloc] initHistoryWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyChuanKuaYueListItemCell"];
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
    MyChuanKuaYueItem *item = _modelList[row];
    //todo push to new vc
    MyChuanKuaYueDetailViewController *vc = [[MyChuanKuaYueDetailViewController alloc] initWithId:item.theId isHistory:YES];
    vc.title = [item cellTitle];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
