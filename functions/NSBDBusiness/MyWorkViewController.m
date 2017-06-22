//
//  MyWorkViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/31.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyWorkViewController.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "UIColor+ThemeColor.h"
#import "MyEventViewController.h"
#import "MyUploadEventViewController.h"
#import "SearchHistoryHomeViewController.h"
#import "MyDealedEventViewController.h"
#import "MyChuanKuaYueHomeViewController.h"
#import "DistanceMapViewController.h"
#import "TrackLocationManager.h"
#import "AuthorizeManager.h"

@interface MyWorkViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myworkTableView;
@property (nonatomic,strong) NSArray *modelList;
@end

@implementation MyWorkViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupModel];
    [self setupSubviews];
}

-(void) setupModel
{
    _modelList = @[@"待办应急事件",@"我的处置任务",@"我的事件上报",@"历史巡查记录",@"穿跨越工程",@"测距",@"修改密码"];
    
//    CFRunLoopObserverRef  observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//        
//        switch (activity) {
//            case kCFRunLoopEntry:
//                NSLog(@"kCFRunLoopEntry");
//                break;
//            case  kCFRunLoopBeforeTimers:
//                NSLog(@"kCFRunLoopBeforeTimers");
//                break;
//            case kCFRunLoopBeforeSources:
//                NSLog(@"kCFRunLoopBeforeSources");
//                break;
//            case kCFRunLoopBeforeWaiting:
//                NSLog(@"kCFRunLoopBeforeWaiting");
//                break;
//            case kCFRunLoopAfterWaiting:
//                NSLog(@"kCFRunLoopAfterWaiting");
//                break;
//            case kCFRunLoopExit:
//                NSLog(@"kCFRunLoopExit");
//                break;
//            default:
//                break;
//        }
//    });
//    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
//    // 释放对象
//    CFRelease(observer);
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.title = @"更多";
    
    self.myworkTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myworkTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.myworkTableView.backgroundColor = [UIColor whiteColor];
    self.myworkTableView.delegate = self;
    self.myworkTableView.dataSource = self;
    self.myworkTableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    
    self.myworkTableView.tableFooterView = [self footerView];
    
    [self.view addSubview:self.myworkTableView];
    

    [self.myworkTableView reloadData];
    
}

-(UIView*) footerView
{
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kScreenWidth, 16*2+40);
    UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnLogout.backgroundColor = [UIColor themeBlueColor];
    [btnLogout setTitle:@"退出登录" forState:UIControlStateNormal];
    [btnLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogout.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [btnLogout addTarget:self action:@selector(actionLogout:) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:btnLogout];
    CGFloat margin = 50;
    __weak UIView* weakView = footer;
    [btnLogout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(16);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(weakView.mas_left).offset(margin);
        make.right.mas_equalTo(weakView.mas_right).offset(0-margin);
    }];
    
    return footer;
}

-(void) actionLogout:(id) sender
{
    
    [[TrackLocationManager sharedInstance] stopTracking];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark --tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    
    if (row < _modelList.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _modelList[row];
        return cell;
    }
    
    
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            MyEventViewController *vc = [[MyEventViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            MyDealedEventViewController *vc = [[MyDealedEventViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            MyUploadEventViewController *vc = [[MyUploadEventViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            SearchHistoryHomeViewController *vc = [[SearchHistoryHomeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            MyChuanKuaYueHomeViewController *vc = [[MyChuanKuaYueHomeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            DistanceMapViewController *vc = [[DistanceMapViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            //修改密码
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = @"原密码";
                textField.secureTextEntry = YES;
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
            }];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"新密码";
                textField.secureTextEntry = YES;
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
            }];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"确认密码";
                textField.secureTextEntry = YES;
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
            }];
            __weak __typeof(self) weakself = self;
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                
                UITextField *originPsw = alertController.textFields.firstObject;
                UITextField *newPsw = alertController.textFields[1];
                UITextField *confirmPsw = alertController.textFields[2];
                
                BOOL validPsw = [originPsw.text isEqualToString:[AuthorizeManager sharedInstance].userPsw] && [newPsw.text isEqualToString: confirmPsw.text] &&newPsw.text.length>0;
                
                if (validPsw) {
                    [weakself requestChangePassword:newPsw.text];
                }
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)alertTextFieldDidChange:(NSNotification *)notification
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *originPsw = alertController.textFields.firstObject;
        UITextField *newPsw = alertController.textFields[1];
        UITextField *confirmPsw = alertController.textFields[2];
        
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = [originPsw.text isEqualToString:[AuthorizeManager sharedInstance].userPsw] && [newPsw.text isEqualToString: confirmPsw.text] &&newPsw.text.length>0;
    }
}

-(void) requestChangePassword:(NSString *)password
{
    NSLog(@"requestChangePassword");
}

@end
