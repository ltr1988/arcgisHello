//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+MJRefresh.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  给ScrollView增加下拉刷新、上拉刷新的功能

#import <UIKit/UIKit.h>
#import "MJRefreshConst.h"
//#import "MJRefreshNormalHeader.h"

@class MJRefreshHeader, MJRefreshFooter,MJRefreshNormalHeader,MJRefreshBackNormalFooter;

@interface UIScrollView (MJRefresh)
/** 下拉刷新控件 */
@property (strong, nonatomic) MJRefreshHeader *mj_header;
@property (strong, nonatomic) MJRefreshHeader *header MJRefreshDeprecated("使用mj_header");
/** 上拉刷新控件 */
@property (strong, nonatomic) MJRefreshFooter *mj_footer;
@property (strong, nonatomic) MJRefreshFooter *footer MJRefreshDeprecated("使用mj_footer");

#pragma mark - other
- (NSInteger)mj_totalDataCount;
@property (copy, nonatomic) void (^mj_reloadDataBlock)(NSInteger totalDataCount);


#pragma mark QQReader 扩展
/**
 * 设置刷新完毕自定义字符串，如果不设置则会调默认的const
 */
- (void)setCustomHeaderRefreshEndText:(NSString *)text;
- (void)setCustomFooterRefreshEndText:(NSString *)text;

- (BOOL)isHeaderRefreshing;
- (BOOL)isFooterRefreshing;

- (void)setHeaderBackgroundColor:(UIColor *)backgroundColor;
- (void)setHeaderStatusLabelColor:(UIColor *)color;
- (void)setHeaderStatusLabelText:(NSString *)text;
- (void)setHeaderBoderColor:(UIColor *)borderColor;
- (void)headerStatusLabelHidden:(BOOL)hidden;

//- (void)setHeaderSuccessImage;
- (void)stopAnimatingHeaderActivityView:(BOOL)stop;

- (void)setFooterStatusLableText:(NSString *)text;

#pragma mark 对旧版本的兼容
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback;
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action;
/**
 *  移除下拉刷新头部控件
 */
- (void)removeHeader;
/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing;

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing;
/**
 *  下拉刷新头部控件的可见性
 */
//@property (nonatomic, assign, getter = isHeaderHidden) BOOL headerHidden;
#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback;
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action;
/**
 *  移除上拉刷新尾部控件
 */
- (void)removeFooter;
/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing;

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing;

/**
 *  下拉刷新头部控件的可见性
 */
//@property (nonatomic, assign, getter = isFooterHidden) BOOL footerHidden;
@end
