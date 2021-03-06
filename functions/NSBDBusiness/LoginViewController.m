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
#import "AFNetworkActivityIndicatorManager.h"
#import "SearchSessionManager.h"
#import "TrackLocationManager.h"
#import "ImageContentViewController.h"
#import "QRSystemAlertController.h"

@interface LoginViewController()<UITextFieldDelegate>
{
    
    CLLocationManager *manager;
}

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation LoginViewController

- (IBAction)actionForget:(id)sender {
    UIAlertView *alart = [[UIAlertView alloc] initWithTitle:nil message:@"重置密码请拨打010-62929966" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

    
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
    
#ifdef NoServer
    _userNameField.text = @"abc";
#else
    if (!(_userNameField.text.length && _passwordField.text.length)) {
        [self shakeView:_loginBtn];
        return;
    }
#endif
    
    
    _loginBtn.enabled = YES;
    
    NSString *psw = [_passwordField.text copy];
    
    _passwordField.text = @"";
    [SVProgressHUD showWithStatus:@"登录中..."];
    [[AuthorizeManager sharedInstance] requestLoginWithUser:_userNameField.text password:psw callback:^(NSDictionary *dict) {
        BOOL success= [dict[@"success"] boolValue];
        __block NSString *tip = dict[@"tip"];
        __block NSString *code = dict[@"code"];

        dispatch_main_async_safe(^{
            if ([SVProgressHUD isVisible])
            {
                [SVProgressHUD dismiss];
            }
            _loginBtn.enabled = YES;
//#warning to be deleted
//            code = @"11";
            if (success && [code isEqualToString:@"11"]) {
                if ([SearchSessionManager sharedManager]) {
                    [SearchSessionManager changeUser];
                    [[TrackLocationManager sharedInstance] startTracking];
                    
                }
                MapViewController *controller = [MapViewController new];
                [self.navigationController pushViewController:controller animated:YES];
            }else
            {
                NSLog(@"code:%@",code);

                if (code) {
// bindingcode：绑定状态码（success：未申请，00：待审核，11：审核通过，10：解绑，20：审核不通过，fail：绑定异常，）。
                    if ([code isEqualToString:@"success"] || [code isEqualToString:@"10"]) {
                        [QRSystemAlertController showAlertWithTitle:@"设备尚未绑定，是否申请绑定？" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"申请" completionBlock:^(NSUInteger buttonIndex)
                         {
                             if (buttonIndex == 1) {
                                 [[AuthorizeManager sharedInstance] requestBindDeviceWithCallback:^(NSDictionary *dict) {
                                     
                                     BOOL success= [dict[@"success"] boolValue];
                                     if (success) {
                                         [ToastView popToast:@"申请成功"];
                                     }else
                                     {
                                         [ToastView popToast:@"申请失败，请稍后再试"];
                                     }
                                 }];
                             }
                         }];
                    }else if ([code isEqualToString:@"fail"])
                    {
                        [ToastView popToast:@"绑定异常"];
                    }else
                    {
                        [ToastView popToast:tip];
                    }
                }else
                {
                    [self shakeView:_loginBtn];
                }
            }
        });
    }];

}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];

    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        manager = [[CLLocationManager alloc] init];
        [manager requestAlwaysAuthorization];
    }
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
