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

@interface RouteSearchViewController()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL isStart;
    
    RouteMapViewController *mapVC;
}
@property (nonatomic,strong) UITableView *table;

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

-(void) sendLocationNotification:(AGSPoint *)location
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification"
                                                        object:nil
                                                      userInfo:@{@"location":location}];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    mapVC = [[RouteMapViewController alloc] init];
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
    
    weakView.backgroundColor = [UIColor lightGrayColor];
    
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
    
    [myLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(4);
        make.left.mas_equalTo(weakView.mas_left).offset(8);
        make.right.mas_equalTo(weakView.mas_centerX).offset(-0.5);
        make.height.mas_equalTo(40);
    }];
    
    [pickInMap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(4);
        make.left.mas_equalTo(weakView.mas_centerX).offset(0.5);
        make.right.mas_equalTo(weakView.mas_right).offset(-8);
        make.height.mas_equalTo(40);
    }];
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.backgroundColor = [UIColor whiteColor];
    _table.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    
    //[self.view addSubview:_table];

}

-(void) searchWithText:(NSString *)text
{
    if (text && text.length>0) {
        NSLog(@"search");
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
    [[LocationManager shared] startLocating];
    
    
    
//    
//    AGSLocation *location = [MapViewManager sharedMapView].locationDisplay.location;
//    AGSPoint * point;
//    if (location) {
//        point = location.point;
//    }else
//    {
//        
//    }
//    
//    if (point)
//    {
//        NSDictionary *userInfo = @{@"location":point};
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"pickLocationNotification" object:self userInfo:userInfo];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

-(void) actionPickInMap:(id) sender
{
    
}



@end
