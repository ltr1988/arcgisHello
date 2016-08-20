//
//  LoginViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LoginViewController.h"
#import "MapViewController.h"
#import "AuthorizeManager.h"

@interface LoginViewController()
{
}

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

-(void)shakeView:(UIView*)viewToShake
{
    CGFloat t =2.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}
- (IBAction)actionLogin:(id)sender {
    if (!(_userNameField.text.length && _passwordField.text.length)) {
        [self shakeView:_loginBtn];
        return;
    }
    
    _loginBtn.enabled = NO;
    
    AuthorizeManager *manager =[AuthorizeManager sharedInstance];
    
    [manager requestLoginWithUser:_userNameField.text password:_passwordField.text callback:^(NSDictionary *dict) {
        BOOL success= [dict[@"success"] boolValue];
        manager.userName = _userNameField.text;
        dispatch_main_async_safe(^{
            if (success) {
                _loginBtn.enabled = YES;
                manager.department = [dict[@"success"] integerValue];
                
                
                MapViewController *controller = [MapViewController new];
                [self.navigationController pushViewController:controller animated:YES];
            }else
            {
                _loginBtn.enabled = YES;
                [self shakeView:_loginBtn];
            }
        });
    }];

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
    _userNameField.text = [AuthorizeManager sharedInstance].userName?:@"";
    
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}
@end
