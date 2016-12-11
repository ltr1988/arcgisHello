//
//  MapSearchInfoViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MapSearchInfoViewController.h"
#import "LocationManager.h"
#import "UIColor+ThemeColor.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "AuthorizeManager.h"
#import "MapViewManager.h"
#import "CenterTitleCell.h"
#import "RouteSearchResultCell.h"
#import "NSDictionary+JSON.h"
#import "FacilityManager.h"
#import "FacilityInfoModel.h"
#import "FacilityInfoItem.h"

#import "FacilityInfoItem+AGSGraphics.h"

#define MAXIMUM_SEARCH_HISTORYS 10

#define USER_SEARCH_INFO_HISTORY [NSString stringWithFormat:@"search_info_history_%@",[[AuthorizeManager sharedInstance] userName]]
@interface MapSearchInfoViewController ()<UITableViewDelegate, UITableViewDataSource,AGSQueryTaskDelegate>
{
    BOOL showResult;
    LocationManager *locationMgr;
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *historyList;
@property (nonatomic,strong) NSArray *resultList;
@property (nonatomic, strong) AGSQueryTask *queryTask;
@end

@implementation MapSearchInfoViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupMembers];
    [self setupSubviews];
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
    
    NSArray *list = [[NSUserDefaults standardUserDefaults] objectForKey:USER_SEARCH_INFO_HISTORY];
    
    for(NSDictionary *json in list )
    {
        AGSGraphic *historyItem = [[AGSGraphic alloc] initWithJSON:json];
        [_historyList addObject:historyItem];
    }
    
    
    self.queryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:WMSREST_FIND_URL,[MapViewManager IP]]]];
    //self.queryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:@"http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/4"]];
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
    _searchField.placeholder = @"请输入设施名称";
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
        make.top.mas_equalTo(weakView.mas_top).offset(4);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
        make.bottom.mas_equalTo(weakView.mas_bottom);
    }];
    
    [_table reloadData];
    
}

-(void) saveHistory:(AGSGraphic*)item
{
    if (!item) {
        return;
    }
    BOOL DidHave = NO;
    NSInteger index = 0;
    
    for(AGSGraphic * aHistory in _historyList)
    {
        if ([[aHistory attributeForKey:@"NAME"] isEqual:[item attributeForKey:@"NAME"]]) {
            DidHave = YES;
            index = [_historyList indexOfObject:aHistory];
            break;
        }
    }
    if (!DidHave)
    {
        if ([_historyList count] >= MAXIMUM_SEARCH_HISTORYS) {
            [_historyList removeLastObject];
        }
        
        [_historyList insertObject:item atIndex:0];
    }
    else
    {
        [_historyList removeObjectAtIndex:index];
        
        [_historyList insertObject: item atIndex:0];
    }
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for(AGSGraphic* aHistory in _historyList)
    {
        NSDictionary *json = [aHistory encodeToJSON];
        [tempArray addObject:json];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:USER_SEARCH_INFO_HISTORY];
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
                    [tempArray addObject: [item graphics]];
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

- (void)cleanHistory
{
    [_historyList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:_historyList forKey:USER_SEARCH_INFO_HISTORY];
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
            AGSGraphic * item = _resultList[row];
            [cell setTitle:[item attributeForKey:@"NAME"]];
        }else
        {
            
            AGSGraphic * item = _historyList[row];
            [cell setTitle:[item attributeForKey:@"NAME"]];
            
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
        AGSGraphic * item = showResult? _resultList[row] :_historyList[row];
        [self saveHistory:item];
        //call back
        if (self.graphicSelectedCallback)
        {
            NSDictionary *info = @{@"graphics":item};
            self.graphicSelectedCallback(info);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
