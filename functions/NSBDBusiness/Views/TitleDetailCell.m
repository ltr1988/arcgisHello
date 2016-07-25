//
//  TitleDetailCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleDetailCell.h"
#import "CommonDefine.h"
#import "Masonry.h"

@implementation TitleDetailCell

-(void) setupSubViews
{
    [super setupSubViews];
    
    __weak UIView *weakView = self.contentView;
    
    detail = [UILabel new];
    detail.font = UI_FONT(12);
    detail.textColor = [UIColor blackColor];
    detail.backgroundColor = [UIColor clearColor];
    detail.textAlignment = NSTextAlignmentRight;
    
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
        make.left.mas_equalTo(label.mas_right).with.offset(16);
    }];

}

-(void) bindData:(id) data
{
    [super bindData:data];
    id<TitleDetailCellViewModel> item = (id<TitleDetailCellViewModel>)data;
    detail.text = [item detail];
}
@end
