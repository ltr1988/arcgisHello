//
//  MyUploadEventViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyUploadEventViewController.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "CenterSwitchView.h"
#import "QRSeparatorCell.h"
#import "MyLocalEventCell.h"
#import "MyUploadedEventCell.h"
#import "EventReportModel.h"
#import "UITableView+EmptyView.h"
#import "EventReportViewController.h"
#import "TitleDateItem.h"
#import "TitleInputItem.h"
#import "TitleDetailTextItem.h"
#import "EventModelManager.h"
#import "EventHttpManager.h"
#import "CommitedEventHistoryItem.h"
#import "CommitedEventHistoryModel.h"
#import "UploadAttachmentModel.h"
#import "MJRefresh.h"

@interface MyUploadEventViewController()<CenterSwitchActionDelegate>
{
    NSInteger selectedIndex;
    
    BOOL hasMore;
    NSInteger requestPage;
}
@end

@implementation MyUploadEventViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _localEventModel = [EventModelManager getEventModels];
    [self.localEventTableView reloadData];
    
    [self.uploadedEventTableView reloadData];
}

-(void) setupModel
{
    requestPage = 1;
    hasMore =YES;
    _localEventModel = [EventModelManager getEventModels];
    _uploadedEventModel = [NSMutableArray array];
#ifdef NoServer
    EventReportModel *eventModel = [EventReportModel new];
    eventModel.eventName = [TitleInputItem itemWithTitle:@"事件名称" placeholder:@"请输入事件名称"];
    eventModel.eventType = [TitleDetailItem itemWithTitle:@"事件类型" detail:@"未填写"];
    eventModel.level = [TitleDetailItem itemWithTitle:@"等级初判" detail:@"未填写"];
    eventModel.reason = [TitleDetailItem itemWithTitle:@"初步原因" detail:@"未填写"];
    
    
    eventModel.eventDate = [TitleDateItem itemWithTitle:@"事发时间"];
    eventModel.place = [TitleInputItem itemWithTitle:@"事发地点" placeholder:@"请输入地点名称"];
    
    eventModel.reporter = [TitleInputItem itemWithTitle:@"填报人员" placeholder:@"请输入人员名称"];
    eventModel.eventStatus = [TitleDetailTextItem itemWithTitle:@"事件情况" detail:@"未填写" text:@""];
    eventModel.attachmentModel = [[UploadAttachmentModel alloc] init];
    eventModel.eventName.detail = @"test";
    

    _uploadedEventModel = [@[eventModel] mutableCopy];
    return;
#endif
    [self requestData];
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    CenterSwitchView *view = [[CenterSwitchView alloc] initWithFrame:CGRectMake(0, 0, CenetrSwitchLabelWidth*2, CenetrSwitchHeight) andTitleArray:@[@"未上报",@"已上报"] andDelegate:self andSelectIndex:0];
    selectedIndex = 0;
    view.delegate = self;
    [self navigationItem].titleView = view;
    
    self.localEventTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.localEventTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.localEventTableView.backgroundColor = [UIColor seperatorColor];
    self.localEventTableView.delegate = self;
    self.localEventTableView.dataSource = self;
    self.localEventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.localEventTableView.hidden = (selectedIndex!=0);
    [self.view addSubview:self.localEventTableView];
    
    self.uploadedEventTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.uploadedEventTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.uploadedEventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.uploadedEventTableView.delegate = self;
    self.uploadedEventTableView.dataSource = self;
    self.uploadedEventTableView.backgroundColor = [UIColor seperatorColor];
    self.uploadedEventTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    self.uploadedEventTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    self.uploadedEventTableView.hidden = (selectedIndex==0);
    
    [self.view addSubview:self.uploadedEventTableView];
}


#pragma mark --http request
-(void) requestData
{
    @weakify(self)
    requestPage =1;
    [[EventHttpManager sharedManager] requestHistoryEventWithPage:requestPage SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        @strongify(self)
        CommitedEventHistoryModel *model = [CommitedEventHistoryModel objectWithKeyValues:dict];
        if (model.success)
        {
            requestPage++;
            [self.uploadedEventModel removeAllObjects];
            for (id data in model.datalist) {
                EventReportModel *eModelItem = [[EventReportModel alloc] initWithMyEventHistoryItem:data];
                
                [self.uploadedEventModel addObject:eModelItem];
            }
            hasMore = [model hasMore];
            [self.uploadedEventTableView reloadData];
        }else if (model.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
            [ToastView popToast:@"加载失败，请稍后再试"];
        [_uploadedEventTableView.mj_header endRefreshing];
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        @strongify(self)
        [ToastView popToast:@"加载失败，请稍后再试"];
        [self.uploadedEventTableView.mj_footer endRefreshing];
    }];
}

-(void) requestMoreData
{
    if (!hasMore) {
        [_uploadedEventTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [[EventHttpManager sharedManager] requestHistoryEventWithPage:requestPage SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        
        CommitedEventHistoryModel *model = [CommitedEventHistoryModel objectWithKeyValues:dict];
        if (model.success)
        {
            requestPage++;
            for (id data in model.datalist) {
  
                [_uploadedEventModel addObject:data];
            }
            hasMore = [model hasMore];
            if (hasMore) {
                [_uploadedEventTableView.mj_footer endRefreshing];
            }else
            {
                [_uploadedEventTableView.mj_footer endRefreshingWithNoMoreData];
            }
            [_uploadedEventTableView reloadData];
        }else if (model.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            [ToastView popToast:@"加载失败，请稍后再试"];
        }
        
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        [ToastView popToast:@"加载失败，请稍后再试"];
        [_uploadedEventTableView.mj_footer endRefreshing];
    }];
}

#pragma mark --centerSwitch delegate
- (void)centerSwitchToIndex:(NSUInteger)index
{
    selectedIndex = index;
    self.uploadedEventTableView.hidden = (selectedIndex==0);
    self.localEventTableView.hidden = (selectedIndex!=0);
    NSLog(@"%@", [NSString stringWithFormat:@"change to index:%lu",(unsigned long)index]);
}

#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.localEventTableView)
    {
        NSInteger row = indexPath.row;
        if (row%2 == 1) {
            return 8;
        }

        return [MyLocalEventCell heightForCell];
    }else if(tableView == self.uploadedEventTableView)
    {
        NSInteger row = indexPath.row;
        if (row%2 == 1) {
            return 8;
        }
        return [MyUploadedEventCell heightForCell];
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.localEventTableView) {
        if (_localEventModel.count == 0)
        {
            [tableView setEmptyView];
        }else
        {
            [tableView removeEmptyView];
        }
        return _localEventModel.count*2-1;
    }else if(tableView == self.uploadedEventTableView)
    {
        if (_uploadedEventModel.count == 0)
        {
            [tableView setEmptyView];
        }else
        {
            [tableView removeEmptyView];
        }
        return _uploadedEventModel.count*2-1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    if (tableView == self.localEventTableView) {
        
        if (row%2 == 1) {
            QRSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separatorCell"];
            if (!cell) {
                cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"separatorCell"];
            }
            return cell;
        }else
        {
            row = row /2;
            if (row<_localEventModel.count) {
                MyLocalEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyLocalEventCell"];
                if (!cell) {
                    @weakify(self)
                    cell = [[MyLocalEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyLocalEventCell"];
                    cell.deleteCallback = ^(EventReportModel *model)
                    {
                        [EventModelManager removeCacheForEventModel:model];
                        NSMutableArray *array = [_localEventModel mutableCopy];
                        [array removeObject:model];
                        _localEventModel = [array copy];
                        [tableView reloadData];
                        
                    };
                    cell.reportCallback = ^(EventReportModel *model)
                    {
                        //report first
                        @strongify(self)
                        [[EventHttpManager sharedManager] requestNewEvent:_localEventModel[row] successCallback:^(NSURLSessionDataTask *task, id dict) {
                            //todo
                            EventReportModel *model = self.localEventModel[row];
                            HttpBaseModel *item = [HttpBaseModel objectWithKeyValues:dict];
                            if (item.success)
                            {
                                [EventModelManager removeCacheForEventModel:model];
                                if (model.attachmentModel.images.count>0 || model.attachmentModel.videoURL != nil) {
                                    
                                    if (model.attachmentModel.images.count>0) {
                                        for (UIImage *image in model.attachmentModel.images) {
                                            [[EventHttpManager sharedManager] requestUploadAttachment:image fkid:model.uuid  qxyjFlag:YES btype:@"incident" successCallback:nil failCallback:nil];
                                        }
                                    }
                                    
                                    if (model.attachmentModel.videoURL)
                                    {
                                        [[EventHttpManager sharedManager] requestUploadAttachmentMovie:model.attachmentModel.videoURL fkid:model.uuid qxyjFlag:YES btype:@"incident" successCallback:nil failCallback:nil];
                                        
                                    }
                                }
                                [ToastView popToast:@"上报成功"];
                                
                                [tableView reloadData];
                                
                            }else if (item.status == HttpResultInvalidUser)
                            {
                                [ToastView popToast:@"您的帐号在其他地方登录"];
                                [self.navigationController popToRootViewControllerAnimated:YES];
                            }
                            
                            [ToastView popToast:@"上报失败,请稍候再试"];
                            
                        } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
                            //todo
                            [ToastView popToast:@"上报失败,请稍候再试"];
                        }];

                    };
                }
                cell.data = _localEventModel[row];
                
                return cell;
            }
            
        }

    }else if(tableView == self.uploadedEventTableView)
    {
        if (row%2 == 1) {
            QRSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separatorCell"];
            if (!cell) {
                cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"separatorCell"];
            }
            return cell;
        }else
        {
            row = row /2;
            if (row<_uploadedEventModel.count) {
                MyUploadedEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyUploadedEventCell"];
                if (!cell) {
                    cell = [[MyUploadedEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyUploadedEventCell"];
                }
                cell.data = _uploadedEventModel[row];
                return cell;
            }
            
        }
    }
    
    return nil;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.localEventTableView) {
        if (indexPath.row %2 ==1) {
            return;
        }
        NSInteger row = indexPath.row/2;
        if (row <self.localEventModel.count) {
            EventReportViewController *vc = [[EventReportViewController alloc] initWithModel:_localEventModel[row]];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(tableView == self.uploadedEventTableView)
    {
        if (indexPath.row %2 ==1) {
            return;
        }
        NSInteger row = indexPath.row/2;
        if (row <self.uploadedEventModel.count) {
            CommitedEventHistoryItem *data = _uploadedEventModel[row];
            EventReportModel *model = [[EventReportModel alloc] initWithMyEventHistoryItem:data];
            
            EventReportViewController *vc = [[EventReportViewController alloc] initWithModel:model];
            vc.readonly = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
