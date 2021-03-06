//
//  MapViewController+Action.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MapViewController+Action.h"
#import "MapViewController.h"
#import "EventReportViewController.h"
#import "QRCodeReaderViewController.h"
#import "ImagePickerViewController.h"
#import "WebViewController.h"
#import "RouteStartEndPickerController.h"
#import "SearchChoiceController.h"
#import "SearchStartViewController.h"
#import "SearchSessionManager.h"
#import "SearchHomePageViewController.h"
#import "MyWorkViewController.h"
#import "TextPickerViewController.h"
#import "LiveDataMainViewController.h"
#import "Home3DViewController.h"
#import "SearchSessionStateModel.h"
#import "SearchSessionItem.h"

@implementation MapViewController (Action)

-(void) naviToPoint:(AGSPoint *)point desc:(NSString *)desc
{
    RouteStartEndPickerController *vc =[[RouteStartEndPickerController alloc] init];
    vc.endPoint = point;
    vc.endPointDesc = desc;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) actionNavi
{
    RouteStartEndPickerController *vc =[[RouteStartEndPickerController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - bottom view actions
-(void) actionSearchUpload
{
    __weak SearchSessionManager* manager = [SearchSessionManager sharedManager];
    [manager requestQueryTaskFinishedStatusWithSuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        SearchSessionStateModel *model = [SearchSessionStateModel objectWithKeyValues:dict];
        if (model.success) {
            if(!model.sessionId || model.sessionId.length == 0)
            {
                //无session
                SearchStartViewController *vc = [[SearchStartViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                //有session
            
                if ([[SearchSessionManager sharedManager] hasSession] && [manager.session.sessionId isEqualToString:model.sessionId]) {
                    
                }else
                {
                    [manager setNewSessionWithId:model.sessionId];
                }
                SearchChoiceController *vc = [[SearchChoiceController alloc] init];
                vc.definesPresentationContext = YES;
                vc.providesPresentationContextTransitionStyle = YES;
                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                vc.delegate = self;
                [self presentViewController:vc animated:YES completion:nil];
            }    
            
        }else if (model.status == HttpResultInvalidUser)
        {
            [ToastView popToast:@"您的帐号在其他地方登录"];
        }
        else
        {
            if (dict[@"msg"]) {
                [ToastView popToast:dict[@"msg"]];
            }else
                [ToastView popToast:@"获取任务信息失败,请稍候再试"];
        }
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        [ToastView popToast:@"获取任务信息失败,请稍候再试"];
    }];
}

-(void) actionEventUpload
{
    EventReportViewController *controller = [[EventReportViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) actionLiveData
{
    LiveDataMainViewController *controller = [[LiveDataMainViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) action3D
{
    Home3DViewController *vc = [Home3DViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void) actionQRCodeSwipe
{
    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
    reader.delegate = self;
    [self.navigationController pushViewController:reader animated:YES];

}

-(void) actionPlus
{
    [self.mapView zoomIn:YES];
}

-(void) actionMinus
{
    [self.mapView zoomOut:YES];
}

-(void) actionSwitchMapType:(id)sender
{
    UIButton *btn = sender;
    
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.2;
    
    //设置运动type
    animation.type = @"oglFlip";
    
    animation.subtype = kCATransitionFromLeft;
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [btn.layer addAnimation:animation forKey:@"animation"];
    
    if (self.mapView.baseLayerType == NSBD_NORMAL) {
//        [btn setTitle:@"电子" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_mapchange1"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_mapchange1"] forState:UIControlStateHighlighted];
    }else
    {
//        [btn setTitle:@"影像" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_mapchange"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_mapchange"] forState:UIControlStateHighlighted];
    }
    
    [self.mapView switchLayerType];
}

-(void) actionSwitch3DMaishenType:(id)sender
{
    UIButton *btn = sender;
    
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.2;
    
    //设置运动type
    animation.type = @"oglFlip";
    
    animation.subtype = kCATransitionFromLeft;
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [btn.layer addAnimation:animation forKey:@"animation"];
    
    if (self.mapView.layerMask & LayerMask3DLayer) {
        self.mapView.layerMask = self.mapView.layerMask ^ LayerMask3DLayer;
        
        [btn setImage:[UIImage imageNamed:@"icon_maishen"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_maishen"] forState:UIControlStateHighlighted];
    }else
    {
        self.mapView.layerMask = self.mapView.layerMask | LayerMask3DLayer;
        
        [btn setImage:[UIImage imageNamed:@"icon_maishen_click"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_maishen_click"] forState:UIControlStateHighlighted];
    }
    
    [self.mapView reloadLayers];
}

-(void) actionMyLocation
{
    [self.mapView locate];
}

-(void) actionMyWork
{
    
    MyWorkViewController *controller = [[MyWorkViewController alloc] init];
    //ImagePickerViewController *controller = [[ImagePickerViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark choice modal vc delegate
-(void) dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) endSession
{
    __weak __typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        
        SearchStartViewController *vc = [[SearchStartViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

-(void) continueSession
{
    __weak __typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        SearchHomePageViewController * vc = [[SearchHomePageViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self.navigationController popViewControllerAnimated:YES];
    [[[UIAlertView alloc] initWithTitle:@"" message:result delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
