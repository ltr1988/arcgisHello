//
//  Search3DResultCell.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Search3DResultCell.h"
#import "CommonDefine.h"
#import "Masonry.h"

@implementation Search3DResultCell

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
    _titleLabel.font = UI_FONT(16);
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_titleLabel];
    
    
    _maneLabel = [UILabel new];
    _maneLabel.font = UI_FONT(14);
    _maneLabel.textColor = [UIColor grayColor];
    _maneLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_maneLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(16);
        make.height.mas_equalTo(16);
        make.left.offset(16);
        make.right.offset(-16);
    }];
    
    [_maneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(14);
        make.left.offset(16);
        make.right.offset(-16);
    }];
    
}

-(void) setDataModel:(id<Search3DResultViewModel>) model
{
    _titleLabel.text = [model title];
    _maneLabel.text = [NSString stringWithFormat:@"管理单位:%@", [model mane]];
}

+(CGFloat) heightForCell
{
    return 8+16*2 + 16+14;
}
@end
