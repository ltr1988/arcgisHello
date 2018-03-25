//
//  TitleComboBoxCell.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2018/3/17.
//  Copyright © 2018年 fifila. All rights reserved.
//

#import "TitleComboBoxCell.h"
#import "CommonDefine.h"
#import "Masonry.h"

@interface TitleComboBoxCell()<ComBoxDelegate>
@end

@implementation TitleComboBoxCell

-(void) setupSubViews
{
    [super setupSubViews];
    
    __weak UIView *weakView = self.contentView;
    
    detail = [[ComboBox alloc] initWithFrame:CGRectMake(kScreenWidth - 192, 0, kScreenWidth - 192 - 16, 50)];
    detail.delegate = self;
    
    [weakView addSubview:detail];
    
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
    id<TitleComboBoxCellViewModel> item = (id<TitleComboBoxCellViewModel>)data;
    [detail setComboBoxData:item.dataSource];
    [detail setComboBoxTitle:item.selectText?:item.dataSource.firstObject];
}

-(void) setReadOnly:(BOOL)readOnly
{
    [super setReadOnly:readOnly];
    detail.button.enabled = !readOnly;
}
@end
