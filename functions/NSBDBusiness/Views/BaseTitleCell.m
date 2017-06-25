//
//  TitleOnlyInputCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "BaseTitleCell.h"
#import "CommonDefine.h"
#import "Masonry.h"

@interface BaseTitleCell()

@end

@implementation BaseTitleCell

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
    label.font = UI_FONT(16);
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    
//    
//    UIView *line = [UIView new];
//    line.backgroundColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    
    [weakView addSubview:label];
//    [weakView addSubview:line];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.left.offset(16);
        make.right.offset(-170);
    }];

    
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(weakView.mas_bottom);
//        make.bottom.mas_equalTo(weakView.mas_bottom).with.offset(0.5);
//        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
//        make.right.mas_equalTo(weakView.mas_right);
//    }];
    
    
}

-(void) setReadOnly:(BOOL)readOnly
{
    _readOnly = readOnly;
    if (_readOnly) {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
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
