//
//  MyEventDetailViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventDetailViewController.h"
#import "MyEventDetailViewController+pickMedia.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "CenterSwitchView.h"
#import "EventMediaPickerView.h"
#import "FeedbackModel.h"
#import "TitleDetailTextItem.h"
#import "TitleDetailItem.h"
#import "MyEventHistoryCell.h"
#import "MyEventHistoryItem.h"

#import "TitleDetailCell.h"
#import "QRSeparatorCell.h"

@interface MyEventDetailViewController()<CenterSwitchActionDelegate>
{
    NSInteger selectedIndex;
}
@end

@implementation MyEventDetailViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
}

-(void) setupModel
{
    //model for feedback
    _feedbackModel = [FeedbackModel new];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
    
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    _feedbackModel.date = [TitleDetailItem itemWithTitle:@"反馈时间" detail:[formater stringFromDate:[NSDate date]]];
    _feedbackModel.detail = [TitleDetailTextItem itemWithTitle:@"进展描述" detail:@"未填写" text:@""];
    _feedbackModel.images = [NSMutableArray arrayWithCapacity:6];
    
    //model for history
    MyEventHistoryItem *item1 =[[MyEventHistoryItem alloc] init];
    item1.title = @"我呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜";
    item1.date = @"2016-1-2";
    item1.place = @"北京";
    item1.finder = @"勿忘我";
    item1.images =@[@"http://tva2.sinaimg.cn/crop.0.0.180.180.180/65de1936jw1e8qgp5bmzyj2050050aa8.jpg"];
    
    MyEventHistoryItem *item2 =[[MyEventHistoryItem alloc] init];
    item2.title = @"我呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜";
    item2.date = @"2016-1-2 13:00:01";
    item2.place = @"北京";
    item2.finder = @"lls";
    _historyModel = @[item1,item2];
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    CenterSwitchView *view = [[CenterSwitchView alloc] initWithFrame:CGRectMake(0, 0, CenetrSwitchWidth, CenetrSwitchHeight) andTitleArray:@[@"当前进展",@"历史进展"] andDelegate:self andSelectIndex:0];
    selectedIndex = 0;
    view.delegate = self;
    [self navigationItem].titleView = view;
    
    self.feedbackTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.feedbackTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.feedbackTableView.backgroundColor = [UIColor whiteColor];
    self.feedbackTableView.delegate = self;
    self.feedbackTableView.dataSource = self;
    self.feedbackTableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    
    self.feedbackTableView.tableFooterView = [self footerView];
    self.feedbackTableView.hidden = (selectedIndex!=0);
    [self.view addSubview:self.feedbackTableView];
    
    self.historyTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.historyTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.historyTableView.backgroundColor = [UIColor seperatorColor];
    self.historyTableView.delegate = self;
    self.historyTableView.dataSource = self;
    self.historyTableView.hidden = (selectedIndex==0);
    
    [self.view addSubview:self.historyTableView];
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    
    __weak __typeof(self) weakself = self;
    mPicker = [[EventMediaPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)
                                                 readOnly:NO
                                              picCallback:^{
                                                  [weakself openPicMenu];
                                              } videoCallback:^{
                                                  [weakself openVideoMenu];
                                              } relayoutCallback:^{
                                                  [self.feedbackTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                                              }];
    
    
    [mPicker setImages:self.feedbackModel.images];
    [mPicker setVideo:self.feedbackModel.video];
    [mPicker relayout];

    
    
    
    [self.feedbackTableView reloadData];
    
}

-(UIView*) footerView
{
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kScreenWidth, 16*3+40*2);
    UIButton *btnCommit = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnCommit.backgroundColor = [UIColor themeBlueColor];
    [btnCommit setTitle:@"提交" forState:UIControlStateNormal];
    [btnCommit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCommit.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    btnCancel.backgroundColor = [UIColor themeDarkBlackColor];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCancel.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [btnCommit addTarget:self action:@selector(actionCommit:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel addTarget:self action:@selector(actionCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:btnCommit];
    [footer addSubview:btnCancel];
    
    CGFloat margin = 50;
    __weak UIView* weakView = footer;
    [btnCommit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(16);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnCommit.mas_bottom).offset(16);
        make.height.mas_equalTo(40);
        
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    return footer;
}


#pragma mark --centerSwitch delegate
- (void)centerSwitchToIndex:(NSUInteger)index
{
    selectedIndex = index;
    self.historyTableView.hidden = (selectedIndex==0);
    self.feedbackTableView.hidden = (selectedIndex!=0);
    NSLog([NSString stringWithFormat:@"change to index:%lu",(unsigned long)index]);
}

#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.feedbackTableView)
    {
        NSInteger row = indexPath.row;
        if (row == 2) {
            return 8;
        }
        if (row == 3) { //image picker
            return mPicker.frame.size.height;
        }
        return 55;
    }else if(tableView == self.historyTableView)
    {
        NSInteger row = indexPath.row;
        if (row%2 == 1) {
            return 8;
        }
        row = row/2;
        if (row < _historyModel.count) {
            
            return [MyEventHistoryCell heightForData:_historyModel[row]];
        }
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.feedbackTableView) {
        return 4;
    }else if(tableView == self.historyTableView)
    {
        return _historyModel.count*2-1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    if (tableView == self.feedbackTableView) {
        switch (row) {
                
            case 0:
            {
                TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell"];
                if (!cell) {
                    cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DateCell"];
                }
                cell.data = self.feedbackModel.date;
                return cell;
            }
            case 1:
            {
                TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
                if (!cell) {
                    cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.data = self.feedbackModel.detail;
                return cell;
            }
            case 2:
            {
                QRSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separatorCell"];
                if (!cell) {
                    cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"separatorCell"];
                }
                return cell;
            }
            case 3:
            {
                [mPicker removeFromSuperview];
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EventMediaPickerCell"];
                [cell.contentView addSubview: mPicker];
                return cell;
            }
        }

    }else if(tableView == self.historyTableView)
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
            if (row<_historyModel.count) {
                MyEventHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyEventHistoryCell"];
                if (!cell) {
                    cell = [[MyEventHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyEventHistoryCell"];
                }
                cell.data = _historyModel[row];
                return cell;
            }
            
        }
    }
    
    return nil;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.feedbackTableView) {
        switch (indexPath.row) {
            case 1:
            {
                
            }
                break;
            default:
                break;
        }

    }else if(tableView == self.historyTableView)
    {
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



#pragma mark actions
-(void) actionCommit:(id) sender
{
    
}

-(void) actionCancel:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
