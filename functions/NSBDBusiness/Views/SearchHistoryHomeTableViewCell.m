//
//  SearchHistoryHomeTableViewCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchHistoryHomeTableViewCell.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "UIColor+ThemeColor.h"
#import "SearchHistoryItem.h"

@implementation SearchHistoryHomeTableViewCell
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
    self.contentView.backgroundColor = [UIColor whiteColor];
    CGFloat largeSize = 16, smallSize = 12;
    
    lbName = [UILabel new];
    lbName.font = UI_FONT(largeSize);
    lbName.textColor = [UIColor blackColor];
    lbName.backgroundColor = [UIColor clearColor];
    lbName.textAlignment = NSTextAlignmentLeft;
    
    lbName.numberOfLines = 0;
    [weakView addSubview:lbName];
    
    lbStartDate = [UILabel new];
    lbStartDate.font = UI_FONT(smallSize);
    lbStartDate.textColor = [UIColor themeGrayTextColor];
    lbStartDate.backgroundColor = [UIColor clearColor];
    lbStartDate.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbStartDate];
    
    
    lbEndDate = [UILabel new];
    lbEndDate.font = UI_FONT(smallSize);
    lbEndDate.textColor = [UIColor themeGrayTextColor];
    lbEndDate.backgroundColor = [UIColor clearColor];
    lbEndDate.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbEndDate];
    
    CGFloat padding = 10;
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(padding);
        make.left.mas_equalTo(weakView.mas_left).with.offset(8);
        make.right.mas_equalTo(weakView.mas_right).offset(-8);
        make.height.mas_equalTo(largeSize);
    }];
    
    [lbStartDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbName.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(8);
        make.right.mas_equalTo(weakView.mas_right).offset(-8);
    }];
    
    [lbEndDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbStartDate.mas_bottom).offset(5);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(8);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-8);
    }];
}


-(void) setData:(SearchHistoryItem *) data
{
    _data = data;
    lbName.text = [NSString stringWithFormat:@"任务名称 %@", data.name];
    lbStartDate.text = [NSString stringWithFormat:@"开始时间 %@", data.startDate];
    lbEndDate.text = [NSString stringWithFormat:@"结束时间 %@", data.endDate];
}

+(CGFloat) heightForCell
{
    CGFloat largeSize = 16, smallSize = 12;
    return 10*3 + 5 + largeSize + 2*smallSize;
}

@end
