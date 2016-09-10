//
//  CheckableImageView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/27.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "CheckableImageView.h"
#import "Masonry.h"



@interface CheckableImageView ()

@property (nonatomic,strong) UIButton *centerView;
@property (nonatomic,strong) UIImageView *checkView;
@end

@implementation CheckableImageView


-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        _readonly = NO;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void) setReadonly:(BOOL)readonly
{
    _readonly = readonly;
    if (_checkView) {
        _checkView.hidden = _readonly;
    }
}

-(void) setupSubViews
{
    float width = self.bounds.size.width / 3.0;
    UIView *responseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    responseView.backgroundColor = [UIColor clearColor];
    
    
    _checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_delete"]];
    _centerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_centerView setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [responseView addGestureRecognizer:tap];
    
    _centerView.alpha = 1;
    _centerView.hidden = YES;
    _centerView.layer.cornerRadius = 12;
    _centerView.layer.masksToBounds = YES;
    
    [self addSubview:responseView];
    [self addSubview:_checkView];
    [self addSubview:_centerView];
    
    __weak __typeof(self) weakSelf = self;
    
    
    [responseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(width);
        make.width.mas_equalTo(width);
    }];
    
    [_checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-4);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-4);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(12);
    }];
    
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
    }];
    
}

-(void) setVideo:(BOOL) isVideo
{
    if (_centerView) {
        _centerView.hidden = !isVideo;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (_delegate) {
        [_delegate itemCalled:self];
    }
}

@end
