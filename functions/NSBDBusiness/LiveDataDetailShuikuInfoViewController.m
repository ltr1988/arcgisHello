//
//  LiveDataDetailShuikuInfoViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/30.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LiveDataDetailShuikuInfoViewController.h"
#import "TitleDetailCell.h"
#import "TitleDetailItem.h"
#import "UIColor+ThemeColor.h"

@interface LiveDataDetailShuikuInfoViewController ()
@property (nonatomic,strong) UITableView *detailTableView;

@property (nonatomic,strong) NSArray *modelList;
@end

@implementation LiveDataDetailShuikuInfoViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
    
}

-(void) setupModel
{
    TitleDetailItem *item1 = [TitleDetailItem itemWithTitle:@"a" detail:@"22"];
    TitleDetailItem *item2 = [TitleDetailItem itemWithTitle:@"b" detail:@"22"];
    TitleDetailItem *item3 = [TitleDetailItem itemWithTitle:@"c" detail:@"33"];
    TitleDetailItem *item4 = [TitleDetailItem itemWithTitle:@"d" detail:@"39"];
    TitleDetailItem *item5 = [TitleDetailItem itemWithTitle:@"e" detail:@"29"];
    TitleDetailItem *item6 = [TitleDetailItem itemWithTitle:@"f" detail:@"29"];
    _modelList = @[@[item1],
                   @[item2,item3],
                   @[item4],
                   @[item5,item6]
                ];
}

-(void) setupSubviews
{
    self.title = @"实时数据";
    _detailTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _detailTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _detailTableView.backgroundColor = [UIColor seperatorColor];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_detailTableView];
    
    [_detailTableView reloadData];
}


#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * data = _modelList[section];
    return data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    TitleDetailCell *cell = [self.detailTableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
    if (!cell) {
        cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"TitleDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (section < _modelList.count) {
        NSArray *data = _modelList[section];
        if (row < data.count) {
            cell.data = data[row];
        }
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelList.count;
}

@end
