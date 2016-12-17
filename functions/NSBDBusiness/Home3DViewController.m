//
//  Home3DViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/4.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Home3DViewController.h"
#import "UIColor+ThemeColor.h"
#import "WebViewController.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "MapViewManager.h"
#import "RouteMapViewController.h"
#import "LocationManager.h"
#import "ToastView.h"
#import "Search3DResultItem.h"
#import "Search3DResultCell.h"
#import "SVProgressHUD.h"
#import "CenterTitleCell.h"
#import "AuthorizeManager.h"
#import "Home3DDataSource.h"
#import "Search3DHeaderModel.h"
#import "Search3DWordsLayoutView.h"
#import "Search3DHeaderItem.h"
#import "ComboBox.h"
#import "Search3DHttpManager.h"
#import "Search3DResultModel.h"

#define MAXIMUM_HISTORYS 10

#define USER_SEARCH_3D_HISTORY [NSString stringWithFormat:@"search_3d_history_%@",[[AuthorizeManager sharedInstance] userName]]

@interface Home3DViewController ()<CustomNaviBack,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,ComBoxDelegate>
{
    Home3DDataSource *dataSource;
    BOOL showResult;
}

@property (nonatomic,strong) UIView *resultView;
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

-(BOOL) customBackAction
{
    if (showResult) {
        showResult = NO;
        [self refreshUI];
        return NO;
    }else
        return YES;
}

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
//    //mock
//    _headerManeModel = [Search3DHeaderMANEModel mockModel];
//    _headerCategoryModel = [Search3DHeaderCategoryModel mockModel];
//    
//    if (_headerManeModel || _headerCategoryModel) {
//        [self refreshHeader];
//    }
    
    @weakify(self)
    [dataSource requestMANEHeaderDataWithSuccess:^(Search3DHeaderModel *model) {
        if (model && model.datalist.count>0) {
            @strongify(self)
            self.headerManeModel = (Search3DHeaderMANEModel*)model;
            [self refreshHeader];
        }
    } fail:^{
    }];
    
    [dataSource requestCategoryHeaderDataWithSuccess:^(Search3DHeaderModel *model) {
        if (model && model.datalist.count>0) {
            @strongify(self)
            self.headerCategoryModel = (Search3DHeaderCategoryModel*)model;
            [self refreshHeader];
        }
    } fail:^{
    }];
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
    
    
    UIView *tline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 0.5)];
    tline.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:tline];
    
    UIView *bline = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, view.frame.size.width, 0.5)];
    bline.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:bline];
    
    UIView *hline = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 14, 0.5, view.frame.size.height - 28)];
    hline.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:hline];
    
    
    _cbMANE = [[ComboBox alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 10 - 130, 0, 120, view.frame.size.height)];
    [_cbMANE setComboBoxTitle:@"管理单位"];
    _cbMANE.delegate = self;
    [_cbMANE setComboBoxData:_cbMANEData];
    [_cbMANE setComboBoxSize:CGSizeMake(120, 44*6)];
    [_resultView addSubview:_cbMANE];
    
    _cbCategory = [[ComboBox alloc]initWithFrame:CGRectMake(kScreenWidth/2 + 10, 0, 120, view.frame.size.height)];
    [_cbCategory setComboBoxTitle:@"所属工程"];
    
    [_cbCategory setComboBoxData:_cbCategoryData];
    _cbCategory.delegate = self;
    [_cbCategory setComboBoxSize:CGSizeMake(120, 44*4)];
    [_resultView addSubview:_cbCategory];
    
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
        line.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:line];
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:line2];
        
        [view addSubview:view1];
        [view addSubview:view2];
        
        view1.words = [_headerManeModel stringArray];
        view2.words = [_headerCategoryModel stringArray];
        
        [view1 layOut];
        [view2 layOut];
        
        CGFloat height1,height2,height_line=8;
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
            make.height.mas_equalTo(height2);
            make.left.offset(0);
            make.right.offset(0);
        }];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view2.mas_bottom);
            make.height.mas_equalTo(0.5);
            make.left.offset(0);
            make.right.offset(0);
        }];
        view.frame = CGRectMake(0, 0, self.view.frame.size.width, height1 + height2 + height_line);
    }
    else
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
        
        view1.words = [aModel stringArray];
        
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
        Search3DResultItem *item = [[Search3DResultItem alloc] init];
        item.title = feature;
        item.mane = @"管理处";
        item.modelpath = @"http://www.u3der.cn/index/obj1.html";
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
    _resultView.hidden = !showResult;
    _table.hidden = showResult;
    if (showResult) {
        [_resultView bringSubviewToFront:_cbMANE];
        [_resultView bringSubviewToFront:_cbCategory];
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
        Search3DResultItem *historyItem = [NSKeyedUnarchiver unarchiveObjectWithData:aHistory];
        [_historyList addObject:historyItem];
    }
    
    _cbMANEFilter = @"";
    _cbCategoryFilter = @"";
    
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
    _table.backgroundColor = [UIColor whiteColor];
    _table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_table];
    
    _resultView = [[UIView alloc] init];
    _resultTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _resultTable.delegate = self;
    _resultTable.dataSource = self;
    _resultTable.backgroundColor = [UIColor whiteColor];
    
    _resultTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_resultView addSubview:_resultTable];
    
    UIView *resultTableHeader =[self resultTableHeader];
    [_resultView addSubview:resultTableHeader];
    _resultView.hidden = YES;
    [self.view addSubview:_resultView];
    
    [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
        make.bottom.mas_equalTo(weakView.mas_bottom);
    }];
    
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
        make.bottom.mas_equalTo(weakView.mas_bottom);
    }];
    
    [resultTableHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    [_resultTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(resultTableHeader.mas_bottom);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
        make.bottom.mas_equalTo(weakView.mas_bottom);
    }];
    
}

-(void) saveHistory:(Search3DResultItem*)item
{
    if (!item) {
        return;
    }
    BOOL DidHave = NO;
    NSInteger index = 0;
    
    for(Search3DResultItem * aHistory in _historyList)
    {
        if ([aHistory.title isEqual:item.title]) {
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
    
    if (text && text.length>0) {
        self.searchField.text = text;
    //--------------
    //to be deleted
//        [self mock];
//        return;
    //--------------
        NSLog(@"search %@",text);
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        
        [[Search3DHttpManager sharedManager] request3DModelWithKey:text mane:_cbMANEFilter category:_cbCategoryFilter SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
            if ([SVProgressHUD isVisible]) {
                [SVProgressHUD dismiss];
            }
            Search3DResultModel *model = [Search3DResultModel objectWithKeyValues:dict];
            if (model) {
                self.resultList = [model.datalist copy];
            }else
            {
                self.resultList = [NSArray array];
            }
            if (_resultList.count) {
                showResult = YES;
            }else
                showResult = NO;
            [self refreshUI];
            
        } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
            if ([SVProgressHUD isVisible]) {
                [SVProgressHUD dismiss];
            }
            [ToastView popToast:@"查询失败，请稍后再试"];
        }];
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
    return [Search3DResultCell heightForCell];
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
        Search3DResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell"];
        if (!cell) {
            cell = [[Search3DResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resultCell"];
        }
        
        if (showResult) {
            Search3DResultItem * item = _resultList[row];
            [cell setDataModel:item];
        }else
        {
            
            Search3DResultItem * item = _historyList[row];
            [cell setDataModel:item];
            
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
        Search3DResultItem * item = (tableView == _resultTable)? _resultList[row] :_historyList[row];
        [self saveHistory:item];
        if (item.modelpath && [item.modelpath hasPrefix:@"http"])
        {
            WebViewController *vc = [[WebViewController alloc] init];
            [vc setUrl:[NSURL URLWithString:item.modelpath]];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    if ([_searchField isFirstResponder]) {
        [_searchField resignFirstResponder];
    }
    
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
