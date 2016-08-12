//
//  SearchStartViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchStartViewController.h"

#import "TitleTextInputCell.h"
#import "TitleDetailCell.h"
#import "CheckableTitleCell.h"

#import "CheckableTitleItem.h"
#import "TitleDetailItem.h"
#import "TitleItem.h"

#import "ToastView.h"

#import "CommonDefine.h"
#import "Masonry.h"

@interface SearchStartViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)     UITableView *tableView;
@end

@implementation SearchStartViewController


-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupModel];
    [self setupSubViews];
    [self requestData];
    
}

-(void) setupModel
{
    self.model = [SearchStartModel new];
    self.model.weather = [TitleInputItem itemWithTitle:@"天气" placeholder:@"查询中..."];
    self.model.searcher = [TitleInputItem itemWithTitle:@"巡查人" placeholder:@"巡查人姓名"];
    self.model.searchAdmin = [TitleInputItem itemWithTitle:@"巡查管理员" placeholder:@"巡查管理员姓名"];
}

-(void) requestData
{
    //todo request weather
    
}

-(void) setupSubViews
{
    self.title = @"巡查信息填报";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    
    self.tableView.tableFooterView = [self footerView];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

-(UIView*) footerView
{
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kScreenWidth, 16*3+40*2);
    UIButton *btnNewSession = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btnQuit = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnNewSession.backgroundColor = UI_COLOR(0xFF,0x82,0x47);
    [btnNewSession setTitle:@"开始新一期填报" forState:UIControlStateNormal];
    [btnNewSession setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnNewSession.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    btnQuit.backgroundColor = [UIColor blueColor];
    [btnQuit setTitle:@"不写了，离开" forState:UIControlStateNormal];
    [btnQuit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnQuit.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [btnNewSession addTarget:self action:@selector(actionUpload:) forControlEvents:UIControlEventTouchUpInside];
    [btnQuit addTarget:self action:@selector(actionSaveLocal:) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:btnNewSession];
    [footer addSubview:btnQuit];
    
    CGFloat margin = 50;
    __weak UIView* weakView = footer;
    [btnNewSession mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(16);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    [btnQuit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnNewSession.mas_bottom).offset(16);
        make.height.mas_equalTo(40);
        
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCell"];
    if (!cell) {
        cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCell"];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.data = self.model.searcher;
            break;
        }
        case 1:
        {
            cell.data = self.model.searchAdmin;
            break;
        }
        case 2:
        {
            cell.data = self.model.weather;
            break;
        }
        default:
            break;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}
@end
