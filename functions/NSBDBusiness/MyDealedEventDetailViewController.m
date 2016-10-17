//
//  MyDealedEventDetailViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyDealedEventDetailViewController.h"
#import "MyDealedEventItem.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "TitleDetailCell.h"
#import "TitleDetailItem.h"
#import "MJRefresh.h"
#import "EventHttpManager.h"
#import "MyDealedEventDetailItem.h"
#import "MyDealedEventDetailModel.h"

@interface MyDealedEventDetailViewController ()
{
    UILabel *titleLabel;
}
@property (nonatomic,strong) MyDealedEventItem *item;

@property (nonatomic,strong) MyDealedEventDetailItem *model;

@property (nonatomic,strong) UITableView *eventDetailTableView;
@property (nonatomic,strong) NSArray *modelList;

@end

@implementation MyDealedEventDetailViewController

-(instancetype) initWithDealedEventItem:(MyDealedEventItem *)item
{
    if (self = [super init])
    {
        _item = item;
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    [self.eventDetailTableView.mj_header beginRefreshing];
}

-(void) requestData
{
#ifdef NoServer
    TitleDetailItem *item1 = [TitleDetailItem itemWithTitle:@"任务名称" detail:self.item.name];
    TitleDetailItem *item2 = [TitleDetailItem itemWithTitle:@"下达时间" detail:self.item.makeTime];
    TitleDetailItem *item3 = [TitleDetailItem itemWithTitle:@"处置单位" detail:self.item.departmentName];
    TitleDetailItem *item4 = [TitleDetailItem itemWithTitle:@"处置人员" detail:self.item.executorName];
    TitleDetailItem *item5 = [TitleDetailItem itemWithTitle:@"任务描述" detail:@"Test描述"];
    TitleDetailItem *item6 = [TitleDetailItem itemWithTitle:@"任务状态" detail:self.item.status];
    
    _modelList = @[item1,item2,item3,item4,item5,item6];
    
    titleLabel.text = @"Test标题";
    
    [self.eventDetailTableView.mj_header endRefreshing];
    [self.eventDetailTableView reloadData];
    return;
#endif
    @weakify(self)
    [[EventHttpManager sharedManager] requestMyDealedEventDetailWithId:self.item.eid SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        //todo
        @strongify(self)
        MyDealedEventDetailModel *item = [MyDealedEventDetailModel objectWithKeyValues:dict];
        if (item.success)
        {
            self.model = item.dataItem;
            [self refreshData];
            
        }else if (item.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        [self.eventDetailTableView.mj_header endRefreshing];
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        @strongify(self)
        [self.eventDetailTableView.mj_header endRefreshing];
        [ToastView popToast:@"刷新失败,请稍候再试"];
    }];

}

-(void) refreshData
{
    TitleDetailItem *item1 = [TitleDetailItem itemWithTitle:@"任务名称" detail:self.model.name];
    TitleDetailItem *item2 = [TitleDetailItem itemWithTitle:@"下达时间" detail:self.model.makeTime];
    TitleDetailItem *item3 = [TitleDetailItem itemWithTitle:@"处置单位" detail:self.model.departmentName];
    TitleDetailItem *item4 = [TitleDetailItem itemWithTitle:@"处置人员" detail:self.model.executorName];
    TitleDetailItem *item5 = [TitleDetailItem itemWithTitle:@"任务描述" detail:self.model.content];
    TitleDetailItem *item6 = [TitleDetailItem itemWithTitle:@"任务状态" detail:self.model.status];
    
    _modelList = @[item1,item2,item3,item4,item5,item6];
    
    titleLabel.text = self.model.title;
    
    [self.eventDetailTableView reloadData];
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.title = @"待办应急事件";
    
    self.eventDetailTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.eventDetailTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.eventDetailTableView.backgroundColor = [UIColor seperatorColor];
    self.eventDetailTableView.delegate = self;
    self.eventDetailTableView.dataSource = self;
    
    self.eventDetailTableView.tableHeaderView = [self headerView];
    self.eventDetailTableView.tableFooterView = [self footerView];
    self.eventDetailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [self.view addSubview:self.eventDetailTableView];
    
    [self.eventDetailTableView reloadData];
    
}

-(UIView *) headerView
{
    UIView *header = [UIView new];
    header.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
    header.backgroundColor = [UIColor whiteColor];
    
    titleLabel = [UILabel new];
    titleLabel.font = UI_FONT(20);
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.model.title;
    [header addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
    }];
    
    return header;
}
-(UIView*) footerView
{
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kScreenWidth, 16*3+40*2);
    UIButton *btnProgress = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnProgress.backgroundColor = [UIColor themeBlueColor];
    [btnProgress setTitle:@"任务进展" forState:UIControlStateNormal];
    [btnProgress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnProgress.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    btnCancel.backgroundColor = [UIColor themeDarkBlackColor];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCancel.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [btnProgress addTarget:self action:@selector(actionProgress:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel addTarget:self action:@selector(actionCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:btnProgress];
    [footer addSubview:btnCancel];
    
    CGFloat margin = 50;
    __weak UIView* weakView = footer;
    [btnProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(16);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnProgress.mas_bottom).offset(16);
        make.height.mas_equalTo(40);
        
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    return footer;
}

-(void) actionProgress:(id) sender
{
    
}

-(void) actionCancel:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    
    if (row < _modelList.count) {
        TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
        if (!cell) {
            cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.readOnly = YES;
        }
        cell.data = _modelList[row];
        return cell;
    }
    
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
