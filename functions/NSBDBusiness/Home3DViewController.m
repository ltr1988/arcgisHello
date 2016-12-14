//
//  Home3DViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/4.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Home3DViewController.h"
#import "UIColor+ThemeColor.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "MapViewManager.h"
#import "RouteMapViewController.h"
#import "LocationManager.h"
#import "ToastView.h"
#import "RouteSearchResultItem.h"
#import "RouteSearchResultCell.h"
#import "SVProgressHUD.h"
#import "CenterTitleCell.h"
#import "AuthorizeManager.h"
#import "Home3DDataSource.h"
#import "Search3DHeaderModel.h"
#import "Search3DWordsLayoutView.h"
#import "Search3DHeaderItem.h"
#import "ComboBox.h"

#define MAXIMUM_HISTORYS 10

#define USER_SEARCH_3D_HISTORY [NSString stringWithFormat:@"search_3d_history_%@",[[AuthorizeManager sharedInstance] userName]]

@interface Home3DViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,ComBoxDelegate>
{
    Home3DDataSource *dataSource;
    BOOL showResult;
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UITableView *resultTable;
@property (nonatomic,strong) ComboBox *cbMANE;
@property (nonatomic,strong) ComboBox *cbCategory;

@property (nonatomic,strong) NSArray *cbMANEData;
@property (nonatomic,strong) NSArray *cbCategoryData;
@property (nonatomic,strong) NSString *cbMANEFilter;
@property (nonatomic,strong) NSString *cbCategoryFilter;

@property (nonatomic,strong) UITextField *searchField;
@property (nonatomic,strong) NSMutableArray *historyList;
@property (nonatomic,strong) NSArray *resultList;
@property (nonatomic,strong) Search3DHeaderMANEModel *headerManeModel;
@property (nonatomic,strong) Search3DHeaderCategoryModel *headerCategoryModel;

@end

@implementation Home3DViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupMembers];
    [self setupSubviews];
    [self requestHeaderData];
    [self refreshUI];
}

-(void) setupDataSource
{
    dataSource = [[Home3DDataSource alloc] init];
    
    NSDictionary *cacheInfo = [dataSource requestCache];
    if (cacheInfo) {
        self.headerManeModel = cacheInfo[Home3DDataInfoKeys.mane];
        self.headerCategoryModel = cacheInfo[Home3DDataInfoKeys.category];
    }
}

-(void) requestHeaderData
{
    //mock
    _headerManeModel = [Search3DHeaderMANEModel mockModel];
    _headerCategoryModel = [Search3DHeaderCategoryModel mockModel];
    
    if (_headerManeModel || _headerCategoryModel) {
        [self refreshHeader];
    }
}

-(void) refreshHeader
{
    if ((_headerManeModel.datalist.count==0) && (_headerCategoryModel.datalist.count==0))
    {
        _table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    else
    {
        _table.tableHeaderView = [self defaultHeaderView];
    }
}

-(UIView *)resultTableHeader
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *hline = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 4, 0.5, view.frame.size.height - 8)];
    hline.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:hline];
    
    
    _cbMANE = [[ComboBox alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 10 - 130, 0, 100, view.frame.size.height)];
    [_cbMANE setComboBoxTitle:@"管理单位"];
    _cbMANE.delegate = self;
    [_cbMANE setComboBoxData:_cbMANEData];
    [_cbMANE setComboBoxSize:CGSizeMake(100, 44*6)];
    [view addSubview:_cbMANE];
    
    _cbCategory = [[ComboBox alloc]initWithFrame:CGRectMake(kScreenWidth/2 + 10, 0, 100, view.frame.size.height)];
    [_cbCategory setComboBoxTitle:@"所属工程"];
    
    [_cbCategory setComboBoxData:_cbCategoryData];
    _cbCategory.delegate = self;
    [_cbCategory setComboBoxSize:CGSizeMake(100, 44*4)];
    [view addSubview:_cbCategory];
    
    return view;
    
}
-(UIView *) defaultHeaderView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    if ((_headerManeModel.datalist.count!=0) && (_headerCategoryModel.datalist.count!=0))
    {
        @weakify(self)
        Search3DWordsLayoutView *view1 = [[Search3DWordsLayoutView alloc] initWithCallback:^(NSInteger selectedIndex) {
            @strongify(self)
            Search3DHeaderItem* item = self.headerManeModel.datalist[selectedIndex];
            [self searchWithText:item.keyword];
        }];
        Search3DWordsLayoutView *view2 = [[Search3DWordsLayoutView alloc] initWithCallback:^(NSInteger selectedIndex) {
            @strongify(self)
            Search3DHeaderItem* item = self.headerCategoryModel.datalist[selectedIndex];
            [self searchWithText:item.keyword];
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor grayColor];
        [view addSubview:line];
        
        [view addSubview:view1];
        [view addSubview:view2];
        
        view1.words = [_headerManeModel stringArray];
        view2.words = [_headerCategoryModel stringArray];
        
        [view1 layOut];
        [view2 layOut];
        
        CGFloat height1,height2,height_line=4;
        height1 = [view1 heightForView];
        height2 = [view2 heightForView];
        
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.height.mas_equalTo(height1);
            make.left.offset(0);
            make.right.offset(0);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view1.mas_bottom);
            make.height.mas_equalTo(height_line);
            make.left.offset(0);
            make.right.offset(0);
        }];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_bottom);
            make.height.mas_equalTo(0.5);
            make.left.offset(0);
            make.right.offset(0);
        }];
        
        view.frame = CGRectMake(0, 0, self.view.frame.size.width, height1 + height2 + height_line);
    }
    else if (_headerManeModel.datalist.count !=0)
    {
        Search3DHeaderModel * aModel = _headerManeModel? :_headerCategoryModel;
        
        Search3DWordsLayoutView *view1;
        if (_headerCategoryModel) {
            
            @weakify(self)
            view1 = [[Search3DWordsLayoutView alloc] initWithCallback:^(NSInteger selectedIndex) {
                @strongify(self)
                Search3DHeaderItem* item = self.headerCategoryModel.datalist[selectedIndex];
                [self searchWithText:item.keyword];
            }];
        }else
        {
            
            @weakify(self)
            view1 = [[Search3DWordsLayoutView alloc] initWithCallback:^(NSInteger selectedIndex) {
                @strongify(self)
                Search3DHeaderItem* item = self.headerManeModel.datalist[selectedIndex];
                [self searchWithText:item.keyword];
            }];
        }
        
        
        
        [view addSubview:view1];
        
        view1.words = aModel.datalist;
        
        [view1 layOut];
        
        CGFloat height1;
        height1 = [view1 heightForView];
        
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.height.mas_equalTo(height1);
            make.left.offset(0);
            make.right.offset(0);
        }];
        
        view.frame = CGRectMake(0, 0, self.view.frame.size.width, height1);
    }
    
    
    return view;
}

-(void) mock
{
    NSArray *array1 = @[@"test1",@"test2"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:array1.count];
    for (NSString *feature in array1) {
        RouteSearchResultItem *item = [[RouteSearchResultItem alloc] init];
        item.title = feature;
        [array addObject:item];
    }
    _resultList = [array copy];
    if (_resultList.count) {
        showResult = YES;
    }else
        showResult = NO;
    [self refreshUI];
}

-(void) refreshUI
{
    _resultTable.hidden = !showResult;
    _table.hidden = showResult;
    if (showResult) {
        [_resultTable reloadData];
    }else
    {
        [_table reloadData];
    }
    
    
}

-(void) setupMembers
{
    [self setupDataSource];
    showResult = NO;
    _historyList = [NSMutableArray array];
    
    NSArray *list = [[NSUserDefaults standardUserDefaults] objectForKey:USER_SEARCH_3D_HISTORY];
    
    for(id aHistory in list )
    {
        RouteSearchResultItem *historyItem = [NSKeyedUnarchiver unarchiveObjectWithData:aHistory];
        [_historyList addObject:historyItem];
    }
    
    
    _cbMANEData = @[@"管理单位",@"团城湖管理处",@"大宁管理处",@"南干渠管理处",@"东干渠管理处",@"干线管理处"];
    _cbCategoryData = @[@"所属工程",@"3",@"4"];
}

-(void) setupTopBar
{
    
    UIView *imageBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 60, 32)];
    imageBg.backgroundColor = [UIColor whiteColor];
    imageBg.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35].CGColor;
    imageBg.layer.borderWidth = 0.5;
    imageBg.layer.cornerRadius = 16.0;
    imageBg.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageBg.layer.shouldRasterize = YES;
    imageBg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(10, 1, imageBg.frame.size.width - 10, 30)];
    _searchField.textColor = [UIColor blackColor];
    _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchField.font = [UIFont systemFontOfSize:13];
    _searchField.returnKeyType = UIReturnKeySearch;
    _searchField.placeholder = @"";
    _searchField.tintColor = HEXCOLOR(0xff6ca3d9);
    _searchField.backgroundColor = [UIColor clearColor];
    _searchField.delegate = self;
    _searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _searchField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    
    [imageBg addSubview: _searchField];
    
    self.navigationItem.titleView = imageBg;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_map_search"] style:UIBarButtonItemStylePlain target:self action:@selector(actionSearch)];
}

-(void) setupSubviews
{
    [self setupTopBar];
    
    __weak UIView *weakView = self.view;
    
    weakView.backgroundColor = [UIColor themeGrayBackgroundColor];
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSelectionStyleNone;
    _table.backgroundColor = [UIColor whiteColor];
    _table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_table];
    
    _resultTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _resultTable.hidden = YES;
    _resultTable.delegate = self;
    _resultTable.dataSource = self;
    _resultTable.separatorStyle = UITableViewCellSelectionStyleNone;
    _resultTable.backgroundColor = [UIColor whiteColor];
    
    _resultTable.tableHeaderView = [self resultTableHeader];
    [self.view addSubview:_resultTable];
    
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
        make.bottom.mas_equalTo(weakView.mas_bottom);
    }];
    
    [_resultTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
        make.bottom.mas_equalTo(weakView.mas_bottom);
    }];
    
}

-(void) saveHistory:(RouteSearchResultItem*)item
{
    if (!item) {
        return;
    }
    BOOL DidHave = NO;
    NSInteger index = 0;
    
    for(RouteSearchResultItem * aHistory in _historyList)
    {
        if ([aHistory.title isEqual:item]) {
            DidHave = YES;
            index = [_historyList indexOfObject:aHistory];
            break;
        }
    }
    if (!DidHave)
    {
        if ([_historyList count] >= MAXIMUM_HISTORYS) {
            [_historyList removeLastObject];
        }
        
        [_historyList insertObject: item atIndex:0];
    }
    else
    {
        [_historyList removeObjectAtIndex:index];
        
        [_historyList insertObject: item atIndex:0];
    }
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for(id aHistory in _historyList)
    {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:aHistory];
        [tempArray addObject:data];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:USER_SEARCH_3D_HISTORY];
}

-(void) searchWithText:(NSString *)text
{
    
    //--------------
    //to be deleted
        [self mock];
        return;
    //--------------
    if (text && text.length>0) {
        NSLog(@"search %@",text);
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    }
}

#pragma mark textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchWithText:textField.text];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (NSEqualRanges(range, NSMakeRange(0, 1)) && [string length] == 0 && textField.text.length ==1) {
        [self textFieldShouldClear:textField];
    }
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = @"";
    [textField resignFirstResponder];
    showResult = NO;
    
    [self refreshUI];
    return YES;
}

-(void) actionSearch
{
    [self searchWithText:_searchField.text];
}

- (void)cleanHistory
{
    [_historyList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:_historyList forKey:USER_SEARCH_3D_HISTORY];
    
    [self refreshUI];
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = (tableView==_resultTable) ?_resultList.count:(_historyList.count==0?0:_historyList.count+1);

    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row<0 || row>=  (showResult?_resultList.count:(_historyList.count==0?0:_historyList.count+1))) {
        return [UITableViewCell new];
    }
    if (!showResult && (row == _historyList.count)) {
        CenterTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cleanCell"];
        if (!cell)
        {
            cell = [[CenterTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cleanCell"];
        }
        [cell setTitle: @"清空搜索历史"];
        return cell;
    }else{
        RouteSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell"];
        if (!cell) {
            cell = [[RouteSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resultCell"];
        }
        
        if (showResult) {
            RouteSearchResultItem * item = _resultList[row];
            [cell setTitle:item.title];
        }else
        {
            
            RouteSearchResultItem * item = _historyList[row];
            [cell setTitle:item.title];
            
        }
        return cell;
    }
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ((tableView== _table) && indexPath.row == (_historyList.count)) {
        [self cleanHistory];
    }else
    {
        RouteSearchResultItem * item = (tableView == _resultTable)? _resultList[row] :_historyList[row];
        [self saveHistory:item];
        //go to 3d web site
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark - ComboBox
-(void)comboBox:(ComboBox *)comboBox didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cbMANE == comboBox) {
        if (indexPath.row == 0) {
            _cbMANEFilter = @"";
        }else
        {
            _cbMANEFilter = _cbMANEData[indexPath.row];
        }
    }else
    {
        if (indexPath.row == 0) {
            _cbCategoryFilter = @"";
        }else
        {
            _cbCategoryFilter = _cbCategoryData[indexPath.row];
        }
    }
    if (_searchField.text.length>0) {
        [self searchWithText:_searchField.text];
    }
}
@end
