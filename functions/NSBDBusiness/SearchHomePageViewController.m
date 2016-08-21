//
//  SearchHomePageViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHomePageViewController.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "SearchHomePageModel.h"
#import "SearchDetailSheetViewController.h"
#import "SearchCategoryItem.h"
#import "UIColor+ThemeColor.h"
#import "NSBDBaseUIItem.h"

@interface SearchHomePageViewController()

@property (nonatomic,strong) UITableView *tableView;
@end

@implementation SearchHomePageViewController

-(instancetype) initWithTaskId:(NSString *) taskid
{
    self = [super init];
    if (self)
    {
        self.taskid = taskid;
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    [self requestData];
}

-(void) requestData
{
    //mock
   
    id mock = @[
                @{@"code":@"0",@"title":@"管线"},
                @{@"code":@"1",@"title":@"东干渠分水口"},
                @{@"code":@"2",@"title":@"东干渠排气阀井"}
                ];
     NSDictionary *dict =@{@"status":@"100",@"data":mock};
    
    _model = [SearchHomePageModel objectWithKeyValues:dict];
}

-(void) setupSubviews
{
    self.title = @"巡查对象";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _tableView.backgroundColor = [UIColor backGroundGrayColor];
    _tableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    _tableView.tableFooterView = [self footerView];
}

-(UIView*) footerView
{
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kScreenWidth, 16*3+40*2);
    footer.backgroundColor = [UIColor backGroundGrayColor];
    
    UIButton *btnPause = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btnEndSession = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnPause.backgroundColor = [UIColor themeBlueColor];
    [btnPause setTitle:@"暂停" forState:UIControlStateNormal];
    [btnPause setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnPause.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    btnEndSession.backgroundColor = UI_COLOR(32,41,50);
    [btnEndSession setTitle:@"结束" forState:UIControlStateNormal];
    [btnEndSession setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnEndSession.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [btnPause addTarget:self action:@selector(actionPause:) forControlEvents:UIControlEventTouchUpInside];
    [btnEndSession addTarget:self action:@selector(actionEndSesson:) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:btnPause];
    [footer addSubview:btnEndSession];
    
    CGFloat margin = 50;
    __weak UIView* weakView = footer;
    [btnPause mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(16);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    [btnEndSession mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnPause.mas_bottom).offset(16);
        make.height.mas_equalTo(40);
        
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    return footer;
}



-(void) actionPause:(id) sender
{
}

-(void) actionEndSesson:(id) sender
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _model.datalist.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, kScreenWidth, 30)];
    label.text = @"请填写巡查表单中的信息";
    label.textColor = [UIColor themeGrayTextColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    view.backgroundColor = [UIColor backGroundGrayColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger row = indexPath.row;
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"textCell"];
    if (!cell) {
        cell = [UITableViewCell new];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (row<_model.datalist.count) {
        
        SearchCategoryItem *item = _model.datalist[row];
        cell.textLabel.text = item.title;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (row < _model.datalist.count) {
        SearchCategoryItem *item = _model.datalist[row];
        NSBDBaseUIItem *sheetItem = [item sheetItem];
        SearchDetailSheetViewController *vc = [SearchDetailSheetViewController sheetEditableWithUIItem:sheetItem];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
