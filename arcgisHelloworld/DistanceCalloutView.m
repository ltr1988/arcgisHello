//
//  DistanceCalloutView.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DistanceCalloutView.h"
#import "Masonry.h"

@implementation DistanceCalloutView

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
    
    _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnClose setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    _btnClose.imageView.bounds = CGRectMake(0, 0, 15, 15);
    _btnClose.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _lbDistance = [UILabel new];
    
    _lbDistance.font = [UIFont systemFontOfSize:12];
    _lbDistance.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_btnClose];
    [self addSubview:_lbDistance];

    [_lbDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(4);
        make.right.mas_equalTo(_btnClose.mas_left).offset(-4);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.right.offset(-4);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
}


@end
