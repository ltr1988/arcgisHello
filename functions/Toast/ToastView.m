//
//  ToastView.m
//  QQReaderUI-ipad
//
//  Created by zhaiguanghe on 16/5/27.
//  Copyright © 2016年 _tencent_. All rights reserved.
//

#import "ToastView.h"

#define ONE_LINE_SIZE 150
#define TWO_LINE_SIZE 170
#define CORNER_RADIUS 10

@interface ToastView () {
    BOOL          _isShowing;
    // metrics
    CGFloat       _iconSize;
    CGFloat       _iconMargin;
    CGFloat       _msgFontSize;
    CGFloat       _lineHeight;
    // subview
    UIImageView * _iconView;
    UILabel *     _msgLabel;
}

+ (ToastView *)sharedView;
- (instancetype)init;
- (void)initMetrics;
- (void)initSubviews;
- (void)layoutWithText:(nonnull NSString *)message fontSize:(CGFloat)fontSize;
- (void)layoutWithText:(nonnull NSString *)message iconName:(NSString *)iconName;
- (void)show;
- (void)hide;
- (void)showDuring:(NSTimeInterval)duration;
+ (NSTimeInterval)durationWithMessage:(NSString *)message;

@end

@implementation ToastView

+ (void)popToast:(nonnull NSString *)message {
    [[ToastView sharedView] layoutWithText:message iconName:nil];
    [[ToastView sharedView] showDuring:[ToastView durationWithMessage:message]];
}

+ (void)popSuccessToast:(NSString *)message {
    [[ToastView sharedView] layoutWithText:message iconName:@"toast_yes"];
    [[ToastView sharedView] showDuring:[ToastView durationWithMessage:message]];
}

+ (void)popFailureToast:(NSString *)message {
    [[ToastView sharedView] layoutWithText:message iconName:@"toast_no"];
    [[ToastView sharedView] showDuring:[ToastView durationWithMessage:message]];
}

+ (void)popWebError {
    [ToastView popFailureToast:@"网络异常\n请稍后重试"];
}

+ (void)popToast:(nonnull NSString *)message fontSize:(CGFloat)fontSize {
    [[ToastView sharedView] layoutWithText:message fontSize:fontSize];
    [[ToastView sharedView] showDuring:[ToastView durationWithMessage:message]];
}

+ (ToastView *)sharedView {
    static dispatch_once_t once;
    static ToastView *sharedView = nil;
    dispatch_once(&once, ^{
        sharedView = [[self alloc] init];
    });
    return sharedView;
}

- (instancetype)init {
    if (self = [super init]) {
        _isShowing = NO;
        [self initMetrics];
        [self initSubviews];
    }
    return self;
}

- (void)initMetrics {
    _iconSize    = 40;
    _iconMargin  = 5;
    _msgFontSize = 14;
    _lineHeight  = ceil(_msgFontSize * 1.2);
}

- (void)initSubviews {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    self.layer.cornerRadius = CORNER_RADIUS;
    
    _iconView = [[UIImageView alloc] init];
    _iconView.backgroundColor = [UIColor clearColor];
    [self addSubview:_iconView];
    
    _msgLabel = [[UILabel alloc] init];
    _msgLabel.textAlignment   = NSTextAlignmentCenter;
    _msgLabel.font            = [UIFont systemFontOfSize:_msgFontSize];
    _msgLabel.numberOfLines   = 2;
    _msgLabel.textColor       = [UIColor whiteColor];
    _msgLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_msgLabel];
}

- (void)layoutWithText:(nonnull NSString *)message fontSize:(CGFloat)fontSize {
    @synchronized (self) {
        _iconView.image  = nil;
        _iconView.hidden = YES;
        _msgLabel.text   = message;
        _msgLabel.font   = [UIFont systemFontOfSize:fontSize];
        
        CGFloat lineHeight  = ceil(fontSize * 1.2);
        CGSize fitSize = [_msgLabel sizeThatFits:CGSizeMake(ONE_LINE_SIZE, lineHeight)];
        BOOL oneLineMode = (fitSize.height <= lineHeight);
        CGFloat mainSize = oneLineMode? ONE_LINE_SIZE: TWO_LINE_SIZE;
        CGFloat labelHeight = (oneLineMode? 1: 2) * lineHeight;
        
        self.frame = CGRectMake(0, 0, mainSize, mainSize);
        _iconView.frame = CGRectZero;
        _msgLabel.frame = CGRectMake((mainSize - ONE_LINE_SIZE) / 2, (mainSize - labelHeight) / 2, ONE_LINE_SIZE, labelHeight);
    }
}

- (void)layoutWithText:(NSString *)message iconName:(NSString *)iconName {
    @synchronized (self) {
        if (0 == iconName.length) {
            [self layoutWithText:message fontSize:_msgFontSize];
            return;
        }
        
        _iconView.image  = [UIImage imageNamed:iconName];
        _iconView.hidden = NO;
        _msgLabel.text   = message;
        _msgLabel.font   = [UIFont systemFontOfSize:_msgFontSize];
        
        CGSize fitSize = [_msgLabel sizeThatFits:CGSizeMake(ONE_LINE_SIZE, _lineHeight)];
        BOOL oneLineMode = (fitSize.height <= _lineHeight);
        CGFloat mainSize = oneLineMode? ONE_LINE_SIZE: TWO_LINE_SIZE;
        CGFloat labelHeight = (oneLineMode? 1: 2) * _lineHeight;
        CGFloat contentHeight = _iconSize + _iconMargin + labelHeight;
        
        self.frame = CGRectMake(0, 0, mainSize, mainSize);
        _iconView.frame = CGRectMake((mainSize - _iconSize) / 2, (mainSize - contentHeight) / 2, _iconSize, _iconSize);
        _msgLabel.frame = CGRectMake((mainSize - ONE_LINE_SIZE) / 2, CGRectGetMaxY(_iconView.frame) + _iconMargin, ONE_LINE_SIZE, labelHeight);
    }
}

- (void)show {
    @synchronized (self) {
        if (_isShowing) {
            [ToastView cancelPreviousPerformRequestsWithTarget:self];
        }
        // Add to window
        if (!self.superview) {
            [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        } else {
            [self.superview bringSubviewToFront:self];
        }
        // Location center
        self.center = self.superview.center;
        // Animate
        if (!_isShowing) {
            _isShowing = YES;
            self.alpha = 0;
            [UIView animateWithDuration:0.2 animations:^{
                self.alpha = 1;
            } completion:nil];
        }
    }
}

- (void)hide {
    @synchronized (self) {
        if (!_isShowing) {
            return;
        }
        // Animate
        self.alpha = 1;
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            _isShowing = NO;
        }];
    }
}

- (void)showDuring:(NSTimeInterval)duration {
    [[ToastView sharedView] show];
    [[ToastView sharedView] performSelector:@selector(hide) withObject:nil afterDelay:duration];
}

+ (NSTimeInterval)durationWithMessage:(NSString *)message {
    return MIN(0.5 + [message length] * 0.1, 2);
}

@end
