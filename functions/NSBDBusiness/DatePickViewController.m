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

-(BOOL)navigationShouldPopOnBackButton
{
    NSDictionary *userInfo = @{@"date":date};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DatePickerNotification" object:nil userInfo:userInfo];
    return YES;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
    date = [NSDate date];
}

-(void) setupSubViews
{
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
