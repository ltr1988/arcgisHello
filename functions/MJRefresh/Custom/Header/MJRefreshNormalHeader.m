//
//  MJRefreshNormalHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//
#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "MJRefreshNormalHeader.h"
#import "ColorDefine.h"
#define DEGREES_TO_RADIANS(x) (x)/180.0*M_PI
#define RADIANS_TO_DEGREES(x) (x)/M_PI*180.0
@interface MJRefreshNormalHeader()
{
    __unsafe_unretained UIView *_arrowView;
    __weak UIImageView *_circleImage;
    CABasicAnimation *rotationAnimation;
    BOOL animationFinish;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) CAShapeLayer *arrowLayer;
@end

@implementation MJRefreshNormalHeader
#pragma mark - 懒加载子控件 （QQReader 替换 arrowview 为圈圈）
- (UIView *)arrowView
{
    if (!_arrowView) {
        //UIImage *image = [UIImage imageNamed:MJRefreshSrcName(@"card_refresh.png")] ?: [UIImage imageNamed:MJRefreshFrameworkSrcName(@"card_refresh.png")];
        UIView *arrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        [self addSubview:_arrowView = arrowView];
        //先隐藏
        _arrowView.hidden = YES;
        
        //init arc draw layer
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.frame = arrowView.bounds;
        shapeLayer.fillColor = nil;
        shapeLayer.strokeColor = self.borderColor.CGColor;
        shapeLayer.strokeStart = 0.08f;
        shapeLayer.strokeEnd = 0.92f;
        shapeLayer.shadowColor = [UIColor colorWithWhite:1 alpha:0.8f].CGColor;
        shapeLayer.shadowOpacity = 0.7f;
        shapeLayer.shadowRadius = 20.0f;
        shapeLayer.contentsScale = [UIScreen mainScreen].scale;
        shapeLayer.lineWidth = self.borderWidth;
        shapeLayer.lineCap = kCALineCapRound;
        
        [_arrowView.layer addSublayer:shapeLayer];
        self.arrowLayer = shapeLayer;
    }
    return _arrowView;
}
//系统菊花loading 逻辑不做处理。只注释懒加载。
//- (UIActivityIndicatorView *)loadingView
//{
//    if (!_loadingView) {
//        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
//        loadingView.hidesWhenStopped = YES;
//        [self addSubview:_loadingView = loadingView];
//    }
//    return _loadingView;
//}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    self.lastUpdatedTimeLabel.hidden = YES;
    self.loadingView = nil;
    [self setNeedsLayout];
}

#pragma mark - 重写父类的方法 创建下拉shapelayer
-(void)commonInit{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeUpdateValue) name:kThemeWillChangeNotificaiton object:nil];

    self.borderColor = [QRThemeColorWithKey(kGlobalQRViewColorNeedThemeCommonColorNonMainTabPage) getValue];//UIColorFrom16HEX(0x6699cc, 1);
    self.borderWidth = 2.0f;
    self.contentMode = UIViewContentModeRedraw;
    self.backgroundColor = [UIColor clearColor];
    
    //init arc draw layer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.stateLabel.frame;
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = self.borderColor.CGColor;
    shapeLayer.strokeEnd = 0.0f;
    shapeLayer.shadowColor = [UIColor colorWithWhite:1 alpha:0.8f].CGColor;
    shapeLayer.shadowOpacity = 0.7f;
    shapeLayer.shadowRadius = 20.0f;
    shapeLayer.contentsScale = [UIScreen mainScreen].scale;
    shapeLayer.lineWidth = self.borderWidth;
    shapeLayer.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:shapeLayer];
    self.shapeLayer = shapeLayer;
}

- (void)themeUpdateValue {
    if (self.shapeLayer && !CGColorEqualToColor(self.shapeLayer.strokeColor,[UIColor whiteColor].CGColor)) {
        self.borderColor = [QRThemeColorWithKey(kGlobalQRViewColorNeedThemeCommonColorNonMainTabPage) getValue];
        self.shapeLayer.strokeColor = self.borderColor.CGColor;
    }
}

- (void)prepare
{
    [super prepare];
    
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 圈圈中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= 100;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(self.mj_w * 0.5, arrowCenterY);
    
    // 圈圈
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.center = arrowCenter;
    }
    //调整shapelayer和绘制圆圈
    self.shapeLayer.frame = CGRectMake(self.mj_w * 0.5-11,self.mj_h * 0.5-11,22,22);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(11,11) radius:(self.arrowView.frame.size.width/2 - self.borderWidth)  startAngle:DEGREES_TO_RADIANS(-90) endAngle:DEGREES_TO_RADIANS(360-90) clockwise:YES];
    self.shapeLayer.path = bezierPath.CGPath;
    self.arrowLayer.path = bezierPath.CGPath;
    //根据业务一开始隐藏状态栏文字
    self.stateLabel.hidden = YES;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            [self stopRotateInfinitly];
            self.stateLabel.hidden = NO;
            //如果有自定义状态栏文字。加载自定义的
            if (self.MJRefreshHeaderEndRefreshingCustom) {
                [self setTitle:self.MJRefreshHeaderEndRefreshingCustom forState:state];
            }
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
               
                self.loadingView.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                //延迟0.3s后隐藏label
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((MJRefreshHeadNeedStayTime+MJRefreshSlowAnimationDuration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // 结束刷新
                    self.stateLabel.hidden = YES;
                });
                
            }];
//            [UIView animateWithDuration:MJRefreshSlowAnimationDuration delay:1.0 options:nil animations:^{
//                
//                self.loadingView.alpha = 0.0;
//                
//            } completion:^(BOOL finished) {
//                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
//                if (self.state != MJRefreshStateIdle) return;
//                self.loadingView.alpha = 1.0;
//                [self.loadingView stopAnimating];
//                //延迟0.3s后隐藏label
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    // 结束刷新
//                    self.stateLabel.hidden = YES;
//                });
//                
//            }];
            
        } else {
            [self.loadingView stopAnimating];
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                
            }];
            
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = YES;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            //self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.stateLabel.hidden = NO;
//        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
//        [self.loadingView startAnimating];
        self.arrowView.hidden = NO;
        //启动转圈动画
        [self rotateInfinitly];
        
    }
}
#pragma mark QQReader 拓展实现基类的方法
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

-(void)qrEndRefreshing{
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.state = MJRefreshStateIdle;
    });
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

- (void)setBorderWidth:(CGFloat)borderWidth
{
    [super setBorderWidth:borderWidth];
    self.arrowLayer.lineWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    [super setBorderColor:borderColor];
    self.arrowLayer.strokeColor = self.borderColor.CGColor;
}
@end
