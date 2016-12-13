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

#define MAXIMUM_HISTORYS 10

#define USER_SEARCH_3D_HISTORY [NSString stringWithFormat:@"search_3d_history_%@",[[AuthorizeManager sharedInstance] userName]]

@interface Home3DViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    Home3DDataSource *dataSource;
    BOOL showResult;
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UITextField *searchField;
@property (nonatomic,strong) NSMutableArray *historyList;
@property (nonatomic,strong) NSArray *resultList;
@property (nonatomic,strong) Search3DHeaderModel *headerModel;

@end

@implementation Home3DViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupMembers];
    [self setupSubviews];
    [self requestHeaderData];
}

-(void) requestHeaderData
{
    if (_headerModel) {
        [self refreshHeader];
    }
}

-(void) refreshHeader
{
    if (_headerModel.datalist.count==0 && _headerModel.datalist2.count==0)
        _table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        @weakify(self)
        Search3DWordsLayoutView *view1 = [[Search3DWordsLayoutView alloc] initWithCallback:^(NSInteger selectedIndex) {
            @strongify(self)
            Search3DHeaderItem* item = self.headerModel.datalist[selectedIndex];
            [self searchWithText:item.keyword];
        }];
        Search3DWordsLayoutView *view2 = [[Search3DWordsLayoutView alloc] initWithCallback:^(NSInteger selectedIndex) {
            @strongify(self)
            Search3DHeaderItem* item = self.headerModel.datalist2[selectedIndex];
            [self searchWithText:item.keyword];
        }];
        
        [view addSubview:view1];
        [view addSubview:view2];
        
        view1.words = _headerModel.datalist;
        view2.words = _headerModel.datalist2;
        
        [view1 layOut];
        [view2 layOut];
        
        
    }
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
    [self.table reloadData];
}

-(void) setupMembers
{
    dataSource = [[Home3DDataSource alloc] init];
    
    _headerModel = [dataSource requestCache];
    showResult = NO;
    _resultList = [NSArray array];
    _historyList = [NSMutableArray array];
    
    NSArray *list = [[NSUserDefaults standardUserDefaults] objectForKey:USER_SEARCH_3D_HISTORY];
    
    for(id aHistory in list )
    {
        RouteSearchResultItem *historyItem = [NSKeyedUnarchiver unarchiveObjectWithData:aHistory];
        [_historyList addObject:historyItem];
    }
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
    
    [self.view addSubview:_table];
    
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
        make.bottom.mas_equalTo(weakView.mas_bottom);
    }];
    
    [_table reloadData];
    
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
    [self.table reloadData];
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
    [self.table reloadData];
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = showResult?_resultList.count:(_historyList.count==0?0:_historyList.count+1);
    tableView.hidden = count==0;
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
    
    if (!showResult && indexPath.row == (_historyList.count)) {
        [self cleanHistory];
    }else
    {
        RouteSearchResultItem * item = showResult? _resultList[row] :_historyList[row];
        [self saveHistory:item];
        //go to 3d web site
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark onGetResult
- (void) onGetResult:(NSDictionary *)result
{
    //
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    
    
    
    NSLog(@"call back");
    NSMutableArray *array = [NSMutableArray array];
    _resultList = [array copy];
    if (_resultList.count) {
        showResult = YES;
    }else
        showResult = NO;
    [self.table reloadData];
}

@end
