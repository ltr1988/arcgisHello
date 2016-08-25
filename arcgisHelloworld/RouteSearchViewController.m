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

#define MAXIMUM_HISTORYS 10

@interface RouteSearchViewController()<UITableViewDelegate, UITableViewDataSource,AGSQueryTaskDelegate>
{
    BOOL isStart;
    BOOL showResult;
    RouteMapViewController *mapVC;
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *historyList;
@property (nonatomic,strong) NSArray *resultList;
@property (nonatomic, strong) AGSQueryTask *queryTask;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLocation:) name:@"pickLocationNotification" object:nil];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupMembers];
    [self setupSubviews];
    [self addObservers];
    mapVC = [[RouteMapViewController alloc] init];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) setupMembers
{
    showResult = NO;
    _resultList = [NSArray array];
    _historyList = [[NSUserDefaults standardUserDefaults] objectForKey:@"search_history"];
    
    //self.queryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:WMSREST_FIND_URL,[MapViewManager IP]]]];
    self.queryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:@"http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/4"]];
    self.queryTask.delegate = self;
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
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.backgroundColor = [UIColor whiteColor];
    _table.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    _table.hidden = YES;
    [self.view addSubview:_table];
    
    CGFloat height = 55;
    [myLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(4);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_centerX).offset(-0.5);
        make.height.mas_equalTo(height);
    }];
    
    [pickInMap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(4);
        make.left.mas_equalTo(weakView.mas_centerX);
        make.right.mas_equalTo(weakView.mas_right);
        make.height.mas_equalTo(height);
    }];
    
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myLocation.mas_top).offset(4);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
        make.bottom.mas_equalTo(weakView.mas_bottom);
    }];


}

-(void) saveHistory:(RouteSearchResultItem*)item
{
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
    [[NSUserDefaults standardUserDefaults] setObject:_historyList forKey:@"search_history"];
}

-(void) searchWithText:(NSString *)text
{
    if (text && text.length>0) {
        NSLog(@"search %@",text);
        AGSQuery *params = [AGSQuery new];
        
        params.text = text;
        params.outFields = @[@"NAME"];
        params.outSpatialReference = [AGSSpatialReference wgs84SpatialReference];
        params.returnGeometry = YES;
        
        [_queryTask executeWithQuery:params];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    }
}

#pragma mark textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchWithText:textField.text];
    return YES;
}

-(void) actionSearch
{
    [self searchWithText:_searchField.text];
}

-(void) actionMyLocation:(id) sender
{
    [[[LocationManager alloc] init] startLocating];
}

-(void) actionPickInMap:(id) sender
{
    if (!mapVC) {
        mapVC = [RouteMapViewController new];
    }
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return showResult?_resultList.count:_historyList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row<0 || row>=  (showResult?_resultList.count:_historyList.count)) {
        return [UITableViewCell new];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resultCell"];
    }
    
    if (showResult) {
        RouteSearchResultItem * item = _resultList[row];
        cell.textLabel.text = item.title;
    }else
    {
        RouteSearchResultItem * item = _historyList[row];
        cell.textLabel.text = item.title;
    }

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RouteSearchResultItem * item = showResult? _resultList[row] :_historyList[row];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:item.location.x longitude:item.location.y];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification" object:nil userInfo:@{@"place":item.title,@"location":location}];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark queryTask delegate
- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation*)op didExecuteWithFeatureSetResult:(AGSFeatureSet *)featureSet
{
    //
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    
    NSLog(@"call back");
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:featureSet.features.count];
    for (AGSGraphic *feature in featureSet.features) {
        NSString *title = [feature attributeForKey:@"NAME"];
        RouteSearchResultItem *item = [[RouteSearchResultItem alloc] init];
        item.title = title;
        [array addObject:item];
    }
    _resultList = [array copy];
    if (_resultList.count) {
        showResult = YES;
    }
    [self.table reloadData];
}

- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation*)op didFailWithError:(NSError *)error{
    NSLog(@"call back");
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}
@end
