//
//  LiveDataMainViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LiveDataMainViewController.h"
#import "TitleDetailCell.h"
#import "TitleDetailItem.h"
#import "UIColor+ThemeColor.h"

#import "LiveDataYuqingViewController.h"
#import "LiveDataNormalDataViewController.h"

@interface LiveDataMainViewController()
@property (nonatomic,strong) UITableView *liveDataTableView;

@property (nonatomic,strong) NSArray *modelList;
@end


NSString
*const sYUQING = @"实时雨情",
*const sSHUIWEI = @"实时水位",
*const sSHUIKU= @"水库水情",
*const sLIULIANG = @"实时流量",
*const sSHUIZHI = @"水质数据",
*const sGONGCHENG = @"工程安全";

@implementation LiveDataMainViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
    
}


-(void) setupModel
{
    TitleDetailItem *item1 = [TitleDetailItem itemWithTitle:sYUQING detail:@"2015-01-22 11:22:09"];
    TitleDetailItem *item2 = [TitleDetailItem itemWithTitle:sSHUIWEI detail:@"2015-01-22 12:22:09"];
    TitleDetailItem *item3 = [TitleDetailItem itemWithTitle:sSHUIKU detail:@"2015-01-22 13:22:09"];
    TitleDetailItem *item4 = [TitleDetailItem itemWithTitle:sLIULIANG detail:@"2015-01-22 14:22:09"];
    TitleDetailItem *item5 = [TitleDetailItem itemWithTitle:sSHUIZHI detail:@"2015-01-22 14:22:09"];
    TitleDetailItem *item6 = [TitleDetailItem itemWithTitle:sGONGCHENG detail:@"2015-01-22 14:22:09"];
    _modelList = @[item1,item2,item3,item4,item5,item6];
}

-(void) setupSubviews
{
    self.title = @"实时数据";
    _liveDataTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _liveDataTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _liveDataTableView.backgroundColor = [UIColor seperatorColor];
    _liveDataTableView.delegate = self;
    _liveDataTableView.dataSource = self;
    _liveDataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_liveDataTableView];
    
    [_liveDataTableView reloadData];
}


#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    TitleDetailCell *cell = [self.liveDataTableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
    if (!cell) {
        cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"TitleDetailCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    if (row < _modelList.count) {
        cell.data = _modelList[row];
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    TitleDetailItem *item = _modelList[row];
    
    
    UIViewController *vc = nil;
    if ([item.title isEqualToString: sYUQING]) {
        vc = [[LiveDataYuqingViewController alloc] init];
    }else if ([item.title isEqualToString: sSHUIWEI])
    {
        vc = [[LiveDataNormalDataViewController alloc] initWithTitle:@"实时水位"];
    }else if ([item.title isEqualToString: sSHUIKU])
    {
        
    }else if ([item.title isEqualToString: sLIULIANG])
    {
        
    }else if ([item.title isEqualToString: sSHUIZHI])
    {
        
    }else if ([item.title isEqualToString: sGONGCHENG])
    {
        
    }
    //todo push to new vc
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
