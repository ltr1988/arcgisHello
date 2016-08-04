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

@interface EventReportViewController()<UITableViewDelegate,UITableViewDataSource>
{

    EventLocationPickerView *lPicker;
}
@property (nonatomic,strong)     UITableView *eventTableView;
@end

@implementation EventReportViewController


-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
    [self addObservers];
    [self setupModel];
    
}
-(void) setupModel
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
    self.model.eventStatus = [TitleDetailItem itemWithTitle:@"事件情况" detail:@"未填写"];
    self.model.eventPreprocess = [TitleDetailItem itemWithTitle:@"先期处置情况" detail:@"未填写"];
    self.model.eventPic = [NSMutableArray arrayWithCapacity:6];
}
-(void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyDatePicker:) name:@"DatePickerNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaRemove:) name:@"ItemRemovedNotification" object:nil];
    
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
    [self.view addSubview:self.eventTableView];
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:15 inSection:0];
    
    __weak __typeof(self) weakself = self;
    mPicker = [[EventMediaPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70) picCallback:^{
        [weakself openPicMenu];
    } videoCallback:^{
        [weakself openVideoMenu];
    } relayoutCallback:^{
        [self.eventTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }];
    
    lPicker = [[EventLocationPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60) callBack:^{
        RouteStartEndPickerController *vc = [[RouteStartEndPickerController alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    
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

    return 17;
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
            return cell;
        }
        case 7:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCell"];
            }
            cell.data = self.model.place;
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
            return cell;
        }
        case 11:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCell"];
            }
            cell.data = self.model.reporter;
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
            NSArray *choices = @[@"t1",@"t2"];
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
            NSArray *choices = @[@"x1",@"x2"];
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
            NSArray *choices = @[@"l1",@"l2"];
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
            NSArray *choices = @[@"r1",@"r2"];
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
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = self.model.eventStatus;
        }
        case 13:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = self.model.eventPreprocess;
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
@end
