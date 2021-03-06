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
#import "UploadAttachmentModel.h"
#import "NSString+UUID.h"

#import "TitleDetailCell.h"
#import "QRSeparatorCell.h"
#import "EventHttpManager.h"
#import "MyEventDetailProgressModel.h"
#import "TextPickerViewController.h"
#import "MyDealedEventDetailProgressModel.h"
#import "NSDateFormatterHelper.h"

@interface MyEventDetailViewController()<CenterSwitchActionDelegate>
{
    NSInteger selectedIndex;
    NSString *eventId;
    NSString *departName;
    MyEventDetailType type;
}
@end

@implementation MyEventDetailViewController

-(instancetype) initWithEventId:(NSString *)eid departName:(NSString *)depart
{
    return [self initWithEventId:eid departName:depart eventType:MyEventDetailType_Normal];
}

-(instancetype) initWithEventId:(NSString *)eid departName:(NSString *)depart eventType:(MyEventDetailType) etype
{
    self = [super init];
    if (self) {
        eventId = eid;
        departName = depart?:@"";
        type = etype;
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
    [self setupObservers];
    [self setupPickerManager];
}

-(void) setupObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textPicked:) name:@"TextPickerNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(attachmentComplete:) name:@"attachmentComplete" object:nil];
    
}

-(void) attachmentComplete:(NSNotification *)noti
{
    [self.historyTableView reloadData];
}

-(void) textPicked:(NSNotification *)noti
{
    [self.feedbackTableView reloadData];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void) setupModel
{
    //model for feedback
    _feedbackModel = [FeedbackModel new];
    
    
    NSDateFormatter *formater = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    _feedbackModel.date = [TitleDetailItem itemWithTitle:@"反馈时间" detail:[formater stringFromDate:[NSDate date]]];
    _feedbackModel.detail = [TitleDetailTextItem itemWithTitle:@"进展描述" detail:@"未填写" text:@""];
    _feedbackModel.images = [NSMutableArray arrayWithCapacity:6];
    
#ifdef NoServer
    //model for history
    MyEventHistoryItem *item1 =[[MyEventHistoryItem alloc] init];
    item1.disposeDescription = @"我呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜";
    item1.addTime = @"2016-1-2";
    item1.disposeBy = @"北京";
    item1.creatorName = @"勿忘我";
    item1.attachment.images =[@[@"http://tva2.sinaimg.cn/crop.0.0.180.180.180/65de1936jw1e8qgp5bmzyj2050050aa8.jpg"] mutableCopy];
    
    MyEventHistoryItem *item2 =[[MyEventHistoryItem alloc] init];
    item2.disposeDescription = @"我呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜";
    item2.addTime = @"2016-1-2 13:00:01";
    item2.disposeBy = @"北京";
    item2.creatorName = @"lls";
    _historyModel = @[item1,item2];
    return;
#endif
    _historyModel =[NSArray array];
    [self requestData];
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    CenterSwitchView *view = [[CenterSwitchView alloc] initWithFrame:CGRectMake(0, 0, CenetrSwitchLabelWidth*2, CenetrSwitchHeight) andTitleArray:@[@"当前进展",@"历史进展"] andDelegate:self andSelectIndex:0];
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
    _mPicker = [[EventMediaPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)
                                                 readOnly:NO
                                              picCallback:^{
                                                  [weakself openPicMenu];
                                              } videoCallback:^{
                                                  [weakself openVideoMenu];
                                              } relayoutCallback:^{
                                                  [self.feedbackTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                                              }];
    

    [_mPicker setImages:self.feedbackModel.images];
    [_mPicker setVideo:self.feedbackModel.video];
    [_mPicker relayout];

    
    
    
    [self.feedbackTableView reloadData];
    
}

-(void) requestData
{
    @weakify(self)
    
    if (type == MyEventDetailType_Normal) {
        [[EventHttpManager sharedManager] requestMyEventProgressListWithId:eventId SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
            //todo
            @strongify(self)
            MyEventDetailProgressModel *item = [MyEventDetailProgressModel objectWithKeyValues:dict];
            if (item.success)
            {
                _historyModel = [item.datalist copy];
                [self.historyTableView reloadData];
                
            }else if (item.status == HttpResultInvalidUser)
            {
                [ToastView popToast:@"您的帐号在其他地方登录"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                [ToastView popToast:@"刷新失败,请稍候再试"];
            }
            
        } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
            //todo
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }];

    }else
    {
        [[EventHttpManager sharedManager] requestMyDealedEventProgressListWithId:eventId SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
            //todo
            @strongify(self)
            MyDealedEventDetailProgressModel *item = [MyDealedEventDetailProgressModel objectWithKeyValues:dict];
            if (item.success)
            {
                _historyModel = [item.datalist copy];
                [self.historyTableView reloadData];
                
            }else if (item.status == HttpResultInvalidUser)
            {
                [ToastView popToast:@"您的帐号在其他地方登录"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                [ToastView popToast:@"刷新失败,请稍候再试"];
            }
            
        } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
            //todo
            [ToastView popToast:@"刷新失败,请稍候再试"];
        }];
    }
    
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
    NSLog(@"%@", [NSString stringWithFormat:@"change to index:%lu",(unsigned long)index]);
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
            return _mPicker.frame.size.height;
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
                
                NSDateFormatter *formater = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd-HH:mm:ss"];
                _feedbackModel.date.detail = [formater stringFromDate:[NSDate date]];
                cell.data = self.feedbackModel.date;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                [_mPicker removeFromSuperview];
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EventMediaPickerCell"];
                [cell.contentView addSubview: _mPicker];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }

    }else if(tableView == self.historyTableView)
    {
        if (row%2 == 1) {
            QRSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separatorCell"];
            if (!cell) {
                cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"separatorCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }else
        {
            row = row /2;
            if (row<_historyModel.count) {
                MyEventHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyEventHistoryCell"];
                if (!cell) {
                    cell = [[MyEventHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyEventHistoryCell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                TextPickerViewController *vc = [[TextPickerViewController alloc] initWithData:self.feedbackModel.detail];
                
                [self.navigationController pushViewController:vc animated:YES];
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
    @weakify(self)
    NSString *uuid = [NSString stringWithUUID];
    if (type == MyEventDetailType_Normal)
    {
        [[EventHttpManager sharedManager] requestAddMyEventProgressListWithId:eventId
                                                                         uuid:uuid
                                                                        title:_feedbackModel.detail.text
                                                                    disposeBy:departName
                                                              SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
                                                                  @strongify(self)
                                                                  HttpBaseModel *item = [HttpBaseModel objectWithKeyValues:dict];
                                                                  if (item.success)
                                                                  {
                                                                      [ToastView popToast:@"提交成功"];
                                                                      if (self.feedbackModel.images.count>0) {
                                                                          for (UIImage *image in self.feedbackModel.images) {
                                                                              [[EventHttpManager sharedManager] requestUploadAttachment:image fkid:uuid qxyjFlag:YES btype:@"incidentProgress" successCallback:nil failCallback:nil];
                                                                          }
                                                                      }
                                                                      
                                                                      if (self.feedbackModel.video)
                                                                      {
                                                                          [[EventHttpManager sharedManager] requestUploadAttachmentMovie:self.feedbackModel.video fkid:uuid  qxyjFlag:YES btype:@"incidentProgress" successCallback:nil failCallback:nil];
                                                                          
                                                                      }
                                                                      self.feedbackModel.detail.detail = @"未填写";
                                                                      self.feedbackModel.detail.text = @"";
                                                                      self.feedbackModel.video = nil;
                                                                      [self.feedbackModel.images removeAllObjects];
                                                                      [self.mPicker setImages:self.feedbackModel.images];
                                                                      [self.mPicker setVideo:self.feedbackModel.video];
                                                                      [self.mPicker relayout];
                                                                      [self.feedbackTableView reloadData];
                                                                      [self requestData];
                                                                      
                                                                  }else if (item.status == HttpResultInvalidUser)
                                                                  {
                                                                      [ToastView popToast:@"您的帐号在其他地方登录"];
                                                                      [self.navigationController popToRootViewControllerAnimated:YES];
                                                                  }
                                                                  else
                                                                  {
                                                                      [ToastView popToast:@"提交失败,请稍候再试"];
                                                                  }
                                                                  
                                                              } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
                                                                  //todo
                                                                  [ToastView popToast:@"提交失败,请稍候再试"];
                                                              }];
    }else
    {
        [[EventHttpManager sharedManager] requestAddMyEventProgressListWithId:eventId
                                                                         uuid:uuid
                                                                      content:_feedbackModel.detail.text
                                                              SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
                                                                  @strongify(self)
                                                                  HttpBaseModel *item = [HttpBaseModel objectWithKeyValues:dict];
                                                                  if (item.success)
                                                                  {
                                                                      [ToastView popToast:@"提交成功"];
                                                                      if (self.feedbackModel.images.count>0) {
                                                                          for (UIImage *image in self.feedbackModel.images) {
                                                                              [[EventHttpManager sharedManager] requestUploadAttachment:image fkid:uuid qxyjFlag:YES btype:@"incidentTaskDispose" successCallback:nil failCallback:nil];
                                                                          }
                                                                      }
                                                                      
                                                                      if (self.feedbackModel.video)
                                                                      {
                                                                          [[EventHttpManager sharedManager] requestUploadAttachmentMovie:self.feedbackModel.video fkid:uuid  qxyjFlag:YES btype:@"incidentTaskDispose"  successCallback:nil failCallback:nil];
                                                                          
                                                                      }
                                                                      self.feedbackModel.detail.detail = @"未填写";
                                                                      self.feedbackModel.detail.text = @"";
                                                                      self.feedbackModel.video = nil;
                                                                      [self.feedbackModel.images removeAllObjects];
                                                                      [self.mPicker setImages:self.feedbackModel.images];
                                                                      [self.mPicker setVideo:self.feedbackModel.video];
                                                                      [self.mPicker relayout];
                                                                      [self.feedbackTableView reloadData];
                                                                      [self requestData];
                                                                      
                                                                  }else if (item.status == HttpResultInvalidUser)
                                                                  {
                                                                      [ToastView popToast:@"您的帐号在其他地方登录"];
                                                                      [self.navigationController popToRootViewControllerAnimated:YES];
                                                                  }
                                                                  else
                                                                  {
                                                                      [ToastView popToast:@"提交失败,请稍候再试"];
                                                                  }
                                                                  
                                                              } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
                                                                  //todo
                                                                  [ToastView popToast:@"提交失败,请稍候再试"];
                                                              }];
    }

}

-(void) actionCancel:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
