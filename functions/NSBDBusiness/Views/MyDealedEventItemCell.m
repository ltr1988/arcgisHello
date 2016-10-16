//
//  MyDealedEventItemCell.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyDealedEventItemCell.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "UIColor+ThemeColor.h"
#import "MyEventItem.h"

@implementation MyDealedEventItemCell

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
    
    CGFloat midSize = 16, smallSize = 14;
    
    lbTitle = [UILabel new];
    lbTitle.font = UI_FONT(midSize);
    lbTitle.textColor = [UIColor blackColor];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbTitle];
    
    lbName = [UILabel new];
    lbName.font = UI_FONT(midSize);
    lbName.textColor = [UIColor themeGrayTextColor];
    lbName.backgroundColor = [UIColor clearColor];
    lbName.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbName];
    
    lbDate = [UILabel new];
    lbDate.font = UI_FONT(smallSize);
    lbDate.textColor = [UIColor themeGrayTextColor];
    lbDate.backgroundColor = [UIColor clearColor];
    lbDate.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbDate];
    
    lbEexecutor = [UILabel new];
    lbEexecutor.font = UI_FONT(smallSize);
    lbEexecutor.textColor = [UIColor blackColor];
    lbEexecutor.backgroundColor = [UIColor clearColor];
    lbEexecutor.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbEexecutor];
    
    
    CGFloat padding = 8;
    
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(padding);
        make.height.mas_equalTo(midSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
    }];
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbTitle.mas_bottom).offset(padding);
        make.height.mas_equalTo(midSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
    }];
    
    [lbEexecutor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbName.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
    }];
    
    [lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbName.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(lbEexecutor.mas_right).with.offset(8);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
}


-(void) setData:(id<MyDealedEventItemCellModel> ) data
{
    lbName.text = [data name];
    lbEexecutor.text = [data executor];
    lbTitle.text = [data title];
    lbDate.text = [data date];
    
    [lbEexecutor sizeToFit];
}

+(CGFloat) heightForCell
{
    CGFloat midSize = 16, smallSize = 14,padding = 8;
    CGFloat height = midSize*2 +smallSize+4*padding;
    return height;
}
@end
