//
//  CenterTitleCell.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/8/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "CenterTitleCell.h"
#import "CommonDefine.h"
#import "Masonry.h"

@implementation CenterTitleCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

-(void) setupSubViews
{
    _titleLabel = [UILabel new];
    _titleLabel.font = UI_FONT(14);
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    __weak UIView* weakView = self.contentView;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
    }];

}

-(void) setTitle:(NSString *)title
{
    _titleLabel.text = title;
}
@end
