//
//  ClosableWebView.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ClosableWebView.h"
#import "Masonry.h"

@implementation ClosableWebView

-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        __weak UIView* weakself = self;
        
        UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnClose setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        
        [btnClose addTarget:self action:@selector(actionClose) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btnClose];
        [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(2);
            make.right.offset(2);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

-(void) actionClose
{
    if (self.superview != nil) {
        [self removeFromSuperview];
    }
}
@end
