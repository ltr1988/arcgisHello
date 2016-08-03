//
//  DatePickViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DatePickViewController.h"
#import "Masonry.h"
#import "CommonDefine.h"

@interface  DatePickViewController()
{
    NSDate *date;
}

@end
@implementation DatePickViewController

-(instancetype) init
{
    self = [super init];
    if (self) {
        date= [NSDate date];
    }
    return self;
}

-(instancetype) initWithDate:(NSDate *)initDate
{
    self = [super init];
    if (self) {
        if (!initDate) {
            date= [NSDate date];
        }else
            date= initDate;
    }
    return self;
}

-(void)saveDate
{
    NSDictionary *userInfo = @{@"date":date};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DatePickerNotification" object:nil userInfo:userInfo];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
}

-(void) setupSubViews
{
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveDate)];
    [self.navigationItem setRightBarButtonItem:saveBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    UIDatePicker *_datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    _datePicker.datePickerMode=UIDatePickerModeDate;
    _datePicker.date=[NSDate date];
    
    [_datePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_datePicker];
    
    __weak UIView *weakView = self.view;
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.height.mas_equalTo(300);
        make.right.mas_equalTo(weakView.mas_right);
        make.left.mas_equalTo(weakView.mas_left);
    }];
}

-(void)selectDate:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    date = datePicker.date;
}

@end
