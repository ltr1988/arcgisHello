//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//
/***********************注意: 该源文件是ARC的!!!************************/

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif
#import "MJRefreshHeader.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorDefine.h"



@interface MJRefreshHeader()
@property (assign, nonatomic) CGFloat insetTDelta;

//计算下拉百分比
@property (nonatomic, assign) double progress;
@property (nonatomic, assign) double prevProgress;
@end

@implementation MJRefreshHeader
#pragma mark - 构造方法
-(id)init{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    MJRefreshHeader *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshHeader *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}
- (void) commonInit
{ //交给子类实现
}
#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    // 设置key
    self.lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey;
    
    // 设置高度
    self.mj_h = MJRefreshHeaderHeight;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
    self.mj_y = - self.mj_h - self.ignoredScrollViewContentInsetTop;
    CGFloat shapeCenterY = self.mj_h * 0.5;
    self.shapeLayer.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2-11,shapeCenterY-11,22,22);
    
}
- (void)setSize:(CGSize) size
{
    CGRect rect = CGRectMake((self.scrollView.bounds.size.width - size.width)/2.0f,
                             -size.height, size.width, size.height);
    self.frame = rect;
    self.shapeLayer.frame = self.bounds;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    // 在刷新的refreshing状态
    if (self.state == MJRefreshStateRefreshing) {
        if (self.window == nil) return;
        
        // sectionheader停留解决
        CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
        insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
        self.scrollView.mj_insetT = insetT;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }
    
    // 跳转到下一个控制器时，contentInset可能会变
     _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.mj_h;
    self.progress = pullingPercent;
    if (self.scrollView.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateIdle;
        }
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}
//根据百分比来绘制白圈
-(void)setProgress:(double)progress{
    if (progress > 1.0) {
        progress = 1.0;
    }
    
    if (progress >= 0 && progress <= 1.0f) {
        //strokeAnimation
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = [NSNumber numberWithFloat:((CAShapeLayer *)self.shapeLayer.presentationLayer).strokeEnd];
        animation.toValue = [NSNumber numberWithFloat:progress];
        animation.duration = 0.1f;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [self.shapeLayer addAnimation:animation forKey:@"animation"];
    }
    self.prevProgress = self.progress;
    _progress = progress;
}
- (void)setState:(MJRefreshState)state
{
    MJRefreshState oldState = self.state;
    if (state == oldState) return;
    if (NO == ((state == MJRefreshStateIdle) && (oldState == MJRefreshStateRefreshing))) {
        [super setState:state];
    }
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState != MJRefreshStateRefreshing) return;
        
        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
       
        
         // 恢复inset和offset
        [UIView animateWithDuration:MJRefreshSlowAnimationDuration delay:MJRefreshHeadNeedStayTime options:nil animations:^{
            [super setState:state];
            self.scrollView.mj_insetT += self.insetTDelta;
            
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha)
                self.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            self.shapeLayer.hidden = NO;
            self.shapeLayer.opacity = 1;
            self.pullingPercent = 0.0;
            
        }];

    } else if (state == MJRefreshStateRefreshing) {
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            // 增加滚动区域
            CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
            self.scrollView.mj_insetT = top;
            self.shapeLayer.opacity = 0;
            // 设置滚动位置
            self.scrollView.mj_offsetY = - top;
        } completion:^(BOOL finished) {
            self.shapeLayer.hidden = YES;
            [self executeRefreshingCallback];
        }];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
}

#pragma mark - 公共方法
- (void)endRefreshing
{
    if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [super endRefreshing];
        });
    } else {
        [super endRefreshing];
    }
}

- (NSDate *)lastUpdatedTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}

#pragma mark --------------------QQreader改写。等待子类实现-------------------------
-(void)setStatusLabelTextColor:(UIColor *)backgroundColor{
    
}
-(void)setStatusLabelText:(NSString *)text{
    
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    _shapeLayer.lineWidth = _borderWidth;
}
- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    _shapeLayer.strokeColor = _borderColor.CGColor;
}

/**
 *  开始刷新
 */

- (void)qrBeginRefreshing{
    [self beginRefreshing];
}
#pragma mark 暂未实现 交给子类实现
/**
 *  结束刷新
 */
-(void)setStatusLabelHidden:(BOOL)hidden{
    
}
- (void)qrEndRefreshing{

}

- (void)stopRotateInfinitly{
    
}
- (void)startRotateInfinitly{
    
}
@end
