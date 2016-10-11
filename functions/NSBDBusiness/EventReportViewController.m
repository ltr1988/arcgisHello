//
//  EmergencyReportViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventReportViewController.h"
#import "EventReportViewController+pickMedia.h"

#import "RouteStartEndPickerController.h"
#import "ChoicePickerViewController.h"

#import "UIDownPicker.h"
#import "TitleTextInputCell.h"
#import "TitleDetailCell.h"
#import "CheckableTitleCell.h"
#import "QRSeparatorCell.h"
#import "EventLocationPickerView.h"

#import "CheckableTitleItem.h"
#import "TitleDetailItem.h"
#import "TitleItem.h"
#import "TitleInputItem.h"
#import "TitleDateItem.h"
#import "TitleDetailTextItem.h"

#import "ToastView.h"

#import "CommonDefine.h"
#import "Masonry.h"

#import "EventModelPathManager.h"
#import "TextPickerViewController.h"

#import "EventHttpManager.h"
#import "HttpBaseModel.h"

@interface EventReportViewController()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *btnUpload;
    UIButton *btnSaveLocal;
    EventLocationPickerView *lPicker;
}
@property (nonatomic,strong)     UITableView *eventTableView;
@end

@implementation EventReportViewController

-(instancetype) initWithModel:(EventReportModel *) model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupModel];
    [self setupSubViews];
    [self addObservers];
    
}

-(void) setupModel
{
    if (_model) {
        return;
    }
    
    NSString *path = [EventModelPathManager lastestEventPath];
    if (path && [[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData * data= [NSData dataWithContentsOfFile:path];
        self.model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
    }else
    {
        self.model = [EventReportModel new];
        self.model.eventName = [TitleInputItem itemWithTitle:@"事件名称" placeholder:@"请输入事件名称"];
        self.model.eventType = [TitleDetailItem itemWithTitle:@"事件类型" detail:@"未填写"];
        self.model.eventXingzhi = [TitleDetailItem itemWithTitle:@"事件性质" detail:@"未填写"];
        self.model.level = [TitleDetailItem itemWithTitle:@"等级初判" detail:@"未填写"];
        self.model.reason = [TitleDetailItem itemWithTitle:@"初步原因" detail:@"未填写"];
        
        
        self.model.eventDate = [TitleDateItem itemWithTitle:@"事发时间"];
        self.model.place = [TitleInputItem itemWithTitle:@"事发地点" placeholder:@"请输入地点名称"];
        
        self.model.department = [TitleInputItem itemWithTitle:@"填报部门" placeholder:@"请输入部门名称"];
        self.model.reporter = [TitleInputItem itemWithTitle:@"填报人员" placeholder:@"请输入人员名称"];
        self.model.eventStatus = [TitleDetailTextItem itemWithTitle:@"事件情况" detail:@"未填写" text:@""];
        self.model.eventPreprocess = [TitleDetailTextItem itemWithTitle:@"先期处置情况" detail:@"未填写"  text:@""];
        self.model.eventPic = [NSMutableArray arrayWithCapacity:6];
    }
}
-(void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyDatePicker:) name:@"DatePickerNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaRemove:) name:@"ItemRemovedNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textPicked:) name:@"TextPickerNotification" object:nil];
    
}

-(void) notifyDatePicker:(NSNotification *)noti
{
    NSDate * date = (NSDate *)[noti userInfo][@"date"];
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setDateFormat:@"YYYY-MM-dd"];
//    NSString *str=[outputFormatter stringFromDate:date];
    
    self.model.eventDate.date = date;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
    [self.eventTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

-(void) setupSubViews
{
    self.title = @"突发事件上报";
    
    self.eventTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.eventTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.eventTableView.backgroundColor = [UIColor whiteColor];
    self.eventTableView.delegate = self;
    self.eventTableView.dataSource = self;
    self.eventTableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    
    if (!_readonly) {
        self.eventTableView.tableFooterView = [self footerView];
    }
    
    [self.view addSubview:self.eventTableView];
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:15 inSection:0];
    
    __weak __typeof(self) weakself = self;
    mPicker = [[EventMediaPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70) readOnly:_readonly picCallback:^{
        [weakself openPicMenu];
    } videoCallback:^{
        [weakself openVideoMenu];
    } relayoutCallback:^{
        [self.eventTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }];
    
    lPicker = [[EventLocationPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60) readOnly:_readonly callBack:^{
        RouteStartEndPickerController *vc = [[RouteStartEndPickerController alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    
    
    [mPicker setImages:self.model.eventPic];
    [mPicker setVideo:self.model.eventVideo];
    [mPicker relayout];
    
    [self.eventTableView reloadData];
}

-(UIView*) footerView
{
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kScreenWidth, 16*3+40*2);
    btnUpload = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSaveLocal = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnUpload.backgroundColor = UI_COLOR(0xFF,0x82,0x47);
    [btnUpload setTitle:@"完成并上报" forState:UIControlStateNormal];
    [btnUpload setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnUpload.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    btnSaveLocal.backgroundColor = [UIColor blueColor];
    [btnSaveLocal setTitle:@"保存至本地" forState:UIControlStateNormal];
    [btnSaveLocal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSaveLocal.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [btnUpload addTarget:self action:@selector(actionUpload:) forControlEvents:UIControlEventTouchUpInside];
    [btnSaveLocal addTarget:self action:@selector(actionSaveLocal:) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:btnUpload];
    [footer addSubview:btnSaveLocal];
    
    CGFloat margin = 50;
    __weak UIView* weakView = footer;
    [btnUpload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(16);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    [btnSaveLocal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnUpload.mas_bottom).offset(16);
        make.height.mas_equalTo(40);
        
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    return footer;
}


-(void) actionUpload:(id) sender
{
    NSLog(@"upload");
    
    [[EventHttpManager sharedManager] requestNewEvent:self.model successCallback:^(NSURLSessionDataTask *task, id dict) {
        //todo
        HttpBaseModel *item = [HttpBaseModel objectWithKeyValues:dict];
        if (item.success)
        {
            [self deleteCache];
            if (self.model.eventPic.count>0 || self.model.eventVideo != nil) {
                
                if (self.model.eventPic.count>0) {
                    for (UIImage *image in self.model.eventPic) {
                        [[EventHttpManager sharedManager] requestUploadAttachment:image fkid:self.model.uuid successCallback:nil failCallback:nil];
                    }
                }
                
                if (self.model.eventVideo)
                {
                    [[EventHttpManager sharedManager] requestUploadAttachmentMovie:self.model.eventVideo fkid:self.model.uuid successCallback:nil failCallback:nil];

                }
            }
            [ToastView popToast:@"上报成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
            

        }else if (item.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
       
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        //todo
    }];
    return;
}

-(void) deleteCache
{
    NSString *path = [NSString stringWithFormat:@"%@/event.data",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        NSLog(@"delete local save");
    }
}
-(void) actionSaveLocal:(id) sender
{
    UIButton *btn = sender;
    btn.enabled = NO;
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
    NSString *path = [NSString stringWithFormat:@"%@/event%@.data",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],self.model.eventName.detail?:@""];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    [data writeToFile:path atomically:YES];
    [EventModelPathManager addEventModelWithPath:path];
    
    [ToastView popToast:@"保存成功"];
    btn.enabled = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 5 || row == 9 || row == 14) {
        return 8;
    }
    if (row == 8) { //location picker
        return lPicker.frame.size.height;
    }
    if (row == 15) { //image picker
        return mPicker.frame.size.height;
    }
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 16;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCell"];
            }
            cell.data = self.model.eventName;
            cell.readOnly = _readonly;
            return cell;
        }
        case 1:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = self.model.eventType;
            cell.readOnly = _readonly;
            return cell;
        }
        case 2:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = self.model.eventXingzhi;
            cell.readOnly = _readonly;
            return cell;
        }
        case 3:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = self.model.level;
            cell.readOnly = _readonly;
            return cell;
        }
        case 4:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = self.model.reason;
            cell.readOnly = _readonly;
            return cell;
        }
        case 5:
        case 9:
        case 14:
        {
            QRSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separatorCell"];
            if (!cell) {
                cell = [[QRSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"separatorCell"];
            }
            return cell;
        }
        case 6:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = self.model.eventDate;
            cell.readOnly = _readonly;
            return cell;
        }
        case 7:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCell"];
            }
            cell.data = self.model.place;
            cell.readOnly = _readonly;
            return cell;
        }
        case 8:
        {
            [lPicker removeFromSuperview];
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EventLocationPickerCell"];
            [cell.contentView addSubview:lPicker];
            return cell;
        }
        case 10:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCell"];
            }
            cell.data = self.model.department;
            cell.readOnly = _readonly;
            return cell;
        }
        case 11:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCell"];
            }
            cell.data = self.model.reporter;
            cell.readOnly = _readonly;
            return cell;
        }
        case 12:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = self.model.eventStatus;
            cell.readOnly = _readonly;
            return cell;
        }
        case 13:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = self.model.eventPreprocess;
            cell.readOnly = _readonly;
            return cell;
        }
        case 15:
        {
            [mPicker removeFromSuperview];
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EventMediaPickerCell"];
            [cell.contentView addSubview: mPicker];
            return cell;
        }
        
        default:
            break;
    }
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_readonly) {
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    switch (indexPath.row) {
        case 0:
        case 5:
        case 9:
        case 14:
        case 7:
        case 8:
        case 10:
        case 11:
        case 15:
        {
            break;
        }
        case 1: //eventType
        {
            NSArray *choices = @[@"水质污染",@"工程安全",@"应急调度",@"防汛抢险"];
            ChoicePickerViewController *vc = [[ChoicePickerViewController alloc] initWithChoices:choices saveCallback:^(NSDictionary *dict) {
                NSString *choice = dict[@"choice"];
                weakSelf.model.eventType.detail = choice;
                [weakSelf.eventTableView reloadData];
            }];
            [self.navigationController pushViewController:vc animated:YES];
            break;
            
        }
        case 2: //eventXingzhi
        {
            NSArray *choices = @[@"水质污染",@"工程损害",@"机电故障"];
            ChoicePickerViewController *vc = [[ChoicePickerViewController alloc] initWithChoices:choices saveCallback:^(NSDictionary *dict) {
                NSString *choice = dict[@"choice"];
                weakSelf.model.eventXingzhi.detail = choice;
                [weakSelf.eventTableView reloadData];
            }];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3: //level
        {
            NSArray *choices = @[@"一级响应",@"二级响应",@"三级响应"];
            ChoicePickerViewController *vc = [[ChoicePickerViewController alloc] initWithChoices:choices saveCallback:^(NSDictionary *dict) {
                NSString *choice = dict[@"choice"];
                weakSelf.model.level.detail = choice;
                [weakSelf.eventTableView reloadData];
            }];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4: //reason
        {
            NSArray *choices = @[@"人为",@"原因二",@"原因三"];
            ChoicePickerViewController *vc = [[ChoicePickerViewController alloc] initWithChoices:choices saveCallback:^(NSDictionary *dict) {
                NSString *choice = dict[@"choice"];
                weakSelf.model.reason.detail = choice;
                [weakSelf.eventTableView reloadData];
            }];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6: //eventDate
        {
            NSDate *date = self.model.eventDate.date;
            DatePickViewController *pickerVC = [[DatePickViewController alloc] initWithDate:date];
            [self.navigationController pushViewController:pickerVC animated:YES];
            break;
        }
        case 12:
        {
            TextPickerViewController *vc = [[TextPickerViewController alloc] initWithData:self.model.eventStatus readOnly:_readonly];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 13:
        {
            TextPickerViewController *vc = [[TextPickerViewController alloc] initWithData:self.model.eventPreprocess readOnly:_readonly];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        
            
        default:
            break;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

-(void) setReadonly:(BOOL)readonly
{
    _readonly = readonly;
    [_eventTableView reloadData];
}


-(void) textPicked:(NSNotification *)noti
{
    [self.eventTableView reloadData];
}
@end
