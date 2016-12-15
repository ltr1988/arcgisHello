//
//  RouteSearchViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/22.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteSearchViewController.h"
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
#import "NSDictionary+JSON.h"
#import "FacilityManager.h"
#import "FacilityInfoModel.h"
#import "FacilityInfoItem.h"

#import "FacilityInfoItem+AGSGraphics.h"

#define MAXIMUM_HISTORYS 10

#define USER_SEARCH_HISTORY [NSString stringWithFormat:@"search_history_%@",[[AuthorizeManager sharedInstance] userName]]

@interface RouteSearchViewController()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL isStart;
    BOOL showResult;
    RouteMapViewController *mapVC;
    LocationManager *locationMgr;
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *historyList;
@property (nonatomic,strong) NSArray *resultList;
@end


@implementation RouteSearchViewController


-(instancetype) initWithPointFlag:(BOOL) isStartPoint
{
    self = [super init];
    if (self) {
        isStart = isStartPoint;
    }
    return self;
}

-(void) receiveLocation:(NSNotification *) noti
{
    if(noti.userInfo[@"error"] == nil)
        [self.navigationController popViewControllerAnimated:NO];
    else
        [ToastView popToast:@"解析位置失败"];
}

-(void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLocation:) name:@"pickMyLocationNotification" object:nil];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupMembers];
    [self setupSubviews];
    [self addObservers];
    mapVC = [[RouteMapViewController alloc] initWithPopNumber:2];
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

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) setupMembers
{
    showResult = NO;
    _resultList = [NSArray array];
    _historyList = [NSMutableArray array];
    
    NSArray *list = [[NSUserDefaults standardUserDefaults] objectForKey:USER_SEARCH_HISTORY];
    
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
    _searchField.placeholder = isStart?@"请输入起点":@"请输入终点";
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
    
    //我的位置 & 地图选点
    
    UIButton * myLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [myLocation setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
    [myLocation setTitle:@"我的位置" forState:UIControlStateNormal];
    [myLocation.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [myLocation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myLocation addTarget:self action:@selector(actionMyLocation:) forControlEvents:UIControlEventTouchUpInside];
    myLocation.backgroundColor = [UIColor whiteColor];
    [weakView addSubview:myLocation];
    
    UIButton * pickInMap = [UIButton buttonWithType:UIButtonTypeCustom];
    [pickInMap setImage:[UIImage imageNamed:@"mappoint"] forState:UIControlStateNormal];
    [pickInMap setTitle:@"地图选点" forState:UIControlStateNormal];
    [pickInMap.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [pickInMap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pickInMap addTarget:self action:@selector(actionPickInMap:) forControlEvents:UIControlEventTouchUpInside];
    pickInMap.backgroundColor = [UIColor whiteColor];
    [weakView addSubview:pickInMap];
    
    
    UIView *vline = [UIView new];
    vline.backgroundColor = [UIColor borderColor];
    [weakView addSubview:vline];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSelectionStyleNone;
    _table.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_table];
    
    CGFloat height = 55;
    [myLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(4);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_centerX);
        make.height.mas_equalTo(height);
    }];
    
    [vline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(myLocation.mas_centerY);
        make.height.mas_equalTo(height-4);
        make.width.mas_equalTo(0.5);
        make.right.mas_equalTo(weakView.mas_centerX);
    }];
    
    [pickInMap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(4);
        make.left.mas_equalTo(weakView.mas_centerX);
        make.right.mas_equalTo(weakView.mas_right);
        make.height.mas_equalTo(height);
    }];
    
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myLocation.mas_bottom).offset(4);
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
    
    [[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:USER_SEARCH_HISTORY];
}

-(void) searchWithText:(NSString *)text
{
    
    if (text && text.length>0) {
        NSLog(@"search %@",text);
        @weakify(self)
        [[FacilityManager sharedInstance] requestQueryFacilityWithName:text SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
            NSLog(@"call back");
            if ([SVProgressHUD isVisible]) {
                [SVProgressHUD dismiss];
            }
            @strongify(self)
            FacilityInfoModel * model = [FacilityInfoModel objectWithKeyValues:dict];
            if (model.success) {
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSArray *info in model.datalist) {
                    FacilityInfoItem *item = [[FacilityInfoItem alloc] initWithArray:info];
                    AGSGraphic *feature = [item graphics];
                    NSString *title = [feature attributeForKey:@"NAME"];
                    RouteSearchResultItem *ritem = [[RouteSearchResultItem alloc] init];
                    AGSPoint *point = (AGSPoint *)feature.geometry;
                    ritem.location = CGPointMake(point.x, point.y);
                    ritem.title = title;
                    
                    [tempArray addObject:ritem];
                }
                
                _resultList = [tempArray copy];
                if (_resultList.count) {
                    showResult = YES;
                }else
                    showResult = NO;
                [self.table reloadData];
                
                
            }else if (model.status == HttpResultInvalidUser)
            {
                [ToastView popToast:@"您的帐号在其他地方登录"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                [ToastView popToast:@"获取设施信息失败,请稍候再试"];
            }
        } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"call back");
            if ([SVProgressHUD isVisible]) {
                [SVProgressHUD dismiss];
            }
            [ToastView popToast:@"获取设施信息失败,请稍候再试"];
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
    [self.table reloadData];
    return YES;
}

-(void) actionSearch
{
    [self searchWithText:_searchField.text];
}

-(void) actionMyLocation:(id) sender
{
    locationMgr = [[LocationManager alloc] init];
    [locationMgr startLocating];
}

-(void) actionPickInMap:(id) sender
{
    if (!mapVC) {
        mapVC = [[RouteMapViewController alloc] initWithPopNumber:2];
    }
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)cleanHistory
{
    [_historyList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:_historyList forKey:USER_SEARCH_HISTORY];
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
        CLLocation *location = [[CLLocation alloc] initWithLatitude:item.location.y longitude:item.location.x];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification" object:nil userInfo:@{@"place":item.title,@"location":location}];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
