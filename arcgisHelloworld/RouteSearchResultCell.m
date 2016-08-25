//
//  RouteSearchResultCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "RouteSearchResultCell.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "UIColor+ThemeColor.h"

@implementation RouteSearchResultCell

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
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor blackColor];
    [weakView addSubview:_titleLabel];
    
    _leftIcon = [UIImageView new];
    _leftIcon.image = [UIImage imageNamed:@"icon_map_searchpoint"];
    _leftIcon.contentMode = UIViewContentModeScaleAspectFit;
    [weakView addSubview:_leftIcon];
    
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.width.mas_equalTo(25);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.left.mas_equalTo(_leftIcon.mas_right).with.offset(16);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor borderColor];
    [weakView addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.height.mas_equalTo(.5);
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
    }];
}


-(void) setTitle:(NSString *) text
{
    _titleLabel.text = text;
}

@end
