//
//  SearchDetailSheetViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchDetailSheetViewController.h"
#import "SearchDetailSheetViewController+pickMedia.h"
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
#import "SearchSheetItemManager.h"
#import "TextPickerViewController.h"
#import "HttpBaseModel.h"
#import "DatePickViewController.h"
#import "EventMediaPickerView.h"
#import "UploadAttachmentModel.h"
#import "SearchHistoryDetailSheetModel.h"
#import "UITableView+EmptyView.h"
#import "EventHttpManager.h"

@interface SearchDetailSheetViewController()
{
    BOOL readOnly;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TimerView *timerView;

@end

@implementation SearchDetailSheetViewController

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

-(instancetype) init
{
    self = [super init];
    if (self) {
        readOnly = NO;
    }
    return self;
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
    [self setupObservers];
    [self requestData];
}

-(void) setFcode:(NSString *)fcode
{
    _fcode = fcode;
    if ([self.uiItem respondsToSelector:@selector(setWellnum:)]) {
        [self.uiItem performSelector:@selector(setWellnum:) withObject:fcode];
    }
}

-(void) setFname:(NSString *)fname
{
    _fname = fname;
    if ([self.uiItem respondsToSelector:@selector(setWellname:)]) {
        [self.uiItem performSelector:@selector(setWellname:) withObject:fname];
    }
}

-(void) setupObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textPicked:) name:@"TextPickerNotification" object:nil];
}

-(void) textPicked:(NSNotification *)noti
{
    [_tableView reloadData];
}

-(void) requestData
{
    if (!readOnly)
    {
        if (![self.uiItem isLine]){
            NSBDBaseUIItem *uiItem =
            [SearchSheetItemManager getSearchSheetItemWithCode:self.code fcode:self.fcode taskid:self.uiItem.taskid];
            if (uiItem) {
                self.uiItem = uiItem;
            }
        }
        [_tableView reloadData];
    }else
    {
        @weakify(self)
        
        if (![self.uiItem isLine]) {
            [[SearchSessionManager sharedManager] requestQueryHistoryWellSearchSessionWithTaskId:self.taskId wellnum:self.fcode action:self.queryCode SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
                @strongify(self)
                
                //todo fill uiitem value
                SearchHistoryDetailSheetModel *model = [SearchHistoryDetailSheetModel objectWithKeyValues:dict];
                NSLog(@"%@",model);
                if (model.success) {
                    if (model.datalist.count>0) {
                        [self.uiItem setInfoArray:model.datalist[0]];
                        [self.tableView reloadData];
                    }else
                    {
                        [self.tableView setEmptyView];
                    }
                }
                else if (model.status == HttpResultInvalidUser)
                {
                    [ToastView popToast:@"您的帐号在其他地方登录"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else{
                    [self.tableView setEmptyView];
                }
            } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
                @strongify(self)
                [self.tableView setEmptyView];
            }];
            
        }
        else //is line
        {
            [self.tableView reloadData];
        }
        
    }
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
        _timerView = [TimerView timerViewWithStartTime:[[SearchSessionManager sharedManager].session totalTime] frame:CGRectMake(0, 0, 80, 30) smallStyle:YES];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_timerView];
    }
    
    __weak __typeof(self) weakself = self;
    _mPicker = [[EventMediaPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)
                                                  readOnly:readOnly
                                               picCallback:^{
                                                   [weakself openPicMenu];
                                               } videoCallback:^{
                                                   [weakself openVideoMenu];
                                               } relayoutCallback:^{
                                                   [weakself.tableView reloadData];
                                               }];
    
    [_mPicker setImages:self.uiItem.attachModel.images];
    [_mPicker setVideo:self.uiItem.attachModel.videoURL];
    [_mPicker relayout];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!readOnly)
    {
        [_timerView setShowTime:[[SearchSessionManager sharedManager].session totalTime]];
        
        if (![SearchSessionManager sharedManager].session.pauseState) {
            
            [_timerView continueTiming];
        }
    }
}

-(void) viewDidDisappear:(BOOL)animated
{
    if (!readOnly)
    {
        if (![SearchSessionManager sharedManager].session.pauseState) {
            [_timerView pauseTiming];
        }
    }
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
    [[SearchSessionManager sharedManager] requestUploadSheetWithItem:self.uiItem SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        HttpBaseModel *item = [HttpBaseModel objectWithKeyValues:dict];
        if (item.success)
        {
            if (![self.uiItem isLine])
                [SearchSheetItemManager removeSearchSheetItemWithCode:self.code fcode:self.fcode taskid:self.uiItem.taskid];
            else{
                [SearchSheetItemManager removeSearchLineItemWithWithUUID:self.uiItem.itemId code:self.code taskid:self.uiItem.taskid];
            }
            
            
            //upload attachment if has
            if (self.uiItem.attachModel.images.count>0 || self.uiItem.attachModel.videoURL != nil) {
                
                if (self.uiItem.attachModel.images.count>0) {
                    for (UIImage *image in self.uiItem.attachModel.images) {
                        [[EventHttpManager sharedManager] requestUploadAttachment:image fkid:self.uiItem.itemId qxyjFlag:YES successCallback:nil failCallback:nil];
                    }
                }
                
                if (self.uiItem.attachModel.videoURL)
                {
                    [[EventHttpManager sharedManager] requestUploadAttachmentMovie:self.uiItem.attachModel.videoURL fkid:self.uiItem.itemId qxyjFlag:YES successCallback:nil failCallback:nil];
                    
                }
            }
            [ToastView popToast:@"提交成功"];

            
            [self.navigationController popViewControllerAnimated:YES];
        }else if (item.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
            [ToastView popToast:@"提交失败，请稍候再试"];
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        [ToastView popToast:@"提交失败，请稍候再试"];
    }];
    
    
}

-(void) actionSave:(id) sender
{
    if (![self.uiItem isLine])
        [SearchSheetItemManager addSearchSheetItem:self.uiItem withCode:self.code fcode:self.fcode];
    else{
        [SearchSheetItemManager addSearchLineItem:self.uiItem withCode:self.code];
    }
    [ToastView popToast:@"保存本地成功"];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!self.uiItem || section >= [self.uiItem defaultUIStyleMapping].count) {
        return 0;
    }
    NSDictionary *dict = [self.uiItem defaultUIStyleMapping][section];
    NSString *title = dict[@"group"];
    
    if (title && title.length>0) {
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
    
    if (section > self.uiItem.infolist.count)
    {
        return 0;
    }
    if (section == self.uiItem.infolist.count) //meida picker
    {
        return 1;
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
            cell.readOnly = readOnly;
            return cell;
        }
    }
    if (section == self.uiItem.infolist.count)
    {
        [_mPicker removeFromSuperview];
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MediaPickerCell"];
        [cell.contentView addSubview: _mPicker];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

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
            if (item.uiStyle == SheetUIStyle_Text) {
                TextPickerViewController *vc = [[TextPickerViewController alloc] initWithData:item.data readOnly:readOnly];
                [self.navigationController pushViewController:vc animated:YES];
            }else if (item.uiStyle == SheetUIStyle_Date)
            {
                DatePickViewController *vc = [[DatePickViewController alloc] initWithData:item.data readOnly:readOnly];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.uiItem || !self.uiItem.infolist) {
        return 1;
    }
    return self.uiItem.infolist.count+1;
}
@end
