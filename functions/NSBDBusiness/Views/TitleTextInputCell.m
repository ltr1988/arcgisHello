//
//  EventReportTextInputCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleTextInputCell.h"
#import "CommonDefine.h"
#import "Masonry.h"

@implementation TitleTextInputCell

-(void) setupSubViews
{
    [super setupSubViews];
    __weak UIView *weakView = self.contentView;
    
    inputTextField = [UITextField new];
    inputTextField.textAlignment = NSTextAlignmentRight;
    inputTextField.font = UI_FONT(16);
    inputTextField.textColor = [UIColor blackColor];
    inputTextField.delegate = self;
    
    [weakView addSubview:inputTextField];
    
    [inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
        make.left.mas_equalTo(label.mas_right).with.offset(16);
    }];
    
    
}


-(void) bindData:(id) data
{
    [super bindData:data];
    id<TitleTextInputCellViewModel> item = (id<TitleTextInputCellViewModel>)data;
    inputTextField.text = [item detail];
    inputTextField.placeholder = [item placeholder];
    NSKeyValueObservingOptions static const
    options =
    NSKeyValueObservingOptionInitial |
    NSKeyValueObservingOptionOld |
    NSKeyValueObservingOptionNew;
    [inputTextField addObserver:self
           forKeyPath:@"text"
              options:options context:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_data) {
        [_data setValue:textField.text forKey:@"_detail"];
    }
    [textField resignFirstResponder];
    return YES;
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"]) {
        if (_data) {
            [_data setValue:change[NSKeyValueChangeNewKey] forKey:@"_detail"];
        }
    }
}

-(void) dealloc
{
    [inputTextField removeObserver:self forKeyPath:@"text"];
}

@end
