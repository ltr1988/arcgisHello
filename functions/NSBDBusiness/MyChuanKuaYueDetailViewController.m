//
//  MyChuanKuaYueDetailViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueDetailViewController.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "QRSeparatorCell.h"
#import "MJRefresh.h"
#import "EventHttpManager+ChuanKuaYue.h"
#import "MyChuanKuaYueItem.h"
#import "MyChuanKuaYueListModel.h"
#import "AttachmentItem.h"
#import "ClosableWebView.h"

@interface MyChuanKuaYueDetailViewController ()
{
    BOOL isHistory;
}
@property (nonatomic,strong) NSString *theID;
@property (nonatomic,strong) MyChuanKuaYueItem * modelItem;
@end

@implementation MyChuanKuaYueDetailViewController

-(instancetype) initWithId:(NSString *)theID
{
    return [self initWithId:theID isHistory:NO];
}

-(instancetype) initWithId:(NSString *)theID isHistory:(BOOL)history
{
    if (self = [super init]) {
        _theID = theID;
        isHistory = history;
    }
    return self;
}
-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    [self.myTableView.mj_header beginRefreshing];
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.myTableView.backgroundColor = [UIColor seperatorColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.tableFooterView = [[UIView alloc] init];
    self.myTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    
    [self.view addSubview:self.myTableView];
    
    [self.myTableView reloadData];
    
}

-(void) requestData
{
    if (self.modelItem != nil) {
        return;
    }
    @weakify(self)
    
    [[EventHttpManager sharedManager] requestQueryChuanKuaYueDetailWithID:self.theID isHistory:isHistory SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        @strongify(self)
        MyChuanKuaYueListModel *model = [MyChuanKuaYueListModel objectWithKeyValues:dict];
        if (model.success && model.datalist.count > 0)
        {
            self.modelItem = model.datalist.firstObject;
            [self.myTableView reloadData];
            
        }else if (model.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }
        [self.myTableView.mj_header endRefreshing];
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        @strongify(self)
        [self.myTableView.mj_header endRefreshing];
        [ToastView popToast:@"刷新失败,请稍候再试"];
    }];
}

#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.modelItem)
        return 7+ (self.modelItem.fileList.count==0?0:(self.modelItem.fileList.count+1));
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *title=@"";
    NSString *detail=@"";
    switch (row) {
        case 0:
            title = @"工程名称:";
            detail = self.modelItem.name;
            break;
        case 1:
            title = @"责任单位:";
            detail = self.modelItem.constructionUnit;
            break;
        case 2:
            title = @"监管单位:";
            detail = self.modelItem.supervisoryUnit;
            break;
        case 3:
            title = @"建设期:";
            detail = self.modelItem.constructionPeriod;
            break;
        case 4:
            title = @"位置描述:";
            detail = self.modelItem.other;
            break;
        case 5:
            title = @"桩号:";
            detail = self.modelItem.mileNum;
            break;
        case 6:
            title = @"安全检测单位:";
            detail = self.modelItem.safetyMonitorUnit;
            break;
        case 7:
            title = @"附件:";
            detail = @"";
            break;
            
        default:
        {
            title = @"";
            detail = @"";
            NSInteger index = row - 8;
            if (index>=0 && index<self.modelItem.fileList.count) {
                AttachmentItem *attach = self.modelItem.fileList[index];
                title = [NSString stringWithFormat:@"%ld.\t%@",index+1,attach.name];
            }
            
        }
            break;
    }
    cell.textLabel.text = title;
    cell.detailTextLabel.text = detail;
    cell.detailTextLabel.textColor = [UIColor blackColor];
    return cell;

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    @weakify(self)
    if (row>=8)
    {
        NSInteger index = row - 8;
        if (index>=0 && index<self.modelItem.fileList.count) {
            AttachmentItem *attach = self.modelItem.fileList[index];
            [attach downloadWithCompletionBlock:^(NSString *fileUrl, NSString *type) {
                @strongify(self)
                NSString *extension = [fileUrl pathExtension];
                if ([extension.lowercaseString isEqualToString:@"pdf"]) {
                    ClosableWebView *webView = [[ClosableWebView alloc] initWithFrame:self.view.bounds];
                    NSURL *url = [NSURL fileURLWithPath:fileUrl];
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    [webView loadRequest:request];
                    [self.view addSubview:webView];
                }
            }];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
