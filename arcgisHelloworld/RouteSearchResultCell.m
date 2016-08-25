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
    
    _label = [UILabel new];
    _label.font = [UIFont systemFontOfSize:16];
    _label.textColor = [UIColor blackColor];
    [weakView addSubview:_label];
    
    _leftIcon = [UIImageView new];
    _leftIcon.image = [UIImage imageNamed:@"icon_map_searchpoint"];
    _leftIcon.contentMode = UIViewContentModeScaleAspectFit;
    [weakView addSubview:_leftIcon];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
        make.left.mas_equalTo(_leftIcon.mas_right).with.offset(16);
    }];
    
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.width.mas_equalTo(25);
        make.left.mas_equalTo(_leftIcon.mas_right).with.offset(16);
    }];
    
}


-(void) setTitle:(NSString *) text
{
    _label.text = text;
}

@end
