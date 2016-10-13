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
#import "ToastView.h"

@interface LoginViewController()<UITextFieldDelegate>
{
}

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation LoginViewController
- (IBAction)actionForget:(id)sender {
    UIAlertView *alart = [[UIAlertView alloc] initWithTitle:nil message:@"请拨打xxx重置密码" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

    
    [alart show];
}

-(void)shakeView:(UIView*)viewToShake
{
    CGFloat t =4.0;
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
    
    //to be reset in normal condition
#ifdef NoServer
    _userNameField.text = @"abc";
#else
    if (!(_userNameField.text.length && _passwordField.text.length)) {
        [self shakeView:_loginBtn];
        return;
    }
#endif
    
    
    
    if (![AFNetworkReachabilityManager sharedManager].reachable)
    {
        [ToastView popToast:@"暂无网络，稍后再试"];
    }
    
    _loginBtn.enabled = YES;
    
    AuthorizeManager *manager =[AuthorizeManager sharedInstance];
    
    NSString *psw = [_passwordField.text copy];
    
    _passwordField.text = @"";
    [SVProgressHUD showWithStatus:@"登录中..."];
    [manager requestLoginWithUser:_userNameField.text password:psw callback:^(NSDictionary *dict) {
        BOOL success= [dict[@"success"] boolValue];

        dispatch_main_async_safe(^{
            if ([SVProgressHUD isVisible])
            {
                [SVProgressHUD dismiss];
            }
            if (success) {
                _loginBtn.enabled = YES;

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
    [super viewDidLoad];
    [self setupSubviews];

}

-(BOOL)hideNavBar
{
    return YES;
}

-(void) setupSubviews
{
    _contentView.layer.cornerRadius = 10;
    _contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _contentView.layer.shadowOpacity = 0.8;
    _contentView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _contentView.layer.shadowRadius = 4;//阴影半径，默认3
    _loginBtn.layer.cornerRadius = 5;
    _userNameField.text = [AuthorizeManager sharedInstance].userName?:@"";
    _userNameField.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    
    _userNameField.delegate = self;
    _passwordField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userNameField) {
        [_userNameField resignFirstResponder];
        [_passwordField becomeFirstResponder];
    }else
    {
        [textField resignFirstResponder];
        [self actionLogin:textField];
    }
    return YES;
}
-(BOOL) prefersStatusBarHidden
{
    return YES;
}
@end
