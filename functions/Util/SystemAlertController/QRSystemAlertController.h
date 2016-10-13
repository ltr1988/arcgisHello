//
//  QRSystemAlertController.h
//  QQReaderUI-ipad
//
//  Created by Satte on 16/6/17.
//  Copyright © 2016年 _tencent_. All rights reserved.
//

typedef void (^QRAlertCompletionBlock)(NSUInteger buttonIndex);

@interface UIAlertView (BlockExtension) <UIAlertViewDelegate>

- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message completionBlock:(void (^)(NSUInteger buttonIndex))block cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle;

@end

@interface QRSystemAlertController : NSObject

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle completionBlock:(QRAlertCompletionBlock)block;

+ (void)showAlertWithViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle completionBlock:(QRAlertCompletionBlock)block;

@end
