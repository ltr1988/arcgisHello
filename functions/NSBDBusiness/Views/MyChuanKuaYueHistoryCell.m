//
//  MyChuanKuaYueHistoryCell.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueHistoryCell.h"
#import "EventMediaCollectionView.h"
#import "UIColor+ThemeColor.h"
#import "Masonry.h"
#import "CommonDefine.h"
@interface MyChuanKuaYueHistoryCell()
{
    UILabel* lbTitle;
    UILabel* lbFinder;
    UILabel* lbDate;
    UILabel* lbDepart;
    EventMediaCollectionView* picContentView;
}

@end
@implementation MyChuanKuaYueHistoryCell

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
    CGFloat largeSize = 16, smallSize = 14;
    
    lbTitle = [UILabel new];
    lbTitle.font = UI_FONT(largeSize);
    lbTitle.textColor = [UIColor blackColor];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.textAlignment = NSTextAlignmentLeft;
    
    lbTitle.numberOfLines = 0;
    [weakView addSubview:lbTitle];
    
    lbDate = [UILabel new];
    lbDate.font = UI_FONT(smallSize);
    lbDate.textColor = [UIColor themeGrayTextColor];
    lbDate.backgroundColor = [UIColor clearColor];
    lbDate.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbDate];
    
    lbFinder = [UILabel new];
    lbFinder.font = UI_FONT(smallSize);
    lbFinder.textColor = [UIColor themeGrayTextColor];
    lbFinder.backgroundColor = [UIColor clearColor];
    lbFinder.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbFinder];
    
    lbDepart = [UILabel new];
    lbDepart.font = UI_FONT(smallSize);
    lbDepart.textColor = [UIColor themeGrayTextColor];
    lbDepart.backgroundColor = [UIColor clearColor];
    lbDepart.textAlignment = NSTextAlignmentLeft;
    [weakView addSubview:lbDepart];
    
    picContentView = [[EventMediaCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    [weakView addSubview:picContentView];
    
    CGFloat padding = 8;
    
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(padding);
        make.left.mas_equalTo(weakView.mas_left).with.offset(8);
        make.right.mas_equalTo(weakView.mas_right).offset(-8);
    }];
    
    [lbFinder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbTitle.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(8);
    }];
    
    [lbDepart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbTitle.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-8);
    }];
    
    [lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbFinder.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.left.mas_equalTo(weakView.mas_left).with.offset(8);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-8);
    }];
    
    [picContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbDate.mas_bottom).offset(padding);
        make.left.mas_equalTo(weakView.mas_left);
        make.right.mas_equalTo(weakView.mas_right);
    }];
}


-(void) setData:(id<MyChuanKuaYueHistoryCellModel>) data
{
    lbTitle.text = [data cellTitle];
    [lbTitle sizeToFit];
    lbFinder.text = [data cellFinder];
    [lbFinder sizeToFit];
    lbDate.text = [data cellDate];
    [lbDate sizeToFit];
    lbDepart.text = [data cellDepartment];
    [lbDepart sizeToFit];
    
    [picContentView setPics:[data images]];
    if ([data video] && [data video].length>0) {
        [picContentView setVideo:[NSURL fileURLWithPath:data.video]];
    }
    [self relayoutPicContentView];
}

-(void) relayoutPicContentView
{
    CGFloat padding = 8;
    CGFloat height = [picContentView height];
    [picContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbDate.mas_bottom).offset(padding);
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(height);
    }];
}

+(CGFloat) heightForData:(id<MyChuanKuaYueHistoryCellModel>) data
{
    CGFloat height = 4*8+14*3;
    CGSize titleSize = [[data cellTitle] boundingRectWithSize:CGSizeMake(kScreenWidth-16, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                                  context:nil].size;
    height+=titleSize.height;
    
    NSInteger count = [data images].count+(([data video]==nil)?0:1);
    if (count >0) {
        height+= [ EventMediaCollectionView heightForItemCount:count] +10;
    }
    return height;
}

@end
