//
//  RouteViewController.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteViewController.h"
#import "RouteMapViewController.h"
#import "MapViewManager.h"

@interface RouteViewController()<UITextFieldDelegate>
{
    AGSPoint *startPoint;
    AGSPoint *endPoint;
    AGSPoint *currentPoint;
}
@property (strong, nonatomic) UITextField *tfStart;
@property (strong, nonatomic) UITextField *tfEnd;


@end

@implementation RouteViewController

-(instancetype) init
{
    self = [super init];
    if (self) {
        currentPoint = [MapViewManager sharedMapView].locationDisplay.location.point;
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tfStart = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 10, 20)];
    _tfStart.borderStyle = UITextBorderStyleRoundedRect;
    _tfStart.tintColor = [UIColor grayColor];
    [_tfStart setFont:[UIFont systemFontOfSize:15]];
    _tfStart.delegate = self;
    _tfStart.placeholder = @"输入起点";
    
    _tfEnd = [[UITextField alloc] initWithFrame:CGRectMake(10, 35, kScreenWidth - 10, 20)];
    _tfEnd.borderStyle = UITextBorderStyleRoundedRect;
    _tfEnd.tintColor = [UIColor grayColor];
    [_tfEnd setFont:[UIFont systemFontOfSize:15]];
    _tfEnd.delegate = self;
    _tfEnd.placeholder = @"输入终点";
    [self.view addSubview:_tfStart];
    [self.view addSubview:_tfEnd];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame= CGRectMake(50, 60, 100, 30);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField.placeholder isEqualToString:@"输入起点"])
    {
        [textField endEditing:YES];
        RouteMapViewController *vc = [[RouteMapViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        
    }
    [self.tabBarController setSelectedIndex:0];
    return NO;
}

#pragma mark - route-navi
-(void) navi
{
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


@end
