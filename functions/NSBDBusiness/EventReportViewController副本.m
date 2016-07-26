//
//  EmergencyReportViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventReportViewController.h"
#import "UIDownPicker.h"

@interface EventReportViewController()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf_eventName;
@property (weak, nonatomic) IBOutlet UIDownPicker *dp_EventType;


@property (weak, nonatomic) IBOutlet UITextField *tf_date;

@property (strong, nonatomic) UIDatePicker *datePicker;
@end

@implementation EventReportViewController


-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
}

-(void) setupSubViews
{
    
    _tf_date.delegate = self;
    _dp_EventType.DownPicker = [[DownPicker alloc] initWithTextField:_dp_EventType withData:@[@"choice1",@"choice2"]];
    
    _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 162)];
    _datePicker.datePickerMode=UIDatePickerModeDate;
    _datePicker.date=[NSDate date];
    
    [self.datePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
}

-(void)selectDate:(id)sender
{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *str=[outputFormatter stringFromDate:self.datePicker.date];
    self.tf_date.text=str;
    
    NSLog(@"%@",self.datePicker.date);
    NSLog(@"%@",str);
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.tf_date) {
        
        self.tf_date.inputView=self.datePicker;
        
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.tf_date) {
        
        self.tf_date.inputView=nil;
    }
    
    return YES;
}

@end
