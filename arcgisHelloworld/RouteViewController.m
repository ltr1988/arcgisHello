//
//  RouteViewController.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteViewController.h"
#import "RouteManager.h"

@interface RouteViewController()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfStart;
@property (weak, nonatomic) IBOutlet UITextField *tfEnd;


@end

@implementation RouteViewController


-(void) viewDidLoad
{
    [super viewDidLoad];
    _tfStart.delegate = self;
    _tfStart.placeholder = @"输入起点";
    _tfEnd.delegate = self;
    _tfEnd.placeholder = @"输入起点";
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    RouteManager *manager = [RouteManager sharedInstance];
    _tfStart.text = manager.startText?:@"";
    _tfEnd.text = manager.endText?:@"";

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.tabBarController setSelectedIndex:0];
    return NO;
}

@end
