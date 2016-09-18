//
//  ThreeColumnView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ThreeColumnView.h"
#import "CommonDefine.h"
#import "Masonry.h"

@interface ThreeColumnView()
@property (nonatomic,strong) UILabel *lbFirstColumn;
@property (nonatomic,strong) UILabel *lbSecondColumn;
@property (nonatomic,strong) UILabel *lbThirdColumn;

@end

@implementation ThreeColumnView

-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

-(void) setupSubviews
{
    __weak UIView *weakSelf = self;
    _lbFirstColumn = [UILabel new];
    _lbFirstColumn.font = UI_FONT(14);
    _lbFirstColumn.textColor = [UIColor blackColor];
    _lbFirstColumn.backgroundColor = [UIColor clearColor];
    _lbFirstColumn.textAlignment = NSTextAlignmentLeft;
    [weakSelf addSubview:_lbFirstColumn];
    
    _lbSecondColumn = [UILabel new];
    _lbSecondColumn.font = UI_FONT(14);
    _lbSecondColumn.textColor = [UIColor blackColor];
    _lbSecondColumn.backgroundColor = [UIColor clearColor];
    _lbSecondColumn.textAlignment = NSTextAlignmentRight;
    [weakSelf addSubview:_lbSecondColumn];
    
    _lbThirdColumn = [UILabel new];
    _lbThirdColumn.font = UI_FONT(14);
    _lbThirdColumn.textColor = [UIColor blackColor];
    _lbThirdColumn.backgroundColor = [UIColor clearColor];
    _lbThirdColumn.textAlignment = NSTextAlignmentRight;
    [weakSelf addSubview:_lbThirdColumn];
    
    //auto - layout
    [_lbFirstColumn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
        make.left.offset(16);
        make.right.mas_equalTo(_lbSecondColumn.mas_left).offset(-5);
    }];
    
    [_lbSecondColumn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
        make.right.mas_equalTo(_lbThirdColumn.mas_left).offset(-5);
    }];
    
    [_lbThirdColumn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
        make.right.offset(-16);
        make.width.mas_equalTo(100);
    }];
}

-(void) setData:(id<ThreeColumnViewDelegate>) data
{
    if ([data respondsToSelector:@selector(firstColumnText)]) {
        _lbFirstColumn.text = [data firstColumnText];
    }
    if ([data respondsToSelector:@selector(secondColumnText)]) {
        _lbSecondColumn.text = [data secondColumnText];
    }
    if ([data respondsToSelector:@selector(thirdColumnText)]) {
        _lbThirdColumn.text = [data thirdColumnText];
    }
    if ([data respondsToSelector:@selector(firstColumnColor)]) {
        _lbFirstColumn.textColor = [data firstColumnColor];
    }
    if ([data respondsToSelector:@selector(secondColumnColor)]) {
        _lbSecondColumn.textColor = [data secondColumnColor];
    }
    if ([data respondsToSelector:@selector(thirdColumnColor)]) {
        _lbThirdColumn.textColor = [data thirdColumnColor];
    }
    
    [_lbSecondColumn sizeToFit];
}
@end
