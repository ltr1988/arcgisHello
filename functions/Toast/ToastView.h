//
//  ToastView.h
//  QQReaderUI-ipad
//
//  Created by zhaiguanghe on 16/5/27.
//  Copyright © 2016年 _tencent_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastView : UIView

+ (void)popToast:(nonnull NSString *)message;
+ (void)popSuccessToast:(nonnull NSString *)message;
+ (void)popFailureToast:(nonnull NSString *)message;

+ (void)popWebError;
+ (void)popToast:(nonnull NSString *)message fontSize:(CGFloat)fontSize;

@end
