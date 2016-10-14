//
//  QRSystemAlertController.m
//  QQReaderUI-ipad
//
//  Created by Satte on 16/6/17.
//  Copyright © 2016年 _tencent_. All rights reserved.
//

#import "QRSystemAlertController.h"
#import "AppDelegate.h"
#import "CommonDefine.h"
#import <objc/runtime.h>

static NSInteger const cancelIndex = 0;
static NSInteger const otherIndex = 1;

@implementation QRSystemAlertController

#pragma mark - Assist Function

+ (void)presentAlertController:(UIAlertController *)alertController toViewController:(UIViewController *)viewController
{
    if (viewController)
    {
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        [[self getPresentViewController] presentViewController:alertController animated:YES completion:nil];
    }
}

+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (UIWindow *)getAppKeyWindow
{
    return [[UIApplication sharedApplication] keyWindow];
}

+ (UIViewController *)getPresentViewController
{
    // 如果当前keywindow不是delegatewindow,说明当前有POP形式的VC by YanTao
    if ([self getAppKeyWindow] == [[self getAppDelegate] window])
    {
        return [[[[self getAppDelegate] window] rootViewController].navigationController topViewController];
    }
    else
    {
        return AppMainWindow.rootViewController;
    }
}

#pragma mark - Alert View

+ (void)showAlertWithTitle:(NSString * _Nonnull)title message:(NSString * _Nullable)message cancelButtonTitle:(NSString * _Nonnull)cancelTitle otherButtonTitle:(NSString * _Nullable)otherTitle completionBlock:(QRAlertCompletionBlock _Nullable)block
{
    [self showAlertWithViewController:nil title:title message:message cancelButtonTitle:cancelTitle otherButtonTitle:otherTitle completionBlock:block];
}

+ (void)showAlertWithViewController:(UIViewController * _Nullable)viewController title:(NSString * _Nonnull)title message:(NSString * _Nullable)message cancelButtonTitle:(NSString * _Nonnull)cancelTitle otherButtonTitle:(NSString * _Nullable)otherTitle completionBlock:(QRAlertCompletionBlock _Nullable)block
{
    if (IS_IOS_8)
    {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        if (cancelTitle)
        {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *alertAction)
                                           {
                                               if (block)
                                               {
                                                   block(cancelIndex);
                                               }
                                           }];
            [alertVC addAction:cancelAction];
        }
        if (otherTitle)
        {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAction)
                                          {
                                              if (block)
                                              {
                                                  block(otherIndex);
                                              }
                                          }];
            [alertVC addAction:otherAction];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentAlertController:alertVC toViewController:viewController];
        });
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message completionBlock:block cancelButtonTitle:cancelTitle otherButtonTitle:otherTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView show];
        });
    }
}
@end

@implementation UIAlertView (BlockExtension)

- (id)initWithTitle:(NSString*)title message:(NSString*)message completionBlock:(void (^)(NSUInteger buttonIndex))block cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle
{
    if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil])
    {
        objc_setAssociatedObject(self, "blockCallback", block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return self;
}


- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^block)(NSUInteger buttonIndex) = objc_getAssociatedObject(self, "blockCallback");
    if (block)
    {
        block(buttonIndex);
    }
    objc_setAssociatedObject(self, "blockCallback", nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
