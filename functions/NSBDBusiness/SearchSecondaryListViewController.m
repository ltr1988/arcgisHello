//
//  SearchSecondaryListViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/24.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSecondaryListViewController.h"
#import "SearchHomePageItem.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "QRSeparatorCell.h"
#import "SearchSheetCellFactory.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "NSBDBaseUIItem.h"
#import "TimerView.h"
#import "MJRefresh.h"
#import "SearchCategoryModel.h"
#import "SearchCategoryItem.h"

#import "SearchDetailSheetViewController.h"


@interface SearchSecondaryListViewController()
@property (nonatomic,strong) SearchCategoryModel *model;
@property (nonatomic,strong) SearchHomePageItem *item;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TimerView *timerView;



@property (nonatomic,readonly) NSDictionary *codeDictionary;
@property (nonatomic,readonly) NSDictionary *titleDictionary;
@end

@implementation SearchSecondaryListViewController
@synthesize codeDictionary = _codeDictionary;
@synthesize titleDictionary = _titleDictionary;

-(instancetype) initWithSearchHomeItem:(SearchHomePageItem*) item
{
    if (self = [super init]) {
        _item = item;
    }
    return self;
}

-(NSDictionary *) codeDictionary
{
    if (!_codeDictionary) {
        _codeDictionary = @{@"NGQPKJUP":@"ngqqueryair",
                            @"NGQPKJDOWN":@"ngqqueryair",
                            @"NGQPQJUP":@"ngqquerywell",
                            @"NGQPQJDOWN":@"ngqquerywell",
                            @"NGQGX":@"ngqqueryline",
                            @"DGQPQJ":@"dgqqueryair",
                            @"DGQFSK":@"dgqquerywater",
                            @"DGQPKJ":@"dgqquerywell",
                            @"DGQGX":@"dgqqueryline",
                            @"DNPKJ":@"dnquerywell",
                            @"DNPQJ":@"dnqueryair",
                            @"DNGX":@"dnqueryline"};
    }
    return _codeDictionary;
    
}

-(NSDictionary *) titleDictionary
{
    if (!_titleDictionary) {
        _titleDictionary = @{@"NGQPKJUP":@"南干渠排空井上段",
                            @"NGQPKJDOWN":@"南干渠排空井下段",
                            @"NGQPQJUP":@"南干渠排气阀井上段",
                            @"NGQPQJDOWN":@"南干渠排气阀井下段",
                            @"NGQGX":@"南干渠管线",
                            @"DGQPQJ":@"东干渠排气阀井",
                            @"DGQFSK":@"东干渠分水口",
                            @"DGQPKJ":@"东干渠排空井",
                            @"DGQGX":@"东干渠管线",
                            @"DNPKJ":@"大宁排空井",
                            @"DNPQJ":@"大宁排气阀井",
                            @"DNGX":@"大宁管线"};
    }
    return _titleDictionary;
    
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void) requestData
{
#ifdef NoServer
    //mock
    id mock = @[
                @{@"facilityCode":@"f1"},
                @{@"facilityCode":@"f2"},
                @{@"facilityCode":@"f3"}
                ];
    NSDictionary *dict =@{@"status":@"100",@"data":mock};

    self.model = [SearchCategoryModel objectWithKeyValues:dict];
    if (self.model.success) {
        self.model.uiItem = [_item sheetItem];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }
    return;
#endif
    
    if (![[AFNetworkReachabilityManager sharedManager] isReachable])
    {
        [ToastView popToast:@"暂无网络，稍后再试"];
        return;
    }
    @weakify(self);
    [[SearchSessionManager sharedManager] requestQueryListSearchSessionWithTaskId:[SearchSessionManager sharedManager].session.sessionId code:_item.code action:self.codeDictionary[_item.code] SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        @strongify(self);
        self.model = [SearchCategoryModel objectWithKeyValues:dict];
        if (self.model.success) {
            self.model.uiItem = [_item sheetItem];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }else if (self.model.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void) setupSubviews
{
    self.title = self.titleDictionary[_item.code];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [self.view addSubview:_tableView];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0)];
    
    _timerView = [TimerView timerViewWithStartTime:[[SearchSessionManager sharedManager].session totalTime] frame:CGRectMake(0, 0, 50, 30) smallStyle:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_timerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (!_model) {
        return 0;
    }
    return _model.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_model) {
        return [UITableViewCell new];
    }
    NSInteger row = indexPath.row;
    if (row < _model.datalist.count) {
        
        SearchCategoryItem *item = _model.datalist[row];
        
        BaseTitleCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"BaseTitleCell"];
        if (!cell) {
            cell = [[BaseTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseTitleCell"];
        }
        
        cell.data = item;
        return cell;
    }
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SearchDetailSheetViewController *vc = [SearchDetailSheetViewController sheetEditableWithUIItem:self.model.uiItem];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
