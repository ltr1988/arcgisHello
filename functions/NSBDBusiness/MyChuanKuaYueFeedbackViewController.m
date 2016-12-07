//
//  MyChuanKuaYueFeedbackViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueFeedbackViewController.h"
#import "MyChuanKuaYueFeedbackViewController+pickMedia.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "CenterSwitchView.h"
#import "EventMediaPickerView.h"
#import "FeedbackModel.h"
#import "TitleDetailTextItem.h"
#import "TitleDetailItem.h"
#import "UploadAttachmentModel.h"
#import "NSString+UUID.h"
#import "HttpBaseModel.h"

#import "TitleDetailCell.h"
#import "QRSeparatorCell.h"
#import "EventHttpManager+ChuanKuaYue.h"
#import "TextPickerViewController.h"
#import "MyChuanKuaYueItem.h"
#import "MJRefresh.h"
#import "MyChuanKuaYueProgressItem.h"
#import "MyChuanKuaYueProgressModel.h"
#import "MyChuanKuaYueHistoryCell.h"

@interface MyChuanKuaYueFeedbackViewController ()<CenterSwitchActionDelegate>
{
    NSInteger selectedIndex;
    
    NSInteger myFeedbackPage;
    BOOL myFeedbackHasMore;
    NSInteger historyPage;
    BOOL historyHasMore;
}
@property (nonatomic,strong) MyChuanKuaYueItem* crossItem;
@end

@implementation MyChuanKuaYueFeedbackViewController

-(instancetype) initWithCrossItem:(MyChuanKuaYueItem *)item
{
    self = [super init];
    if (self) {
        _crossItem = item;
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
    [self setupObservers];
    [self setupPickerManager];
}

-(void) setupObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textPicked:) name:@"TextPickerNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(attachmentComplete:) name:@"attachmentComplete" object:nil];
    
}

-(void) attachmentComplete:(NSNotification *)noti
{
    [self.myFeedbackTableView reloadData];
    [self.historyTableView reloadData];
}

-(void) textPicked:(NSNotification *)noti
{
    [self.feedbackTableView reloadData];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void) setupModel
{
    myFeedbackPage = 1;
    myFeedbackHasMore = YES;
    historyPage = 1;
    historyHasMore = YES;
    //model for feedback
    _feedbackModel = [FeedbackModel new];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
    
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    _feedbackModel.date = [TitleDetailItem itemWithTitle:@"反馈时间" detail:[formater stringFromDate:[NSDate date]]];
    _feedbackModel.detail = [TitleDetailTextItem itemWithTitle:@"进展描述" detail:@"未填写" text:@""];
    _feedbackModel.images = [NSMutableArray arrayWithCapacity:6];
    
#ifdef NoServer
    //model for history
//    MyEventHistoryItem *item1 =[[MyEventHistoryItem alloc] init];
//    item1.disposeDescription = @"我呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜";
//    item1.addTime = @"2016-1-2";
//    item1.disposeBy = @"北京";
//    item1.creatorName = @"勿忘我";
//    item1.attachment.images =[@[@"http://tva2.sinaimg.cn/crop.0.0.180.180.180/65de1936jw1e8qgp5bmzyj2050050aa8.jpg"] mutableCopy];
//    
//    MyEventHistoryItem *item2 =[[MyEventHistoryItem alloc] init];
//    item2.disposeDescription = @"我呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜";
//    item2.addTime = @"2016-1-2 13:00:01";
//    item2.disposeBy = @"北京";
//    item2.creatorName = @"lls";
//    _historyModel = @[item1,item2];
    return;
#endif
    _historyModel = [NSArray array];
    _myFeedbackModel = [NSArray array];
    [self requestHistoryData];
    [self requestFeedbackData];
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    CenterSwitchView *view = [[CenterSwitchView alloc] initWithFrame:CGRectMake(0, 0, CenetrSwitchLabelWidth*3, CenetrSwitchHeight) andTitleArray:@[@"进展反馈",@"我的反馈",@"历史进展"] andDelegate:self andSelectIndex:0];
    selectedIndex = 0;
    view.delegate = self;
    [self navigationItem].titleView = view;
    
    self.feedbackTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.feedbackTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.feedbackTableView.backgroundColor = [UIColor whiteColor];
    self.feedbackTableView.delegate = self;
    self.feedbackTableView.dataSource = self;
    self.feedbackTableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    
    self.feedbackTableView.tableFooterView = [self footerView];
    self.feedbackTableView.hidden = (selectedIndex!=0);
    [self.view addSubview:self.feedbackTableView];
    
    self.historyTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.historyTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.historyTableView.backgroundColor = [UIColor seperatorColor];
    self.historyTableView.delegate = self;
    self.historyTableView.dataSource = self;
    self.historyTableView.hidden = (selectedIndex!=2);
    self.historyTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHistoryData)];
    self.historyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreHistoryData)];
    
    [self.view addSubview:self.historyTableView];
    
    self.myFeedbackTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myFeedbackTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.myFeedbackTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myFeedbackTableView.backgroundColor = [UIColor seperatorColor];
    self.myFeedbackTableView.delegate = self;
    self.myFeedbackTableView.dataSource = self;
    self.myFeedbackTableView.hidden = (selectedIndex!=1);
    self.myFeedbackTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestFeedbackData)];
    self.myFeedbackTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreFeedbackData)];
    
    [self.view addSubview:self.myFeedbackTableView];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    
    __weak __typeof(self) weakself = self;
    _mPicker = [[EventMediaPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)
                                                  readOnly:NO
                                               picCallback:^{
                                                   [weakself openPicMenu];
                                               } videoCallback:^{
                                                   [weakself openVideoMenu];
                                               } relayoutCallback:^{
                                                   [self.feedbackTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                                               }];
    
    
    [_mPicker setImages:self.feedbackModel.images];
    [_mPicker setVideo:self.feedbackModel.video];
    [_mPicker relayout];
    
    
    [self.feedbackTableView reloadData];
    
}

-(void) requestMoreHistoryData
{
    if (!historyHasMore) {
        [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    @weakify(self)
    [[EventHttpManager sharedManager] requestQueryHistoryChuanKuaYueProgressWithPage:historyPage AcrossCode:_crossItem.acrossCode SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        //todo
        @strongify(self)
        MyChuanKuaYueProgressModel *model = [MyChuanKuaYueProgressModel objectWithKeyValues:dict];
        if (model.success)
        {
            historyPage ++;
            _historyModel = [_historyModel arrayByAddingObjectsFromArray:model.datalist];
            historyHasMore = [model hasMore];
            if (historyHasMore) {
                [self.historyTableView.mj_footer endRefreshing];
            }else
                [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
            
            [self.historyTableView reloadData];
        }else if (model.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [self.historyTableView.mj_footer endRefreshing];
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        //todo
        [self.historyTableView.mj_footer endRefreshing];
        [ToastView popToast:@"刷新失败,请稍候再试"];
    }];

}
-(void) requestHistoryData
{
    @weakify(self)
    
    historyPage = 1;
    [[EventHttpManager sharedManager] requestQueryHistoryChuanKuaYueProgressWithPage:historyPage AcrossCode:_crossItem.acrossCode SuccessCallback:^(NSURLSessionDataTask *task, id dict) {

        @strongify(self)
        MyChuanKuaYueProgressModel *item = [MyChuanKuaYueProgressModel objectWithKeyValues:dict];
        if (item.success)
        {
            _historyModel = [item.datalist copy];
            [self.historyTableView reloadData];
            historyHasMore = [item hasMore];
            
        }else if (item.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        
        [self.historyTableView.mj_header endRefreshing];
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        [self.historyTableView.mj_header endRefreshing];
        [ToastView popToast:@"刷新失败,请稍候再试"];
    }];

}
-(void) requestMoreFeedbackData
{
    if (!myFeedbackHasMore) {
        [self.myFeedbackTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    @weakify(self)
     [[EventHttpManager sharedManager] requestQueryMyChuanKuaYueProgressWithPage:myFeedbackPage AcrossCode:_crossItem.acrossCode SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        
        @strongify(self)
         MyChuanKuaYueProgressModel *model = [MyChuanKuaYueProgressModel objectWithKeyValues:dict];
         if (model.success)
         {
             myFeedbackPage ++;
             _myFeedbackModel = [_myFeedbackModel arrayByAddingObjectsFromArray:model.datalist];
             myFeedbackHasMore = [model hasMore];
             if (myFeedbackHasMore) {
                 [self.myFeedbackTableView.mj_footer endRefreshing];
             }else
                 [self.myFeedbackTableView.mj_footer endRefreshingWithNoMoreData];
             
             [self.myFeedbackTableView reloadData];
         }else if (model.status == HttpResultInvalidUser)
         {
             [ToastView popToast:@"您的帐号在其他地方登录"];
             [self.navigationController popToRootViewControllerAnimated:YES];
         }
         else
         {
             [self.myFeedbackTableView.mj_footer endRefreshing];
             [ToastView popToast:@"刷新失败,请稍候再试"];
         }
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        //todo
        [self.myFeedbackTableView.mj_footer endRefreshing];
        [ToastView popToast:@"刷新失败,请稍候再试"];
    }];
}
-(void) requestFeedbackData
{
    @weakify(self)
    
    myFeedbackPage = 1;
    [[EventHttpManager sharedManager] requestQueryMyChuanKuaYueProgressWithPage:myFeedbackPage AcrossCode:_crossItem.acrossCode SuccessCallback:^(NSURLSessionDataTask *task, id dict) {

        @strongify(self)
        MyChuanKuaYueProgressModel *item = [MyChuanKuaYueProgressModel objectWithKeyValues:dict];
        if (item.success)
        {
            _myFeedbackModel = [item.datalist copy];
            myFeedbackHasMore = [item hasMore];
            [self.myFeedbackTableView reloadData];
            
        }else if (item.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        
        [self.myFeedbackTableView.mj_header endRefreshing];
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        //todo
        
        [self.myFeedbackTableView.mj_header endRefreshing];
        [ToastView popToast:@"刷新失败,请稍候再试"];
    }];
    
}

-(UIView*) footerView
{
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kScreenWidth, 16*3+40*2);
    UIButton *btnCommit = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnCommit.backgroundColor = [UIColor themeBlueColor];
    [btnCommit setTitle:@"提交" forState:UIControlStateNormal];
    [btnCommit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCommit.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    btnCancel.backgroundColor = [UIColor themeDarkBlackColor];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCancel.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [btnCommit addTarget:self action:@selector(actionCommit:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel addTarget:self action:@selector(actionCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:btnCommit];
    [footer addSubview:btnCancel];
    
    CGFloat margin = 50;
    __weak UIView* weakView = footer;
    [btnCommit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(16);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnCommit.mas_bottom).offset(16);
        make.height.mas_equalTo(40);
        
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    return footer;
}


#pragma mark --centerSwitch delegate
- (void)centerSwitchToIndex:(NSUInteger)index
{
    selectedIndex = index;
    self.myFeedbackTableView.hidden = (selectedIndex!=1);
    self.historyTableView.hidden = (selectedIndex!=2);
    self.feedbackTableView.hidden = (selectedIndex!=0);
    NSLog(@"%@", [NSString stringWithFormat:@"change to index:%lu",(unsigned long)index]);
}

#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.feedbackTableView)
    {
        NSInteger row = indexPath.row;
        if (row == 2) {
            return 8;
        }
        if (row == 3) { //image picker
            return _mPicker.frame.size.height;
        }
        return 55;
    }else if(tableView == self.historyTableView)
    {
        NSInteger row = indexPath.row;
        if (row%2 == 1) {
            return 8;
        }
        row = row/2;
        if (row < _historyModel.count) {
            return [MyChuanKuaYueHistoryCell heightForData:_historyModel[row]];
        }
    }else if(tableView == self.myFeedbackTableView)
    {
        NSInteger row = indexPath.row;
        if (row%2 == 1) {
            return 8;
        }
        row = row/2;
        if (row < _myFeedbackModel.count) {
            return [MyChuanKuaYueHistoryCell heightForData:_myFeedbackModel[row]];
        }
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.feedbackTableView) {
        return 4;
    }else if(tableView == self.historyTableView)
    {
        return _historyModel.count*2-1;
    }else if(tableView == self.myFeedbackTableView)
    {
        return _myFeedbackModel.count*2-1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    if (tableView == self.feedbackTableView) {
        switch (row) {
                
            case 0:
            {
                TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell"];
                if (!cell) {
                    cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DateCell"];
                }
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
                _feedbackModel.date.detail = [formater stringFromDate:[NSDate date]];
                cell.data = self.feedbackModel.date;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            case 1:
            {
                TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
                if (!cell) {
                    cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.data = self.feedbackModel.detail;
                return cell;
            }
            case 2:
            {
                QRSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separatorCell"];
                if (!cell) {
                    cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"separatorCell"];
                }
                return cell;
            }
            case 3:
            {
                [_mPicker removeFromSuperview];
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EventMediaPickerCell"];
                [cell.contentView addSubview: _mPicker];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
        
    }else if(tableView == self.historyTableView)
    {
        if (row%2 == 1) {
            QRSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separatorCell"];
            if (!cell) {
                cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"separatorCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }else
        {
            row = row /2;
            if (row<_historyModel.count) {
                MyChuanKuaYueHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyChuanKuaYueHistoryCell"];
                if (!cell) {
                    cell = [[MyChuanKuaYueHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyChuanKuaYueHistoryCell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell.data = _historyModel[row];
                return cell;
            }
            
        }
    }else if(tableView == self.myFeedbackTableView)
    {
        if (row%2 == 1) {
            QRSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separatorCell"];
            if (!cell) {
                cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"separatorCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }else
        {
            row = row /2;
            if (row<_myFeedbackModel.count) {
                MyChuanKuaYueHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyChuanKuaYueHistoryCell"];
                if (!cell) {
                    cell = [[MyChuanKuaYueHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyChuanKuaYueHistoryCell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell.data = _myFeedbackModel[row];
                return cell;
            }
            
        }
    }

    
    return nil;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.feedbackTableView) {
        switch (indexPath.row) {
            case 1:
            {
                TextPickerViewController *vc = [[TextPickerViewController alloc] initWithData:self.feedbackModel.detail];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
        
    }else if(tableView == self.historyTableView)
    {
        
    }else if(tableView == self.myFeedbackTableView)
    {
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark actions
-(void) actionCommit:(id) sender
{
    @weakify(self)
    NSString *uuid = [NSString stringWithUUID];
    [[EventHttpManager sharedManager] requestAddMyChuanKuaYueProgressListWithId:uuid
                                                                     acrossId:_crossItem.acrossId
                                                                     acrossName:_crossItem.name
                                                                acrossCode:_crossItem.acrossCode
                                                                          content:self.feedbackModel.detail.text
                                                          SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
                                                              @strongify(self)
                                                              HttpBaseModel *item = [HttpBaseModel objectWithKeyValues:dict];
                                                              if (item.success)
                                                              {
                                                                  [ToastView popToast:@"提交成功"];
                                                                  if (self.feedbackModel.images.count>0) {
                                                                      for (UIImage *image in self.feedbackModel.images) {
                                                                          [[EventHttpManager sharedManager] requestUploadAttachment:image fkid:uuid qxyjFlag:NO successCallback:nil failCallback:nil];
                                                                      }
                                                                  }
                                                                  
                                                                  if (self.feedbackModel.video)
                                                                  {
                                                                      [[EventHttpManager sharedManager] requestUploadAttachmentMovie:self.feedbackModel.video fkid:uuid  qxyjFlag:NO successCallback:nil failCallback:nil];
                                                                      
                                                                  }
                                                                  self.feedbackModel.detail.detail = @"未填写";
                                                                  self.feedbackModel.detail.text = @"";
                                                                  self.feedbackModel.video = nil;
                                                                  [self.feedbackModel.images removeAllObjects];
                                                                  [self.mPicker setImages:self.feedbackModel.images];
                                                                  [self.mPicker setVideo:self.feedbackModel.video];
                                                                  [self.mPicker relayout];
                                                                  [self.feedbackTableView reloadData];
                                                                  [self.myFeedbackTableView.mj_header beginRefreshing];
                                                                  
                                                              }else if (item.status == HttpResultInvalidUser)
                                                              {
                                                                  [ToastView popToast:@"您的帐号在其他地方登录"];
                                                                  [self.navigationController popToRootViewControllerAnimated:YES];
                                                              }
                                                              else
                                                              {
                                                                  [ToastView popToast:@"提交失败,请稍候再试"];
                                                              }
                                                              
                                                          } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
                                                              //todo
                                                              [ToastView popToast:@"提交失败,请稍候再试"];
                                                          }];
    
}

-(void) actionCancel:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
