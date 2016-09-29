//
//  LiveDataNormalDataViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LiveDataNormalDataViewController.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "ThreeColumnCell.h"
#import "ThreeColumnItem.h"
#import "ThreeColumnView.h"
#import "MJRefresh.h"

@interface LiveDataNormalDataViewController()
{
    UILabel *lbUpdateTime;
}
@property (nonatomic,strong) UITableView *liveDataTableView;
@property (nonatomic,strong) NSString *updateTime;
@end


@implementation LiveDataNormalDataViewController
@synthesize modelList = _modelList;

-(instancetype) initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    
}

-(void) setupModel
{

}

-(void) setupSubviews
{
    UIButton *btnLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    btnLocation.backgroundColor = [UIColor clearColor];
    [btnLocation setImage:[UIImage imageNamed:@"RedPushpin"] forState:UIControlStateNormal];
    [btnLocation addTarget:self action:@selector(actionLocate:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnLocation];
    
    _liveDataTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _liveDataTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _liveDataTableView.backgroundColor = [UIColor seperatorColor];
    _liveDataTableView.delegate = self;
    _liveDataTableView.dataSource = self;
    _liveDataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _liveDataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(actionRefreshData)];
    UIView *header = [self headerView];
    if (header) {
        _liveDataTableView.tableHeaderView = header;
    }

    [self.view addSubview:_liveDataTableView];
    
    [self actionRefreshData];
    
}

-(void) reloadTableView
{
    [self refreshHeader];
    [_liveDataTableView reloadData];
}

-(void) refreshHeader
{
    if (lbUpdateTime) {
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        lbUpdateTime.text = [formater stringFromDate:[NSDate date]];
    }
}


-(void) actionLocate:(id) sender
{
    //do something?
}


//下拉刷新
-(void) actionRefreshData
{
    //http request and callback
    [self setupModel];
    
    [self reloadTableView];
    
    [_liveDataTableView.mj_header endRefreshing];
}

-(UIView *) headerView
{
    UIView *header = [UIView new];
    header.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
    header.backgroundColor = [UIColor seperatorColor];
   
    UIView *contentView = [UIView new];
    contentView.frame = CGRectMake(0, 10, self.view.bounds.size.width, 50);
    contentView.backgroundColor = [UIColor whiteColor];
    [header addSubview:contentView];
    
    UILabel *label = [UILabel new];
    label = [UILabel new];
    label.font = UI_FONT(16);
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"刷新时间";
    [label sizeToFit];
    [contentView addSubview:label];
    
    
    lbUpdateTime = [UILabel new];
    lbUpdateTime.font = UI_FONT(16);
    lbUpdateTime.textColor = [UIColor blackColor];
    lbUpdateTime.backgroundColor = [UIColor clearColor];
    lbUpdateTime.textAlignment = NSTextAlignmentRight;
    lbUpdateTime.text = @"刷新时间";
    [contentView addSubview:lbUpdateTime];


    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
        make.left.offset(16);
    }];
    
    [lbUpdateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
        make.right.offset(-16);
        make.left.mas_equalTo(label.mas_right).offset(10);
    }];
    return header;
}

#pragma mark --tableview delegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    ThreeColumnView *view = [[ThreeColumnView alloc] initWithFrame:CGRectMake(0, 0, _liveDataTableView.bounds.size.width, 50)];
    [view setColumnColor:[UIColor grayColor]];
    [view setFont:UI_FONT(12)];
    
    ThreeColumnColorItem *item = [ThreeColumnColorItem new];
    item.firstColumnText = @"站点";
    item.thirdColumnText = @"实时水位";

    [view setData:item];
    
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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

