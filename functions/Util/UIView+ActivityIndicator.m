//
//  UIView+ActivityIndicator.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/24.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "UIView+ActivityIndicator.h"

@implementation UIView (ActivityIndicator)
- (void)initActivityIndicatorViewWithTag:(NSInteger)tag
                               superView:(UIView *)superView
                                  center:(CGPoint)center
                               withStyle:(UIActivityIndicatorViewStyle)style
{
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0, 0.0, 35.0, 35.0)];
    indicatorView.tag = tag;
    indicatorView.center = center;
    indicatorView.activityIndicatorViewStyle = style;
    [indicatorView startAnimating];
    
    [superView addSubview:indicatorView];
}

- (void)removeActivityIndicatorViewWithTag:(NSInteger)tag superView:(UIView *)superView
{
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[superView viewWithTag:tag];
    [indicatorView stopAnimating];
    [indicatorView removeFromSuperview];
}
@end
