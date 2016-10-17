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
#import "UIColor+ThemeColor.h"
#import "SearchCategoryModel.h"
#import "SearchCategoryItem.h"
#import "SearchSheetItemManager.h"
#import "UITableView+EmptyView.h"
#import "SearchDetailSheetViewController.h"
#import "SearchHistoryDetailSheetModel.h"

@interface SearchSecondaryListViewController()
{
    UIView *headerView;
    BOOL readOnly;
}
@property (nonatomic,strong) SearchCategoryModel *model;
@property (nonatomic,strong) SearchHomePageItem *item;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TimerView *timerView;



@property (nonatomic,readonly) NSArray *lineCodeArray;
@property (nonatomic,readonly) NSDictionary *codeDictionary;
@property (nonatomic,readonly) NSDictionary *titleDictionary;
@end

@implementation SearchSecondaryListViewController

@synthesize lineCodeArray = _lineCodeArray;
@synthesize codeDictionary = _codeDictionary;
@synthesize titleDictionary = _titleDictionary;

-(instancetype) initWithSearchHomeItem:(SearchHomePageItem*) item
{
    return [self initWithSearchHomeItem:item readonly:NO];
}
-(instancetype) initReadonlyWithSearchHomeItem:(SearchHomePageItem*) item
{
    return [self initWithSearchHomeItem:item readonly:YES];
}
-(instancetype) initWithSearchHomeItem:(SearchHomePageItem*) item readonly:(BOOL) readonly
{
    if (self = [super init]) {
        _item = item;
        readOnly = readonly;
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

-(NSArray *) lineCodeArray
{
    if (!_lineCodeArray) {
        _lineCodeArray = @[@"NGQGX",
                           @"DGQGX",
                           @"DNGX",];
    }
    return _lineCodeArray;
    
}


-(BOOL) isLine //是否是管线
{
    if (_item) {
        for (NSString *code in self.lineCodeArray) {
            if ([code isEqualToString:_item.code]) {
                return YES;
            }
        }
    }
    return NO;
        
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    if (!readOnly) {
        self.taskId = [SearchSessionManager sharedManager].session.sessionId;
    }
    [self setupSubviews];
    if (readOnly) {
        [self.tableView.mj_header beginRefreshing];
    }
}

-(void) requestData
{
    if ([self isLine] && !readOnly)
    {
        self.model = [SearchCategoryModel new];
        self.model.uiItem = [_item sheetItem];
        self.model.datalist = [SearchSheetItemManager getSearchLineListWithCode:_item.code taskid:self.model.uiItem.taskid];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        return;
    }
    
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

    @weakify(self)
    if (readOnly) {
        if ([self isLine])
        {
            [[SearchSessionManager sharedManager] requestQueryHistoryLineListSearchSessionWithTaskId:self.taskId code:_item.code action:self.codeDictionary[_item.code] SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
                @strongify(self)
                
                SearchHistoryDetailSheetModel *model = [SearchHistoryDetailSheetModel objectWithKeyValues:dict];
                if (model.success) {
                    if (model.datalist.count>0) {
                        
                        self.model = [SearchCategoryModel new];
                        NSMutableArray *array = [NSMutableArray array];
                        for (NSArray *infoArray in model.datalist) {
                            NSBDBaseUIItem *item = [_item sheetItem];
                            [item setInfoArray:infoArray];
                            [array addObject:item];
                        }
                        self.model.datalist = [array copy];
                        [self.tableView reloadData];
                    }else
                    {
                        [self.tableView setEmptyView];
                    }
                }else if (self.model.status == HttpResultInvalidUser)
                {
                    [ToastView popToast:@"您的帐号在其他地方登录"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                
                [self.tableView.mj_header endRefreshing];

            } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
                
                @strongify(self)
                [self.tableView.mj_header endRefreshing];
            }];
        }else
        {
            [[SearchSessionManager sharedManager] requestQueryHistoryListSearchSessionWithTaskId:self.taskId code:_item.code action:self.codeDictionary[_item.code] SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
                @strongify(self)
                self.model = [SearchCategoryModel objectWithKeyValues:dict];
                if (self.model.success) {
                    self.model.uiItem = [_item sheetItem];
                    [self.tableView reloadData];
                }else if (self.model.status == HttpResultInvalidUser)
                {
                    [ToastView popToast:@"您的帐号在其他地方登录"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                
                [self.tableView.mj_header endRefreshing];
                
            } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
                
                @strongify(self)
                [self.tableView.mj_header endRefreshing];
            }];
        }
    }else{
        [[SearchSessionManager sharedManager] requestQueryListSearchSessionWithTaskId:self.taskId code:_item.code action:self.codeDictionary[_item.code] SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
            @strongify(self)
            self.model = [SearchCategoryModel objectWithKeyValues:dict];
            if (self.model.success) {
                self.model.uiItem = [_item sheetItem];
                [self.tableView reloadData];
            }else if (self.model.status == HttpResultInvalidUser)
            {
                [ToastView popToast:@"您的帐号在其他地方登录"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
            [self.tableView.mj_header endRefreshing];
            
        } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
            
            @strongify(self)
            [self.tableView.mj_header endRefreshing];
        }];
    }
}

-(void) setupSubviews
{
    self.title = self.titleDictionary[_item.code];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [self.view addSubview:_tableView];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    
    if ([self isLine] && !readOnly) {
        _tableView.tableHeaderView = [self headerView];
    }
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0)];
    
    if (!readOnly)
    {
        _timerView = [TimerView timerViewWithStartTime:[[SearchSessionManager sharedManager].session totalTime] frame:CGRectMake(0, 0, 80, 30) smallStyle:YES];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_timerView];
    }
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!readOnly)
    {
        [_timerView setShowTime:[[SearchSessionManager sharedManager].session totalTime]];
        
        if (![SearchSessionManager sharedManager].session.pauseState) {
            
            [_timerView continueTiming];
        }
        
        [_tableView.mj_header beginRefreshing];
    }
}

-(void) viewDidDisappear:(BOOL)animated
{
    if (!readOnly)
    {
        if (![SearchSessionManager sharedManager].session.pauseState) {
            [_timerView pauseTiming];
        }
    }
}

-(UIView *)headerView
{
    if (!headerView) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.backgroundColor = [UIColor themeBlueColor];
        [addBtn setTitle:@"填报新信息" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [headerView addSubview:addBtn];
        
        [addBtn addTarget:self action:@selector(actionNewLine) forControlEvents:UIControlEventTouchUpInside];
        
        __weak UIView *weakView = headerView;
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.bottom.offset(-5);
            make.width.mas_equalTo(200);
            make.centerX.mas_equalTo(weakView.mas_centerX);
        }];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    

    if (!_model || _model.datalist.count==0) {
        if (!([self isLine] && !readOnly)) {
            [tableView setEmptyView];
        }
        return 0;
    }
    [tableView removeEmptyView];
    return _model.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_model) {
        return [UITableViewCell new];
    }
    NSInteger row = indexPath.row;
    if (row < _model.datalist.count) {
        if ([self isLine]) {
            BaseTitleCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"BaseTitleCell"];
            if (!cell) {
                cell = [[BaseTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseTitleCell"];
            }
            
            cell.data = _model.datalist[row];
            return cell;
        }else
        {
            SearchCategoryItem *item = _model.datalist[row];
            
            BaseTitleCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"BaseTitleCell"];
            if (!cell) {
                cell = [[BaseTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseTitleCell"];
            }
            
            cell.data = item;
            return cell;
        }
    }
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SearchDetailSheetViewController *vc;
    if ([self isLine])
    {
        if (readOnly)
            vc = [SearchDetailSheetViewController sheetReadOnlyWithUIItem:self.model.datalist[indexPath.row]];
        else
            vc = [SearchDetailSheetViewController sheetEditableWithUIItem:self.model.datalist[indexPath.row]];
        vc.title = _item.title;
        vc.code = _item.code;
    }
    else
    {
        
        SearchCategoryItem *item = _model.datalist[indexPath.row];
        if (readOnly)
            vc = [SearchDetailSheetViewController sheetReadOnlyWithUIItem:[_item sheetItem]];
        else
            vc = [SearchDetailSheetViewController sheetEditableWithUIItem:[_item sheetItem]];
        vc.code = _item.code;
        vc.queryCode = self.codeDictionary[_item.code];
        vc.taskId = self.taskId;
        vc.title = _item.title;
        vc.fcode = item.facilityCode;
        vc.fname = item.fname;
    }
    [self.navigationController pushViewController:vc animated:YES];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void) actionNewLine
{
    SearchDetailSheetViewController *vc = [SearchDetailSheetViewController sheetEditableWithUIItem:self.model.uiItem];
    vc.code = _item.code;
    vc.title = _item.title;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
