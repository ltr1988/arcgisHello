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
    
    switchView = [[UISwitch alloc] init];
    [weakView addSubview:switchView];
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakView.mas_centerX);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
    }];
    
}

-(void) setData:(id)data
{
    if (self.data != nil) {
        [switchView removeObserver:self forKeyPath:@"on"];
    }
    _data = data;
    [self bindData:data];
}

-(void) bindData:(id) data
{
    [super bindData:data];
    id<CheckableTitleCellViewModel> item = (id<CheckableTitleCellViewModel>)data;
    
    switchView.on = [item checked];
    NSKeyValueObservingOptions static const
    options =
    NSKeyValueObservingOptionInitial |
    NSKeyValueObservingOptionOld |
    NSKeyValueObservingOptionNew;
    
    [switchView addObserver:self
                     forKeyPath:@"on"
                        options:options context:nil];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"on"]) {
        if (_data) {
            [_data setValue:change[NSKeyValueChangeNewKey] forKey:@"_checked"];
        }
    }
}

-(void) dealloc
{
    [switchView removeObserver:self forKeyPath:@"on"];
}
@end
