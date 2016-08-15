//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeader.h"
#import "MJRefreshFooter.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"
#import "MJRefreshAutoNormalFooter.h"
#import <objc/runtime.h>

@implementation NSObject (MJRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@implementation UIScrollView (MJRefresh)

#pragma mark - header
static const char MJRefreshHeaderKey = '\0';
- (void)setMj_header:(MJRefreshHeader *)mj_header
{
    if (mj_header != self.mj_header) {
        // 删除旧的，添加新的
        [self.mj_header removeFromSuperview];
        [self insertSubview:mj_header atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"mj_header"]; // KVO
        objc_setAssociatedObject(self, &MJRefreshHeaderKey,
                                 mj_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"mj_header"]; // KVO
    }
}

- (MJRefreshHeader *)mj_header
{
    return objc_getAssociatedObject(self, &MJRefreshHeaderKey);
}

#pragma mark - footer
static const char MJRefreshFooterKey = '\0';
- (void)setMj_footer:(MJRefreshFooter *)mj_footer
{
    if (mj_footer != self.mj_footer) {
        // 删除旧的，添加新的
        [self.mj_footer removeFromSuperview];
        [self addSubview:mj_footer];
        
        // 存储新的
        [self willChangeValueForKey:@"mj_footer"]; // KVO
        objc_setAssociatedObject(self, &MJRefreshFooterKey,
                                 mj_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"mj_footer"]; // KVO
    }
}

- (MJRefreshFooter *)mj_footer
{
    return objc_getAssociatedObject(self, &MJRefreshFooterKey);
}

#pragma mark - 过期
- (void)setFooter:(MJRefreshFooter *)footer
{
    self.mj_footer = footer;
}

- (MJRefreshFooter *)footer
{
    return self.mj_footer;
}

- (void)setHeader:(MJRefreshHeader *)header
{
    self.mj_header = header;
}

- (MJRefreshHeader *)header
{
    return self.mj_header;
}

#pragma mark - other
- (NSInteger)mj_totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char MJRefreshReloadDataBlockKey = '\0';
- (void)setMj_reloadDataBlock:(void (^)(NSInteger))mj_reloadDataBlock
{
    [self willChangeValueForKey:@"mj_reloadDataBlock"]; // KVO
    objc_setAssociatedObject(self, &MJRefreshReloadDataBlockKey, mj_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"mj_reloadDataBlock"]; // KVO
}

- (void (^)(NSInteger))mj_reloadDataBlock
{
    return objc_getAssociatedObject(self, &MJRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock
{
    !self.mj_reloadDataBlock ? : self.mj_reloadDataBlock(self.mj_totalDataCount);
}
#pragma mark QQReader 扩展
#pragma mark HEADER
- (void)setCustomHeaderRefreshEndText:(NSString *)text
{
    self.mj_header.MJRefreshHeaderEndRefreshingCustom = text;
}
- (BOOL)isHeaderRefreshing{
    return self.mj_header.isRefreshing;
}
- (void)setHeaderBackgroundColor:(UIColor *)backgroundColor{
    self.mj_header.backgroundColor = backgroundColor;
}
- (void)setHeaderStatusLabelColor:(UIColor *)color{
    [self.mj_header setStatusLabelTextColor:color];
}
- (void)setHeaderStatusLabelText:(NSString *)text{
    [self.mj_header setStatusLabelText:text];
}
- (void)setHeaderBoderColor:(UIColor *)borderColor{
    self.mj_header.borderColor = borderColor;
}
- (void)headerStatusLabelHidden:(BOOL)hidden{
    [self.mj_header setStatusLabelHidden:hidden];
}
- (void)stopAnimatingHeaderActivityView:(BOOL)stop{
    if (stop)
    {
        [self.mj_header stopRotateInfinitly];
    }
    else
    {
        [self.mj_header startRotateInfinitly];
    }
}
#pragma mark FOOTER
- (void)setCustomFooterRefreshEndText:(NSString *)text{
    self.mj_footer.MJRefreshFooterEndRefreshingCustom = text;
}
- (void)setFooterStatusLableText:(NSString *)text{
    [self.mj_footer setStatusLabelText:text];
}
- (BOOL)isFooterRefreshing{
    return self.mj_footer.isRefreshing;
}

#pragma mark 对旧版本的兼容
#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback{
    if (!self.mj_header) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(){
            callback();
        }];
        [self bringSubviewToFront:self.mj_header];
    }
}
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action{
    if (!self.mj_header) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
         [self bringSubviewToFront:self.mj_header];
    }
   
}
/**
 *  移除下拉刷新头部控件
 */
- (void)removeHeader{
    self.mj_header = nil;
}
/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing{
    [self.mj_header qrBeginRefreshing];
}

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing{
    [self.mj_header qrEndRefreshing];
}
- (BOOL)isHeaderHidden
{
    return self.mj_header.isHidden;
}
#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback{
    if (!self.mj_footer) {
//        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
//            callback();
//        }];
        self.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            callback();
        }];
        [self bringSubviewToFront:self.mj_footer];
    }
    
}
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action{
    if (!self.mj_footer) {
        self.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:target refreshingAction:action];//[MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
        [self bringSubviewToFront:self.mj_footer];
    }
}
/**
 *  移除上拉刷新尾部控件
 */
- (void)removeFooter{
    self.mj_footer = nil;
}
/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing{
    [self.mj_footer qrBeginRefreshing];
}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing{
    [self.mj_footer qrEndRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */

@end

@implementation UITableView (MJRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mj_reloadData)];
}

- (void)mj_reloadData
{
    [self mj_reloadData];
    
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (MJRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mj_reloadData)];
}

- (void)mj_reloadData
{
    [self mj_reloadData];
    
    [self executeReloadDataBlock];
}



@end
