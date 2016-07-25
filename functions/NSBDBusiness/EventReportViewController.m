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

#import "CheckableTitleItem.h"
#import "TitleDetailItem.h"
#import "TitleItem.h"

@interface EventReportViewController()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *eventTableView;
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 17;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventNameCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"eventNameCell"];
            }
            cell.data = model.eventName;
            return cell;
        }
        case 1:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventNameCell"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"eventNameCell"];
            }
            cell.data = model.eventName;
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
