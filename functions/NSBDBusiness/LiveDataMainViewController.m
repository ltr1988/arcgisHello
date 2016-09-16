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

@interface LiveDataMainViewController()
@property (nonatomic,strong) UITableView *liveDataTableView;

@property (nonatomic,strong) NSArray *modelList;
@end

@implementation LiveDataMainViewController

-(void) viewDidLoad
{
    [self setupModel];
    [self setupSubviews];
    
}


-(void) setupModel
{
    TitleDetailItem *item1 = [TitleDetailItem itemWithTitle:@"实时数据1" detail:@"2015-01-22 11:22:09"];
    TitleDetailItem *item2 = [TitleDetailItem itemWithTitle:@"实时数据2" detail:@"2015-01-22 12:22:09"];
    TitleDetailItem *item3 = [TitleDetailItem itemWithTitle:@"实时数据3" detail:@"2015-01-22 13:22:09"];
    TitleDetailItem *item4 = [TitleDetailItem itemWithTitle:@"实时数据4" detail:@"2015-01-22 14:22:09"];
    
    _modelList = @[item1,item2,item3,item4];
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
    //todo push to new vc
    
    //[self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
