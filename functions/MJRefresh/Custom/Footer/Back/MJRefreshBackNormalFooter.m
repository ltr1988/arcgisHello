//
//  MJRefreshBackNormalFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//
#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif
#import "MJRefreshBackNormalFooter.h"

@interface MJRefreshBackNormalFooter()
{
    __unsafe_unretained UIImageView *_arrowView;
    CABasicAnimation *rotationAnimation;
    BOOL animationFinish;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation MJRefreshBackNormalFooter
#pragma mark - 懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        //UIImage *image = [UIImage imageNamed:MJRefreshSrcName(@"card_refresh.png")] ?: [UIImage imageNamed:MJRefreshFrameworkSrcName(@"card_refresh.png")];
        UIImageView *arrowView = [[UIImageView alloc] init];
        arrowView.frame = CGRectMake(0, 0, 22, 22);
        [arrowView setQR_imagePicker:QRThemeImageWithKey(kGlobalQRImagePullDownRefresh)];
        [self addSubview:_arrowView = arrowView];
        //先隐藏
        self.arrowView.hidden = YES;
    }
    return _arrowView;
}


//- (UIActivityIndicatorView *)loadingView
//{
//    if (!_loadingView) {
//        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
//        loadingView.hidesWhenStopped = YES;
//        [self addSubview:_loadingView = loadingView];
//    }
//    return _loadingView;
//}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}
#pragma makr - 重写父类的方法
- (void)prepare
{
    [super prepare];
    self.stateLabel.hidden = YES;
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= 100;
    }
    CGFloat arrowCenterY = self.mj_h * 0.49;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.center = arrowCenter;
    }
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            [self stopRotateInfinitly];
            if (self.MJRefreshFooterEndRefreshingCustom) {
                [self setTitle:self.MJRefreshFooterEndRefreshingCustom forState:MJRefreshStateIdle];
            }
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
//                
//                self.arrowView.hidden = YES;
            }];
        } else {
            [self.loadingView stopAnimating];
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
               
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        self.arrowView.hidden = YES;
        [self.loadingView stopAnimating];
        
    } else if (state == MJRefreshStateRefreshing) {
        self.stateLabel.hidden = NO;
        self.arrowView.hidden = NO;
        [self rotateInfinitly];
        [self.loadingView startAnimating];
    } else if (state == MJRefreshStateNoMoreData) {
        self.arrowView.hidden = YES;
        self.stateLabel.hidden = NO;
        [self.loadingView stopAnimating];
    }
}
- (void)stopRotateInfinitly
{
    //每次remove后改变状态值
    [self.arrowView.layer removeAnimationForKey:@"rotationAnimation"];
    self.arrowView.hidden = YES;
    //每次remove后改变状态值
    animationFinish = YES;
}

- (void)startRotateInfinitly
{
    [self rotateInfinitly];
}

- (void)rotateInfinitly
{
    if (!rotationAnimation) {
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    }
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 0.5f;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.delegate = self;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.arrowView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    //每次启动动画改变状态值
    animationFinish = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (animationFinish) {
        QLog(@"自然结束\n\n\n\n");
        rotationAnimation.delegate = nil;
        [self.arrowView.layer removeAllAnimations];
    }
    if (!animationFinish) {
        [self rotateInfinitly];
    }
}
- (void)willMoveToSuperview:(nullable UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    rotationAnimation.delegate = nil;
    [self.arrowView.layer removeAllAnimations];
}

@end
