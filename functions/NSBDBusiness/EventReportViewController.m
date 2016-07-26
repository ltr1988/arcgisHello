//
//  EmergencyReportViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventReportViewController.h"
#import "UIDownPicker.h"
#import "EventReportModel.h"
#import "TitleTextInputCell.h"
#import "TitleDetailCell.h"
#import "CheckableTitleCell.h"
#import "QRSeparatorCell.h"
#import "EventMediaPickerView.h"
#import "EventLocationPickerView.h"

#import "CheckableTitleItem.h"
#import "TitleDetailItem.h"
#import "TitleItem.h"

@interface EventReportViewController()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *eventTableView;
    EventMediaPickerView *mPicker;
    EventLocationPickerView *lPicker;
    EventReportModel *model;
}
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
    model = [EventReportModel new];
    model.eventName = [TitleInputItem itemWithTitle:@"事件名称" placeholder:@"请输入事件名称"];
    model.eventType = [TitleDetailItem itemWithTitle:@"事件类型" detail:@"未填写"];
    model.eventXingzhi = [TitleDetailItem itemWithTitle:@"事件性质" detail:@"未填写"];
    model.level = [TitleDetailItem itemWithTitle:@"等级初判" detail:@"未填写"];
    model.reason = [TitleDetailItem itemWithTitle:@"初步原因" detail:@"未填写"];
    
    
    model.eventDate = [TitleDateItem itemWithTitle:@"事发时间"];
    model.place = [TitleInputItem itemWithTitle:@"事发地点" placeholder:@"请输入地点名称"];
    
    model.department = [TitleInputItem itemWithTitle:@"填报部门" placeholder:@"请输入部门名称"];
    model.reporter = [TitleInputItem itemWithTitle:@"填报人员" placeholder:@"请输入人员名称"];
    model.eventStatus = [TitleDetailItem itemWithTitle:@"事件情况" detail:@"未填写"];
    model.eventPreprocess = [TitleDetailItem itemWithTitle:@"先期处置情况" detail:@"未填写"];
}
-(void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyDatePicker:) name:@"DatePickerNotification" object:nil];
}

-(void) notifyDatePicker:(NSNotification *)noti
{
    NSDate * date = (NSDate *)[noti userInfo][@"date"];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *str=[outputFormatter stringFromDate:date];
    TitleDetailCell *cell = [eventTableView dequeueReusableCellWithIdentifier:@"datePickerCell"];
    if (cell) {
        [cell.data setValue:str forKey:@"_detail"];
    }
}

-(void) setupSubViews
{
    self.title = @"突发事件上报";
    
    eventTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    eventTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    eventTableView.backgroundColor = [UIColor whiteColor];
    eventTableView.delegate = self;
    eventTableView.dataSource = self;
    eventTableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    [self.view addSubview:eventTableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 5 || row == 9 || row == 14) {
        return 8;
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
            cell.data = model.eventName;
            return cell;
        }
        case 1:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = model.eventType;
            return cell;
        }
        case 2:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = model.eventXingzhi;
            return cell;
        }
        case 3:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = model.level;
            return cell;
        }
        case 4:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = model.reason;
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
            cell.data = model.eventDate;
            return cell;
        }
        case 7:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCell"];
            }
            cell.data = model.place;
            return cell;
        }
        case 8:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventLocationPickerCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EventLocationPickerCell"];
            }
            return cell;
        }
        case 10:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCell"];
            }
            cell.data = model.department;
            return cell;
        }
        case 11:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCell"];
            }
            cell.data = model.reporter;
            return cell;
        }
        case 12:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = model.eventStatus;
            return cell;
        }
        case 13:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = model.eventPreprocess;
            return cell;
        }
        case 15:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventMediaPickerCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EventMediaPickerCell"];
            }
            return cell;
        }
        default:
            break;
    }
    return [UITableViewCell new];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
