//
//  RouteViewController.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteStartEndPickerController.h"
#import "MapViewManager.h"
#import "NSString+Location.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "RouteSearchViewController.h"

@interface RouteStartEndPickerController()<UITextFieldDelegate>
{
    AGSPoint *startPoint;
    AGSPoint *endPoint;

    RouteSearchViewController *searchVC;
    BOOL pickStart;
}
@property (strong, nonatomic) UITextField *tfStart;
@property (strong, nonatomic) UITextField *tfEnd;


@end

@implementation RouteStartEndPickerController


-(void) setupSubviews
{
    self.title = @"路线";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"导航" style:UIBarButtonItemStylePlain target:self action:@selector(actionNavi)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    __weak UIView *weakView = self.view;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * contentView = [UIView new];
    contentView.backgroundColor = [UIColor themeLightBlueColor];
    [self.view addSubview:contentView];
    
    UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchButton setImage:[UIImage imageNamed:@"icon_change"] forState:UIControlStateNormal];
    [switchButton addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchButton];
    
    
    
    _tfStart = [[UITextField alloc] init];
    _tfStart.textColor = [UIColor whiteColor];
    _tfStart.tintColor = [UIColor whiteColor];
    [_tfStart setFont:[UIFont systemFontOfSize:15]];
    _tfStart.delegate = self;
    _tfStart.placeholder = @"输入起点";
    [_tfStart setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIView * hLine = [UIView new];
    hLine.backgroundColor = [UIColor borderColor];
    
    _tfEnd = [[UITextField alloc] init];
    _tfEnd.textColor = [UIColor whiteColor];
    _tfEnd.tintColor = [UIColor whiteColor];
    [_tfEnd setFont:[UIFont systemFontOfSize:15]];
    _tfEnd.delegate = self;
    _tfEnd.placeholder = @"输入终点";
    [_tfEnd setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.view addSubview:hLine];
    [self.view addSubview:_tfStart];
    [self.view addSubview:_tfEnd];

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.width.mas_equalTo(weakView.mas_width);
        make.height.mas_equalTo(104);
        make.left.mas_equalTo(weakView.mas_left);
    }];
    [switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(hLine.mas_top);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(weakView.mas_left).offset(16);
    }];
    
    [_tfStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(4);
        make.right.mas_equalTo(weakView.mas_right);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(switchButton.mas_right).offset(16);
    }];
    
    [_tfEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLine.mas_bottom).offset(4);
        make.right.mas_equalTo(weakView.mas_right);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(switchButton.mas_right).offset(16);
    }];
    
    
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tfStart.mas_bottom).offset(8);
        make.right.mas_equalTo(weakView.mas_right);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(switchButton.mas_right).offset(16);
    }];
}

-(void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionPickLocation:) name:@"pickLocationNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionPickLocation:) name:@"pickMyLocationNotification" object:nil];
    
}

-(void) setupMembers
{
    pickStart = YES;
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupMembers];
    [self setupSubviews];
    [self addObservers];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField endEditing:YES];
    
    if (_tfEnd == textField) {
        pickStart = NO;
    }else
    {
        pickStart = YES;
    }
    
    
    searchVC = [[RouteSearchViewController alloc] initWithPointFlag:pickStart];
    [self.navigationController pushViewController:searchVC animated:YES];
    
    return NO;
}

#pragma mark - route-navi
-(void) actionNavi
{
    if (!startPoint || !endPoint) {
        return;
    }
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"];
    
    BOOL hasBaiduMap = NO;
    BOOL hasGaodeMap = NO;
    
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]){
        hasBaiduMap = YES;
    }
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
        hasGaodeMap = YES;
    }
    
    
    float currentLat,currentLon,_shopLat,_shopLon;
    
    currentLat = startPoint.y;
    currentLon = startPoint.x;
    
    _shopLat = endPoint.y;
    _shopLon = endPoint.x;
    
    if (hasBaiduMap)
    {
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:终点&mode=driving",currentLat, currentLon,_shopLat,_shopLon] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    }
    else if (hasGaodeMap)
    {
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=1&m=0&t=0",app_Name, currentLat, currentLon, @"我的起点" , _shopLat, _shopLon,@"我的终点"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    }
}

#pragma mark -- notification
-(void) actionPickLocation:(NSNotification *)notification
{
    CLLocation *location = notification.userInfo[@"location"];
    NSString *place = notification.userInfo[@"place"];
    AGSPoint * point = [AGSPoint pointWithLocation:location];
    if (point) {
        if (pickStart) {
            startPoint = point;
            _tfStart.text = place?:[NSString stringWithLocationAGSPoint:point];
        }else{
            endPoint = point;
            _tfEnd.text = place?:[NSString stringWithLocationAGSPoint:point];
        }
    }
    
    self.navigationItem.rightBarButtonItem.enabled = startPoint && endPoint;
    if (startPoint && endPoint) {
        [self actionNavi];
    }
}




-(void) actionSwitch:(id) sender
{
    AGSPoint* point =  startPoint;
    startPoint = endPoint;
    endPoint = point;
    
    NSString *tmpStr = [_tfStart.text copy];
    _tfStart.text = _tfEnd.text;
    _tfEnd.text = tmpStr;
}
@end
