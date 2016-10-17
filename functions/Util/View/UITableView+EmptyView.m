//
//  UITableView+EmptyView.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "UITableView+EmptyView.h"
#import "UIColor+ThemeColor.h"
#import "Masonry.h"

const NSInteger EmptyTag = 2048;
@implementation UITableView (EmptyView)

-(void) setEmptyView
{
    UIView *emptyView = [[UIView alloc] initWithFrame:self.bounds];
//    UILabel *tip = [[UILabel alloc] initWithFrame:self.bounds];
//    tip.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    tip.font = [UIFont systemFontOfSize: 20];
//    tip.textColor = [UIColor themeBlueColor];
//    tip.text = @"暂无数据";
//    tip.textAlignment = NSTextAlignmentCenter;
//    [emptyView addSubview:tip];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wushuju"]];
    [emptyView addSubview:imageView];
    
    
    __weak UIView *weakView = emptyView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakView.mas_centerX);
        make.centerY.mas_equalTo(weakView.mas_centerY);
    }];
    
    [self setEmptyView:emptyView];
}

-(void) setEmptyView:(UIView*) emptyView
{
    if (!emptyView) {
        return;
    }
    emptyView.tag = EmptyTag;
    if ([self viewWithTag:EmptyTag]) {
        return;
    }
    emptyView.frame = self.bounds;
    emptyView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:emptyView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptyViewTapped:)];
    [emptyView addGestureRecognizer:tapGesture];
    
}

-(void) removeEmptyView
{
    UIView *emptyView = [self viewWithTag:EmptyTag];
    if (emptyView)
    {
        [emptyView removeFromSuperview];
    }
}

-(void) emptyViewTapped:(UITapGestureRecognizer *) gesture
{
    [self reloadData];
}
@end
