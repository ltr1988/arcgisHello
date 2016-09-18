//
//  LiveDataYuqingHeaderView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LiveDataYuqingHeaderView.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"
#import "Masonry.h"

@interface LiveDataYuqingHeaderView()
@property (nonatomic,strong) UILabel *lbStart;
@property (nonatomic,strong) UILabel *lbEnd;
@property (nonatomic,strong) UIButton *btnStart;
@property (nonatomic,strong) UIButton *btnEnd;
@end

@implementation LiveDataYuqingHeaderView

-(instancetype) init
{
    return [self initWithFrame:CGRectZero];
}

-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

-(void) setupSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    __weak UIView* weakSelf = self;
    
    _lbStart = [UILabel new];
    _lbStart.font = UI_FONT(14);
    _lbStart.textColor = [UIColor orangeColor];
    _lbStart.backgroundColor = [UIColor clearColor];
    _lbStart.textAlignment = NSTextAlignmentCenter;
    [weakSelf addSubview:_lbStart];
    
    _lbEnd = [UILabel new];
    _lbEnd.font = UI_FONT(14);
    _lbEnd.textColor = [UIColor orangeColor];
    _lbEnd.backgroundColor = [UIColor clearColor];
    _lbEnd.textAlignment = NSTextAlignmentCenter;
    [weakSelf addSubview:_lbEnd];
    
    UIView *vLine = [UIView new];
    vLine.backgroundColor = [UIColor lightGrayColor];
    [weakSelf addSubview:vLine];
    
    _btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnStart setTitle:@"开始时间" forState:UIControlStateNormal];
    //[_btnStart setImage:[UIImage imageNamed:@""] forState:(UIControlState)]
    [_btnStart.titleLabel setTextColor:[UIColor grayColor]];
    [_btnStart.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_btnStart setBackgroundColor:[UIColor clearColor]];
    [weakSelf addSubview:_btnStart];
    
    _btnEnd = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnEnd setTitle:@"结束时间" forState:UIControlStateNormal];
    //[_btnStart setImage:[UIImage imageNamed:@""] forState:(UIControlState)]
    [_btnEnd.titleLabel setTextColor:[UIColor grayColor]];
    [_btnEnd.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_btnEnd setBackgroundColor:[UIColor clearColor]];
    [weakSelf addSubview:_btnEnd];
    
    [_lbStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(.5);
        make.height.mas_equalTo(30);
    }];
    
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.bottom.offset(-10);
        make.width.mas_equalTo(.5);
        make.left.mas_equalTo(_lbStart.mas_right);
    }];
    
    [_lbEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.mas_equalTo(vLine.mas_right);
        make.right.offset(0);
        make.height.mas_equalTo(30);
    }];
    
    [_btnStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lbStart.mas_bottom);
        make.left.offset(0);
        make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(.5);
        make.height.mas_equalTo(25);
    }];
    
    [_btnEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lbEnd.mas_bottom);
        make.left.mas_equalTo(vLine.mas_right);
        make.right.offset(0);
        make.height.mas_equalTo(25);
    }];
    
}

-(void) setStartDate:(NSString *)startDate
{
    _startDate = startDate;
    _lbStart.text = _startDate;
}

-(void) setEndDate:(NSString *)endDate
{
    _endDate = endDate;
    _lbEnd.text = _endDate;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [[UIColor seperatorColor] CGColor]);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), 0);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 0, CGRectGetHeight(self.frame));
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGContextStrokePath(context);
    
}

+(CGFloat) heightForView
{
    return 55;
}
@end
