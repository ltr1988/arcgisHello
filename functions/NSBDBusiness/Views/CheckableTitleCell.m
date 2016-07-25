//
//  CheckableTitleCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "CheckableTitleCell.h"
#import "CommonDefine.h"
#import "Masonry.h"

@implementation CheckableTitleCell
-(void) setupSubViews
{
    [super setupSubViews];
    
    __weak UIView *weakView = self.contentView;
    
    checkImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RedPushpin"]];
    
    
    [checkImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
        make.left.mas_equalTo(label.mas_right).with.offset(16);
    }];
    
}

-(void) bindData:(id) data
{
    [super bindData:data];
    id<CheckableTitleCellViewModel> item = (id<CheckableTitleCellViewModel>)data;
    checkImgView.hidden = ![item checked];
}
@end
