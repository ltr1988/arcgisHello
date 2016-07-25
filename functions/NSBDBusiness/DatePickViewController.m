//
//  DatePickViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DatePickViewController.h"

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
    
    UIDatePicker *_datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 162)];
    _datePicker.datePickerMode=UIDatePickerModeDate;
    _datePicker.date=[NSDate date];
    
    [_datePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
}

-(void)selectDate:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    date = datePicker.date;
}

@end
