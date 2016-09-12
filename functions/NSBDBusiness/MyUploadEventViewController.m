//
//  MyUploadEventViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyUploadEventViewController.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "CenterSwitchView.h"
#import "QRSeparatorCell.h"
#import "MyLocalEventCell.h"
#import "MyUploadedEventCell.h"
#import "EventReportModel.h"
#import "EventModelPathManager.h"
#import "UITableView+EmptyView.h"
#import "EventReportViewController.h"

#import "TitleInputItem.h"


@interface MyUploadEventViewController()<CenterSwitchActionDelegate>
{
    NSInteger selectedIndex;
}
@end

@implementation MyUploadEventViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
}

-(void) setupModel
{
    EventReportModel *eventModel = [EventReportModel new];
    eventModel.eventName = [TitleInputItem itemWithTitle:@"事件名称" placeholder:@"请输入事件名称"];
    eventModel.eventType = [TitleDetailItem itemWithTitle:@"事件类型" detail:@"未填写"];
    eventModel.eventXingzhi = [TitleDetailItem itemWithTitle:@"事件性质" detail:@"未填写"];
    eventModel.level = [TitleDetailItem itemWithTitle:@"等级初判" detail:@"未填写"];
    eventModel.reason = [TitleDetailItem itemWithTitle:@"初步原因" detail:@"未填写"];
    
    
    eventModel.eventDate = [TitleDateItem itemWithTitle:@"事发时间"];
    eventModel.place = [TitleInputItem itemWithTitle:@"事发地点" placeholder:@"请输入地点名称"];
    
    eventModel.department = [TitleInputItem itemWithTitle:@"填报部门" placeholder:@"请输入部门名称"];
    eventModel.reporter = [TitleInputItem itemWithTitle:@"填报人员" placeholder:@"请输入人员名称"];
    eventModel.eventStatus = [TitleDetailItem itemWithTitle:@"事件情况" detail:@"未填写"];
    eventModel.eventPreprocess = [TitleDetailItem itemWithTitle:@"先期处置情况" detail:@"未填写"];
    eventModel.eventPic = [NSMutableArray arrayWithCapacity:6];
    eventModel.eventName.detail = @"test";
    
    _localEventModel = [EventModelPathManager getEventModels];

    _uploadedEventModel = @[eventModel];
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    CenterSwitchView *view = [[CenterSwitchView alloc] initWithFrame:CGRectMake(0, 0, CenetrSwitchWidth, CenetrSwitchHeight) andTitleArray:@[@"未上报",@"已上报"] andDelegate:self andSelectIndex:0];
    selectedIndex = 0;
    view.delegate = self;
    [self navigationItem].titleView = view;
    
    self.localEventTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.localEventTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.localEventTableView.backgroundColor = [UIColor seperatorColor];
    self.localEventTableView.delegate = self;
    self.localEventTableView.dataSource = self;
    self.localEventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.localEventTableView.hidden = (selectedIndex!=0);
    [self.view addSubview:self.localEventTableView];
    [self.localEventTableView reloadData];
    
    self.uploadedEventTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.uploadedEventTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.uploadedEventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.uploadedEventTableView.delegate = self;
    self.uploadedEventTableView.dataSource = self;
    self.uploadedEventTableView.backgroundColor = [UIColor seperatorColor];
    self.uploadedEventTableView.hidden = (selectedIndex==0);
    
    [self.view addSubview:self.uploadedEventTableView];
    [self.uploadedEventTableView reloadData];
}

#pragma mark --centerSwitch delegate
- (void)centerSwitchToIndex:(NSUInteger)index
{
    selectedIndex = index;
    self.uploadedEventTableView.hidden = (selectedIndex==0);
    self.localEventTableView.hidden = (selectedIndex!=0);
    NSLog([NSString stringWithFormat:@"change to index:%lu",(unsigned long)index]);
}

#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.localEventTableView)
    {
        NSInteger row = indexPath.row;
        if (row%2 == 1) {
            return 8;
        }

        return [MyLocalEventCell heightForCell];
    }else if(tableView == self.uploadedEventTableView)
    {
        NSInteger row = indexPath.row;
        if (row%2 == 1) {
            return 8;
        }
        return [MyUploadedEventCell heightForCell];
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.localEventTableView) {
        if (_localEventModel.count == 0)
        {
            [tableView setEmptyView];
        }else
        {
            [tableView removeEmptyView];
        }
        return _localEventModel.count*2-1;
    }else if(tableView == self.uploadedEventTableView)
    {
        if (_uploadedEventModel.count == 0)
        {
            [tableView setEmptyView];
        }else
        {
            [tableView removeEmptyView];
        }
        return _uploadedEventModel.count*2-1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    if (tableView == self.localEventTableView) {
        
        if (row%2 == 1) {
            QRSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separatorCell"];
            if (!cell) {
                cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"separatorCell"];
            }
            return cell;
        }else
        {
            row = row /2;
            if (row<_localEventModel.count) {
                MyLocalEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyLocalEventCell"];
                if (!cell) {
                    cell = [[MyLocalEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyLocalEventCell"];
                    cell.deleteCallback = ^(EventReportModel *model)
                    {
                        NSMutableArray *array = [_localEventModel mutableCopy];
                        [array removeObject:model];
                        _localEventModel = [array copy];
                        [tableView reloadData];
                        
                    };
                    cell.reportCallback = ^(EventReportModel *model)
                    {
                        //report first
                        @throw [NSException exceptionWithName:@"report first" reason:@"implement report first" userInfo:nil];
                        NSMutableArray *array = [_localEventModel mutableCopy];
                        [array removeObject:model];
                        _localEventModel = [array copy];
                        [tableView reloadData];
                    };
                }
                cell.data = _localEventModel[row];
                
                return cell;
            }
            
        }

    }else if(tableView == self.uploadedEventTableView)
    {
        if (row%2 == 1) {
            QRSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separatorCell"];
            if (!cell) {
                cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"separatorCell"];
            }
            return cell;
        }else
        {
            row = row /2;
            if (row<_uploadedEventModel.count) {
                MyUploadedEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyUploadedEventCell"];
                if (!cell) {
                    cell = [[MyUploadedEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyUploadedEventCell"];
                }
                cell.data = _uploadedEventModel[row];
                return cell;
            }
            
        }
    }
    
    return nil;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.localEventTableView) {
        if (indexPath.row %2 ==1) {
            return;
        }
        NSInteger row = indexPath.row/2;
        if (row <self.localEventModel.count) {
            EventReportViewController *vc = [[EventReportViewController alloc] initWithModel:_localEventModel[row]];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(tableView == self.uploadedEventTableView)
    {
        if (indexPath.row %2 ==1) {
            return;
        }
        NSInteger row = indexPath.row/2;
        if (row <self.uploadedEventModel.count) {
            EventReportViewController *vc = [[EventReportViewController alloc] initWithModel:_uploadedEventModel[row]];
            vc.readonly = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
