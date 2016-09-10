//
//  EventDetailView.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventDetailView.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "UIColor+ThemeColor.h"


@interface EventDetailView()
{
    UILabel *lbTitle;
    UILabel *lbDate;
    
    UILabel *lbPlace;
    UILabel *lbFinder;
    
    UIImageView *nextIcon;
    UIImageView *placeIcon;
}

@end

@implementation EventDetailView

-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

-(void) setupSubViews
{
    __weak UIView *weakView = self;
    
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
}

+(CGFloat) heightForView
{
    CGFloat largeSize = 18, midSize = 16, smallSize = 14,padding = 8;
    CGFloat height = largeSize+midSize +smallSize*2+6*padding+1;
    return height;
}

-(void) setViewData:(id<EventDetailViewDelegate>) data
{
    lbTitle.text = [data eventDetailViewTitle];
    lbDate.text = [data eventDetailViewDate];
    lbPlace.text = [data eventDetailViewPlace];
    lbFinder.text = [data eventDetailViewFinder];
}
@end
