//
//  MyEventViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventViewController.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "QRSeparatorCell.h"
#import "MyEventItem.h"
#import "MyEventItemCell.h"
#import "MyEventDetailViewController.h"

@implementation MyEventViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
}

-(void) setupModel
{
    MyEventItem *item = [MyEventItem new];
    item.title = @"待办应急事件1";
    item.date= @"2016.8.31 22:10:10";
    item.xingzhi = @"严重";
    item.level = @"一级";
    item.place = @"北京市海淀西三旗建材城";
    item.finder = @"小明";
    
    MyEventItem *item1 = [MyEventItem new];
    item1.title = @"待办应急事件2";
    item1.date= @"2016.8.22 06:10:10";
    item1.xingzhi = @"严重";
    item1.level = @"一级";
    item1.place = @"北京市海淀西二旗软件园";
    item1.finder = @"小东";
    
    _modelList = @[item,item1];
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.title = @"待办应急事件";
    
    self.myEventTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myEventTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.myEventTableView.backgroundColor = [UIColor seperatorColor];
    self.myEventTableView.delegate = self;
    self.myEventTableView.dataSource = self;
    self.myEventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myEventTableView];
    
    [self.myEventTableView reloadData];
    
}


#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2 == 1) {
        
        return 8;
    }
    if (indexPath.row/2 <_modelList.count)
        return [MyEventItemCell heightForCell];
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelList.count*2-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    if (indexPath.row%2 == 1) {
        //sep cell
        QRSeparatorCell *cell = [self.myEventTableView dequeueReusableCellWithIdentifier:@"sepCell"];
        if (!cell) {
            cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"sepCell"];
            
        }
        return cell;
    }
    
    row = row/2;
    
    
    if (row < _modelList.count) {
        MyEventItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyEventItemCell"];
        if (!cell) {
            cell = [[MyEventItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyEventItemCell"];
        }
        cell.data = _modelList[row];
        return cell;
    }
    
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row%2 == 1) {
        return;
    }
    
    NSInteger row = indexPath.row /2;
    MyEventItem *item = _modelList[row];
    //todo push to new vc
    MyEventDetailViewController *vc = [[MyEventDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
