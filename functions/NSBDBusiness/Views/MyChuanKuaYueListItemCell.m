//
//  MyChuanKuaYueListItemCell.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueListItemCell.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "UIColor+ThemeColor.h"
#import "MyChuanKuaYueItem.h"

@implementation MyChuanKuaYueListItemCell
{
    BOOL isHistory;
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

-(instancetype) initHistoryWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        isHistory = YES;
        [self setupSubViews];
    }
    return self;
}

-(void) setupSubViews
{
    __weak UIView *weakView = self.contentView;
    
    CGFloat largeSize = 18, midSize = 16, smallSize = 14;
    CGFloat buttonHeight = 25 , buttonWidth = 70;
    
    lbTitle = [UILabel new];
    lbTitle.font = UI_FONT(midSize);
    lbTitle.textColor = [UIColor blackColor];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.textAlignment = NSTextAlignmentLeft;
    
    [weakView addSubview:lbTitle];
    
    lbUnit = [UILabel new];
    lbUnit.font = UI_FONT(midSize);
    lbUnit.textColor = [UIColor themeGrayTextColor];
    lbUnit.backgroundColor = [UIColor clearColor];
    lbUnit.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbUnit];
    
    lbPlace = [UILabel new];
    lbPlace.font = UI_FONT(smallSize);
    lbPlace.textColor = [UIColor lightGrayColor];
    lbPlace.backgroundColor = [UIColor clearColor];
    lbPlace.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbPlace];
    
    if (!isHistory)
    {
        
        btnLocation = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLocation.bounds = CGRectMake(0, 0, buttonWidth, buttonHeight);
        [btnLocation setTitle:@"地图位置" forState:UIControlStateNormal];
        [btnLocation setTitleColor:[UIColor themeBlueColor] forState:UIControlStateNormal];
        [btnLocation.titleLabel setFont:[UIFont systemFontOfSize:14]];
        btnLocation.layer.borderColor = [UIColor themeBlueColor].CGColor;
        btnLocation.layer.borderWidth = 1;
        btnLocation.layer.cornerRadius = 2;
        [btnLocation addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
        [weakView addSubview:btnLocation];
        
        btnFeedback = [UIButton buttonWithType:UIButtonTypeCustom];
        btnFeedback.bounds = CGRectMake(0, 0, buttonWidth, buttonHeight);
        [btnFeedback setTitle:@"进度反馈" forState:UIControlStateNormal];
        [btnFeedback setTitleColor:[UIColor themeBlueColor] forState:UIControlStateNormal];
        [btnFeedback.titleLabel setFont:[UIFont systemFontOfSize:14]];
        btnFeedback.layer.borderColor = [UIColor themeBlueColor].CGColor;
        btnFeedback.layer.borderWidth = 1;
        btnFeedback.layer.cornerRadius = 2;
        [btnFeedback addTarget:self action:@selector(actionFeedback) forControlEvents:UIControlEventTouchUpInside];
        [weakView addSubview:btnFeedback];
        
        btnChangeStatus = [UIButton buttonWithType:UIButtonTypeCustom];
        btnChangeStatus.bounds = CGRectMake(0, 0, buttonWidth, buttonHeight);
        [btnChangeStatus setTitle:@"变更记录" forState:UIControlStateNormal];
        [btnChangeStatus setTitleColor:[UIColor themeBlueColor] forState:UIControlStateNormal];
        [btnChangeStatus.titleLabel setFont:[UIFont systemFontOfSize:14]];
        btnChangeStatus.layer.borderColor = [UIColor themeBlueColor].CGColor;
        btnChangeStatus.layer.borderWidth = 1;
        btnChangeStatus.layer.cornerRadius = 2;
        [btnChangeStatus addTarget:self action:@selector(actionChangeStatus) forControlEvents:UIControlEventTouchUpInside];
        [weakView addSubview:btnChangeStatus];
    }
    
    UIImageView *nextIcon = [UIImageView new];
    nextIcon.image = [UIImage imageNamed:@"icon_more"];
    nextIcon.contentMode = UIViewContentModeScaleAspectFit;
    [weakView addSubview:nextIcon];
    
    CGFloat padding = 8;
    
    [nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(padding);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(25);
        make.right.mas_equalTo(weakView.mas_right).offset(-8);
    }];

    
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(padding);
        make.height.mas_equalTo(midSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
    
    [lbUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbTitle.mas_bottom).offset(15);
        make.height.mas_equalTo(midSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
    
    [lbPlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbUnit.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
    
    if (!isHistory)
    {
        [btnLocation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lbPlace.mas_bottom).offset(padding);
            make.height.mas_equalTo(buttonHeight);
            make.width.mas_equalTo(buttonWidth);
            make.right.mas_equalTo(btnFeedback.mas_left).with.offset(-8);
        }];
        
        [btnFeedback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lbPlace.mas_bottom).offset(padding);
            make.height.mas_equalTo(buttonHeight);
            make.width.mas_equalTo(buttonWidth);
            make.right.mas_equalTo(btnChangeStatus.mas_left).with.offset(-8);
        }];
        
        [btnChangeStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lbPlace.mas_bottom).offset(padding);
            make.height.mas_equalTo(buttonHeight);
            make.width.mas_equalTo(buttonWidth);
            make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
        }];
    }
}


-(void) setData:(MyChuanKuaYueItem *) data
{
    _data = data;
    lbTitle.text = [data cellTitle];
    lbUnit.text = [NSString stringWithFormat:@"责任单位:%@",[data cellUnit]];
    lbPlace.text = [NSString stringWithFormat:@"位置描述:%@",[data cellLocation]];
}

+(CGFloat) heightForCell
{
    CGFloat largeSize = 18, midSize = 16, smallSize = 14,padding = 8,buttonHeight = 25 ;
    CGFloat height = 15+ midSize + midSize + smallSize +4*padding +buttonHeight;
    return height;
}

+(CGFloat) heightForHistoryCell
{
    CGFloat largeSize = 18, midSize = 16, smallSize = 14,padding = 8 ;
    CGFloat height = 15+ midSize + midSize + smallSize +3*padding;
    return height;
}
#pragma mark - action

-(void) actionChangeStatus
{
    if (_delegate) {
        [_delegate changeStatusWithInfo:_data];
    }
}

-(void) actionLocation
{
    if (_delegate) {
        [_delegate mapLocationWithInfo:_data];
    }
}

-(void) actionFeedback
{
    if (_delegate) {
        [_delegate feedbackWithInfo:_data];
    }
}
@end
