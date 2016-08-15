//
//  RouteViewController.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteStartEndPickerController.h"
#import "RouteMapViewController.h"
#import "MapViewManager.h"
#import "NSString+Location.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+BorderColor.h"

@interface RouteStartEndPickerController()<UITextFieldDelegate>
{
    AGSPoint *startPoint;
    AGSPoint *endPoint;
    AGSPoint *currentPoint;
    
    RouteMapViewController *mapVC;
    BOOL pickStart;
}
@property (strong, nonatomic) UITextField *tfStart;
@property (strong, nonatomic) UITextField *tfEnd;


@end

@implementation RouteStartEndPickerController

-(instancetype) init
{
    self = [super init];
    if (self) {
        currentPoint = [MapViewManager sharedMapView].locationDisplay.location.point;
    }
    return self;
}

-(void) setupSubviews
{
    __weak UIView *weakView = self.view;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tfStart = [[UITextField alloc] init];
    _tfStart.borderStyle = UITextBorderStyleRoundedRect;
    _tfStart.tintColor = [UIColor grayColor];
    [_tfStart setFont:[UIFont systemFontOfSize:15]];
    _tfStart.delegate = self;
    _tfStart.placeholder = @"输入起点";
    
    UIView * hLine = [UIView new];
    hLine.backgroundColor = [UIColor borderColor];
    
    _tfEnd = [[UITextField alloc] init];
    _tfEnd.borderStyle = UITextBorderStyleRoundedRect;
    _tfEnd.tintColor = [UIColor grayColor];
    [_tfEnd setFont:[UIFont systemFontOfSize:15]];
    _tfEnd.delegate = self;
    _tfEnd.placeholder = @"输入终点";
    
    
    [self.view addSubview:hLine];
    [self.view addSubview:_tfStart];
    [self.view addSubview:_tfEnd];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"导航" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
    [_tfStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(8);
        make.right.mas_equalTo(weakView.mas_centerX);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(weakView.mas_left).offset(16);
    }];
    
    [_tfEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLine.mas_bottom).offset(8);
        make.right.mas_equalTo(weakView.mas_centerX);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(weakView.mas_left).offset(16);
    }];
    
    
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tfStart.mas_bottom).offset(8);
        make.right.mas_equalTo(weakView.mas_centerX);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(weakView.mas_left).offset(16);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tfEnd.mas_bottom).offset(8);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(weakView.mas_left).offset(16);
    }];
}

-(void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionPickLocation:) name:@"pickLocationNotification" object:mapVC];
}

-(void) setupMembers
{
    mapVC = [[RouteMapViewController alloc] init];
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
    
    
    [self.navigationController pushViewController:mapVC animated:YES];
    
    return NO;
}

#pragma mark - route-navi
-(void) navi
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
    
    currentLat = startPoint.x;
    currentLon = startPoint.y;
    
    _shopLat = endPoint.x;
    _shopLon = endPoint.y;
    
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
    AGSPoint *point = notification.userInfo[@"location"];
    if (point) {
        if (pickStart) {
            startPoint = point;
            _tfStart.text = [NSString stringWithLocationAGSPoint:point];
        }else{
            endPoint = point;
            _tfEnd.text = [NSString stringWithLocationAGSPoint:point];
        }
    }
    
}

@end