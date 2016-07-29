//
//  CheckableImageView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/27.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "CheckableImageView.h"
#import "Masonry.h"
#import "UIImageView+AFNetworking.h"


@interface CheckableImageView ()

@property (nonatomic,strong) UIImageView *checkView;
@property (nonatomic,strong) UIImageView *bgView;
@end

@implementation CheckableImageView


-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}


-(void) setupSubViews
{
    _checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete"]];
    _checkView.alpha = 0.3;
    _bgView = [UIImageView new];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_checkView addGestureRecognizer:tap];
    
    [self addSubview:_bgView];
    [self addSubview:_checkView];
    
    __weak __typeof(self) weakSelf = self;
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        
    }];
    
    [_checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(8);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-8);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (_delegate) {
        [_delegate itemCalled:self];
    }
}

@end
