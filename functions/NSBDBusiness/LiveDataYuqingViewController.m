//
//  LiveDataYuqingViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LiveDataYuqingViewController.h"
#import "UIColor+ThemeColor.h"
#import "ThreeColumnCell.h"
#import "ThreeColumnItem.h"
#import "ThreeColumnView.h"
#import "LiveDataYuqingHeaderView.h"

@interface LiveDataYuqingViewController()
@property (nonatomic,strong) UITableView *liveDataTableView;

@property (nonatomic,strong) NSArray *modelList;
@end


@implementation LiveDataYuqingViewController
-(void) viewDidLoad
{
    [self setupModel];
    [self setupSubviews];
    
}


-(void) setupModel
{
    ThreeColumnColorItem *item = [[ThreeColumnColorItem alloc] init];
    item.firstColumnText = @"东干渠";
    item.secondColumnText = @"朝阳";
    item.thirdColumnText = @"0.4";
    item.thirdColumnColor = [UIColor themeLightBlueColor];
    
    ThreeColumnColorItem *item1 = [[ThreeColumnColorItem alloc] init];
    item1.firstColumnText = @"南干渠";
    item1.secondColumnText = @"大兴";
    item1.thirdColumnText = @"0.7";
    item1.thirdColumnColor = [UIColor themeLightBlueColor];
    
    ThreeColumnColorItem *item2 = [[ThreeColumnColorItem alloc] init];
    item2.firstColumnText = @"大宁";
    item2.secondColumnText = @"房山";
    item2.thirdColumnText = @"0.5";
    item2.thirdColumnColor = [UIColor themeLightBlueColor];
    
    _modelList = @[item,item1,item2];
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
    _liveDataTableView.tableHeaderView = [self headerView];
    
    [self.view addSubview:_liveDataTableView];
    
    [_liveDataTableView reloadData];
}

-(UIView *) headerView
{
    UIView *header = [UIView new];
    header.frame = CGRectMake(0, 0, self.view.bounds.size.width, [LiveDataYuqingHeaderView heightForView] + 10);
    header.backgroundColor = [UIColor seperatorColor];
    
    LiveDataYuqingHeaderView * view = [[LiveDataYuqingHeaderView alloc] initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, [LiveDataYuqingHeaderView heightForView])];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    view.startDate = @"abc";
    view.endDate = @"def";
    [header addSubview:view];
    return header;
}

#pragma mark --tableview delegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    ThreeColumnView *view = [[ThreeColumnView alloc] initWithFrame:CGRectMake(0, 0, _liveDataTableView.bounds.size.width, 50)];
    
    ThreeColumnItem *item = [ThreeColumnItem new];
    item.firstColumnText = @"站点";
    item.secondColumnText = @"行政区";
    item.thirdColumnText = @"累计雨量(毫米)";
    
    [view setData:item];
    
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    ThreeColumnCell *cell = [self.liveDataTableView dequeueReusableCellWithIdentifier:@"ThreeColumnCell"];
    if (!cell) {
        cell = [[ThreeColumnCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"ThreeColumnCell"];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
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
    ThreeColumnItem *item = _modelList[row];
    
    
    UIViewController *vc = nil;
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
