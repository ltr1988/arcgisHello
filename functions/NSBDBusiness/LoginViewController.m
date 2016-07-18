//
//  LoginViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LoginViewController.h"
#import "MapViewController.h"

@interface LoginViewController()
{
}

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (IBAction)actionLogin:(id)sender {
    MapViewController *controller = [MapViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];

}

-(BOOL)hideNavBar
{
    return YES;
}

-(void) setupSubviews
{
    _loginBtn.layer.cornerRadius = 5;
    
}

@end
