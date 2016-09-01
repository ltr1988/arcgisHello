//
//  MyEventItemCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventItemCell.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "UIColor+ThemeColor.h"
#import "MyEventItem.h"

@implementation MyEventItemCell
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
    
    CGFloat largeSize = 18, midSize = 16, smallSize = 14;
    
    lbTitle = [UILabel new];
    lbTitle.font = UI_FONT(largeSize);
    lbTitle.textColor = [UIColor blackColor];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.textAlignment = NSTextAlignmentLeft;
    
    [weakView addSubview:lbTitle];
    
    nextIcon = [UIImageView new];
    nextIcon.image = [UIImage imageNamed:@"icon_more"];
    nextIcon.contentMode = UIViewContentModeScaleAspectFit;
    [weakView addSubview:nextIcon];
    
    lbDate = [UILabel new];
    lbDate.font = UI_FONT(smallSize);
    lbDate.textColor = [UIColor themeGrayTextColor];
    lbDate.backgroundColor = [UIColor clearColor];
    lbDate.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbDate];
    
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor borderColor];
    [weakView addSubview:line1];
    
    
    placeIcon = [UIImageView new];
    placeIcon.image = [UIImage imageNamed:@"icon_location"];
    placeIcon.contentMode = UIViewContentModeScaleAspectFit;
    [weakView addSubview:placeIcon];
    
    lbPlace = [UILabel new];
    lbPlace.font = UI_FONT(midSize);
    lbPlace.textColor = [UIColor blackColor];
    lbPlace.backgroundColor = [UIColor clearColor];
    lbPlace.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbPlace];
    
    lbFinder = [UILabel new];
    lbFinder.font = UI_FONT(smallSize);
    lbFinder.textColor = [UIColor themeGrayTextColor];
    lbFinder.backgroundColor = [UIColor clearColor];
    lbFinder.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbFinder];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = [UIColor borderColor];
    [weakView addSubview:line2];
    
    UILabel *lbXingzhi = [UILabel new];
    lbXingzhi.text = @"事件性质";
    lbXingzhi.font = UI_FONT(smallSize);
    lbXingzhi.textColor = [UIColor themeGrayTextColor];
    lbXingzhi.backgroundColor = [UIColor clearColor];
    lbXingzhi.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbXingzhi];
    
    UILabel *lbLevel = [UILabel new];
    lbLevel.text = @"预警级别";
    lbLevel.font = UI_FONT(smallSize);
    lbLevel.textColor = [UIColor themeGrayTextColor];
    lbLevel.backgroundColor = [UIColor clearColor];
    lbLevel.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbLevel];
    
    lbXingzhiContent = [UILabel new];
    lbXingzhiContent.font = UI_FONT(smallSize);
    lbXingzhiContent.textColor = [UIColor blackColor];
    lbXingzhiContent.backgroundColor = [UIColor clearColor];
    lbXingzhiContent.textAlignment = NSTextAlignmentRight;
    [weakView addSubview:lbXingzhiContent];
    
    lbLevelContent = [UILabel new];
    lbLevelContent.font = UI_FONT(smallSize);
    lbLevelContent.textColor = [UIColor blackColor];
    lbLevelContent.backgroundColor = [UIColor clearColor];
    lbLevelContent.textAlignment = NSTextAlignmentRight;
    [weakView addSubview:lbLevelContent];
    
    CGFloat padding = 8;
    
    [nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(30);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
    
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(padding);
        make.height.mas_equalTo(largeSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.right.mas_equalTo(nextIcon.mas_left).offset(-8);
    }];
    
    [lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbTitle.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.right.mas_equalTo(nextIcon.mas_left).offset(-8);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbDate.mas_bottom).offset(padding);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.right.mas_equalTo(weakView.mas_right);
    }];
    
    [placeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(padding);
        make.height.mas_equalTo(18);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.width.mas_equalTo(18);
    }];
    
    [lbPlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(padding);
        make.height.mas_equalTo(midSize);
        make.left.mas_equalTo(placeIcon.mas_right).with.offset(8);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
    
    [lbFinder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbPlace.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(placeIcon.mas_right).with.offset(8);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbFinder.mas_bottom).offset(padding);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
        make.right.mas_equalTo(weakView.mas_right);
    }];
    
    [lbXingzhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
    }];
    
    [lbXingzhiContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(lbXingzhi.mas_right).with.offset(8);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
    
    [lbLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbXingzhi.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(16);
    }];
    
    [lbLevelContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbXingzhi.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(lbLevel.mas_right).with.offset(8);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
    
    
    [lbXingzhi sizeToFit];
    [lbLevel sizeToFit];
}


-(void) setData:(MyEventItem *) data
{
    _data = data;
    lbLevelContent.text = data.level;
    lbXingzhiContent.text = data.xingzhi;
    lbTitle.text = data.title;
    lbDate.text = data.date;
    lbPlace.text = data.place;
    lbFinder.text = data.finder;
}

+(CGFloat) heightForCell
{
    CGFloat largeSize = 18, midSize = 16, smallSize = 14,padding = 8;
    CGFloat height = largeSize+midSize +smallSize*4+9*padding+1;
    return height;
}
@end
