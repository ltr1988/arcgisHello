//
//  DepthCalloutView.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DepthCalloutView.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "UIColor+ThemeColor.h"

@implementation DepthCalloutView

-(instancetype) init
{
    return [self initWithFrame:CGRectZero];
}

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
    
    self.userInteractionEnabled = YES;
    self. backgroundColor = [UIColor clearColor];
    
    _lbLine1 = [UILabel new];
    _lbLine1.font = [UIFont systemFontOfSize:12];
    _lbLine1.textAlignment = NSTextAlignmentCenter;
    
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;

    [self addSubview:_imageView];
    [self addSubview:_lbLine1];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_imageView addGestureRecognizer:tap];
    [self addGestureRecognizer:tap];

    _imageView.multipleTouchEnabled = YES;
    _imageView.userInteractionEnabled = YES;

    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(4);
        make.right.offset(-4);
        make.top.offset(4);
        make.height.mas_equalTo(40);
    }];
    
    [_lbLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(4);
        make.right.offset(-4);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(_imageView.mas_bottom).offset(4);
    }];
}

-(void) tapAction:(id)sender
{
    if (self.imageTapped)
    {
        self.imageTapped(self.imageView.image);
    }
}
//80 for height
@end
