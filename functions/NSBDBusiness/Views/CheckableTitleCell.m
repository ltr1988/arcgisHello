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
    
    switchView = [[DCRoundSwitch alloc] init];
    switchView.onTintColor = [UIColor redColor];
    switchView.onText = @"异常";
    switchView.offText = @"正常";

    [switchView addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventValueChanged];
    [weakView addSubview:switchView];
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakView.mas_centerY);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
        make.width.mas_equalTo(77);
        make.height.mas_equalTo(27);
    }];
    
}

-(DCRoundSwitch *)switchView
{
    return switchView;
}

-(void) actionSwitch:(id)sender
{
    if ([_data respondsToSelector:@selector(setChecked:)]) {
        [_data setChecked:[switchView isOn]];
    }
    
}

-(void) setData:(id)data
{
    _data = data;
    [self bindData:data];
}

-(void) bindData:(id) data
{
    [super bindData:data];
    id<CheckableTitleCellViewModel> item = (id<CheckableTitleCellViewModel>)data;
    
    switchView.on = [item checked];
}

-(void) setReadOnly:(BOOL)readOnly
{
    [super setReadOnly:readOnly];
    switchView.enabled = !readOnly;
}
@end
