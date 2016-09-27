//
//  SearchDetailSheetViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchDetailSheetViewController.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "QRSeparatorCell.h"
#import "SearchSheetCellFactory.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "NSBDBaseUIItem.h"
#import "TimerView.h"

@interface SearchDetailSheetViewController()
{
    BOOL readOnly;
    
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TimerView *timerView;

@property (nonatomic,readonly) NSDictionary *codeCommitDictionary;

@property (nonatomic,strong) NSBDBaseUIItem *uiItem;//model
@end

@implementation SearchDetailSheetViewController
@synthesize codeCommitDictionary = _codeCommitDictionary;

+(instancetype) sheetReadOnlyWithUIItem:(NSBDBaseUIItem *)item
{
    
    SearchDetailSheetViewController *vc =[[SearchDetailSheetViewController alloc] initWithReadOnlySheet];
    vc.uiItem = item;
    return vc;
}

+(instancetype) sheetEditableWithUIItem:(NSBDBaseUIItem *)item
{
    SearchDetailSheetViewController *vc =[[SearchDetailSheetViewController alloc] init];
    vc.uiItem = item;
    return vc;
}

-(NSDictionary *) codeCommitDictionary
{
    if (!_codeCommitDictionary) {
        _codeCommitDictionary = @{@"NGQPKJUP":@"南干渠排空井上段",
                            @"NGQPKJDOWN":@"南干渠排空井下段",
                            @"NGQPQJUP":@"南干渠排气阀井上段",
                            @"NGQPQJDOWN":@"南干渠排气阀井下段",
                            @"NGQGX":@"南干渠管线",
                            @"DGQPQJ":@"东干渠排气阀井",
                            @"DGQFSK":@"东干渠分水口",
                            @"DGQPKJ":@"dgqqueryair",
                            @"DGQGX":@"东干渠管线",
                            @"DNPKJ":@"dnquerywell",
                            @"DNPQJ":@"dnqueryair",
                            @"DNGX":@"dnqueryline"};
    }
    return _codeCommitDictionary;

}



-(instancetype) initWithReadOnlySheet
{
    self = [super init];
    if (self) {
        readOnly = YES;
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
    if (![[AFNetworkReachabilityManager sharedManager] isReachable])
    {
        [ToastView popToast:@"暂无网络，稍后再试"];
        return;
    }
//    @weakify(self);
//    [[SearchSessionManager sharedManager] requestQueryListSearchSessionWithTaskId:<#(NSString *)#> code:<#(NSString *)#> action:self.codeDictionary[self.uiItem.] SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
//        @strongify(self);
//    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
//        @strongify(self);
//    }
}

-(void) setupSubviews
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    if (!readOnly) {
        _tableView.tableFooterView = [self footerView];
    }
    _timerView = [TimerView timerViewWithStartTime:[[SearchSessionManager sharedManager].session totalTime] frame:CGRectMake(0, 0, 80, 30) smallStyle:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_timerView];
}

-(UIView*) footerView
{
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kScreenWidth, 16*3+40*2);
    UIButton *btnCommit = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btnSaveLocal = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnCommit.backgroundColor = UI_COLOR(0xFF,0x82,0x47);
    [btnCommit setTitle:@"提交" forState:UIControlStateNormal];
    [btnCommit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCommit.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    btnSaveLocal.backgroundColor = [UIColor blueColor];
    [btnSaveLocal setTitle:@"保存本地" forState:UIControlStateNormal];
    [btnSaveLocal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSaveLocal.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [btnCommit addTarget:self action:@selector(actionCommit:) forControlEvents:UIControlEventTouchUpInside];
    [btnSaveLocal addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:btnCommit];
    [footer addSubview:btnSaveLocal];
    
    CGFloat margin = 50;
    __weak UIView* weakView = footer;
    [btnCommit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(16);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    [btnSaveLocal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnCommit.mas_bottom).offset(16);
        make.height.mas_equalTo(40);
        
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    return footer;
}



-(void) actionCommit:(id) sender
{
    
}

-(void) actionSave:(id) sender
{
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!self.uiItem || section >= [self.uiItem defaultUIStyleMapping].count) {
        return 0;
    }
    NSDictionary *dict = [self.uiItem defaultUIStyleMapping][section];
    NSString *title = dict[@"group"];
    
    if (title) {
        return 30;
    }
    return 8;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!self.uiItem || section >= [self.uiItem defaultUIStyleMapping].count) {
        return nil;
    }
    
    NSDictionary *dict = [self.uiItem defaultUIStyleMapping][section];
    NSString *title = dict[@"group"];
    
    QRSeparatorView *view = [[QRSeparatorView alloc] init];
    if (title) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, kScreenWidth-16, 30)];
        label.text = title;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section >= self.uiItem.infolist.count)
    {
        return 0;
    }
    
    SearchSheetGroupItem *group = self.uiItem.infolist[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section < self.uiItem.infolist.count) {
        
        SearchSheetGroupItem *group = self.uiItem.infolist[section];
        if (row < group.items.count) {
            
            SearchSheetInfoItem *item = group.items[row];
            
            BaseTitleCell *cell = [_tableView dequeueReusableCellWithIdentifier:item.key];
            if (!cell) {
                cell = [SearchSheetCellFactory cellForSheetStyle:item.uiStyle reuseIdentifier:item.key];
            }
            
            cell.data = item.data;
            return cell;
        }
    }
    
    
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section < self.uiItem.infolist.count) {
        
        SearchSheetGroupItem *group = self.uiItem.infolist[section];
        if (row < group.items.count) {
            
            SearchSheetInfoItem *item = group.items[row];
            //do something~
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.uiItem || !self.uiItem.infolist) {
        return 1;
    }
    return self.uiItem.infolist.count;
}
@end
