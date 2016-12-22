//
//  SearchStartViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchStartViewController.h"
#import "SearchHomePageViewController.h"
#import "WeatherManager.h"
#import "SearchSessionManager.h"

#import "TitleTextInputCell.h"
#import "TitleDetailCell.h"
#import "CheckableTitleCell.h"

#import "CheckableTitleItem.h"
#import "TitleDetailItem.h"
#import "TitleItem.h"
#import "TitleDetailCell.h"

#import "ToastView.h"

#import "CommonDefine.h"
#import "Masonry.h"
#import "HttpManager.h"
#import "ToastView.h"
#import "UIColor+ThemeColor.h"

#import "NSString+UUID.h"

#import "SearchTaskStatusModel.h"

@interface SearchStartViewController()<UITableViewDelegate,UITableViewDataSource>
{
    WeatherManager *manager;
}
@property (nonatomic,strong)     UITableView *tableView;
@end

@implementation SearchStartViewController

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
    self.model.weather = [TitleDetailItem itemWithTitle:@"天气" detail:@"查询中..."];
    self.model.searcher = [TitleInputItem itemWithTitle:@"巡查人" placeholder:@"巡查人姓名"];
    self.model.searchAdmin = [TitleInputItem itemWithTitle:@"巡查管理员" placeholder:@"巡查管理员姓名"];
}

-(void) requestData
{
    manager = [WeatherManager sharedInstance];
    
    self.model.weather.detail = manager.weather;
    NSKeyValueObservingOptions static const
    options = NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld |
    NSKeyValueObservingOptionNew;
    [manager addObserver:self
                     forKeyPath:@"weather"
                        options:options context:nil];
    
    [manager requestData];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"weather"]) {
        if (self.model.weather && ![change[NSKeyValueChangeNewKey] isKindOfClass:[NSNull class]]) {
            self.model.weather.detail = change[NSKeyValueChangeNewKey];
            [self.tableView reloadData];
        }
    }
}

-(void) dealloc
{
    [manager removeObserver:self forKeyPath:@"weather"];
}

-(void) setupSubViews
{
    self.navigationItem.title = @"巡查信息填报";
    //self.title = @"巡查信息填报";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.tableView.backgroundColor =  [UIColor backGroundGrayColor];
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
    
    btnNewSession.backgroundColor = [UIColor themeBlueColor];
    [btnNewSession setTitle:@"开始新一期填报" forState:UIControlStateNormal];
    [btnNewSession setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnNewSession.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    btnQuit.backgroundColor = [UIColor themeDarkBlackColor];
    [btnQuit setTitle:@"不写了，离开" forState:UIControlStateNormal];
    [btnQuit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnQuit.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [btnNewSession addTarget:self action:@selector(actionNewSession:) forControlEvents:UIControlEventTouchUpInside];
    [btnQuit addTarget:self action:@selector(actionLeave:) forControlEvents:UIControlEventTouchUpInside];
    
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
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCellSearcher"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCellSearcher"];
            }
            cell.data = self.model.searcher;
            return cell;
            break;
        }
        case 1:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCellSearchAdmin"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCellSearchAdmin"];
            }
            cell.data = self.model.searchAdmin;
            return cell;
            break;
        }
        case 2:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.data = self.model.weather;
            return cell;
            break;
        }
        default:
            break;
    }
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row ==2)
    {
        [manager requestData];
    }
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



-(void) popSelfAndPush:(UIViewController *)vc
{
    int index = (int)[[self.navigationController viewControllers] indexOfObject:self];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    array[index] = vc;
    [self.navigationController setViewControllers:[array copy] animated:YES];
}

#pragma mark actions
-(void) actionNewSession:(id) sender
{
#ifdef NoServer
    //-----------------
    //to be deleted
    [[SearchSessionManager sharedManager] setNewSessionWithId:@"test"];
    SearchHomePageViewController * vc = [[SearchHomePageViewController alloc] init];
    
    [self popSelfAndPush:vc];
    return;
    //-----------------
    
#endif
    
    __weak UIButton *btn = (UIButton *)sender;
    NSString *sessionId = [NSString stringWithUUID];
    if (_model.searcher.detail && _model.searcher.detail.length>0 &&
        _model.searchAdmin.detail && _model.searchAdmin.detail.length>0) {
        btn.enabled = NO;
        [SVProgressHUD showWithStatus:@"处理中..."];
        
        [[SearchSessionManager sharedManager] requestNewSearchSessionWithSearchStartModel:_model sessionID:sessionId  successCallback:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
            
            if ([SVProgressHUD isVisible]) {
                [SVProgressHUD dismiss];
            }
            HttpBaseModel *item = [HttpBaseModel objectWithKeyValues:dict];
            if (item.success)
            {
                [[SearchSessionManager sharedManager] setNewSessionWithId:sessionId];
                
                
                
                SearchHomePageViewController * vc = [[SearchHomePageViewController alloc] init];
                [self popSelfAndPush:vc];
            }else if (item.status == HttpResultInvalidUser)
            {
                [ToastView popToast:@"您的帐号在其他地方登录"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else
            {
                [ToastView popToast:@"请稍后再试"];
            }
            btn.enabled = YES;
        } failCallback:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求失败
            [ToastView popToast:@"请稍后再试"];
            btn.enabled = YES;
        }];

    }
}

-(void) actionLeave:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
