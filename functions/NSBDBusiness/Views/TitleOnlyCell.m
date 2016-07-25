//
//  TitleOnlyInputCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleOnlyCell.h"
#import "CommonDefine.h"
#import "Masonry.h"

@interface TitleOnlyCell()
-(void) bindData:(id) data;
@end

@implementation TitleOnlyCell

@synthesize data = _data;

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

-(void) setupSubViews
{
    __weak UIView *weakView = self.contentView;
    
    label = [UILabel new];
    label.font = UI_FONT(13);
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_bottom).with.offset(-0.5);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.right.mas_equalTo(weakView.mas_right);
    }];
    
    [weakView addSubview:label];
    [weakView addSubview:line];
}

-(void) setData:(id) data
{
    _data = data;
    [self bindData:data];
}

-(void) bindData:(id) data
{
    id<TitleOnlyCellViewModel> item = (id<TitleOnlyCellViewModel>)data;
    label.text = [item title];
    [label sizeToFit];
}
@end
