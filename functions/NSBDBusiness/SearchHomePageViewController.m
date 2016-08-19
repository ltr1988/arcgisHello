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
    _model = [SearchHomePageModel new];
    _model.datalist = @[@"管线",@"排气阀井",@"排空井"];
}

-(void) setupSubviews
{
    self.title = @"巡查对象";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _tableView.backgroundColor = UI_COLOR(0xFF,0x82,0x47);
    _tableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    _tableView.tableFooterView = [self footerView];
}

-(UIView*) footerView
{
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kScreenWidth, 16*3+40*2);
    UIButton *btnPause = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btnEndSession = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnPause.backgroundColor = UI_COLOR(0xFF,0x82,0x47);
    [btnPause setTitle:@"暂停" forState:UIControlStateNormal];
    [btnPause setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnPause.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    btnEndSession.backgroundColor = [UIColor blueColor];
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
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _model.datalist.count;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, kScreenWidth, 14)];
    label.text = @"请填写巡查表单中的信息";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
