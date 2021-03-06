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

-(void) setKeyBoardType:(UIKeyboardType) type
{
    inputTextField.keyboardType=type;
}

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:nil];
}


-(void) setData:(id)data
{
    _data = data;
    [self bindData:data];
}

-(void) bindData:(id) data
{
    [super bindData:data];
    id<TitleTextInputCellViewModel> item = (id<TitleTextInputCellViewModel>)data;
    inputTextField.text = [item detail];
    inputTextField.placeholder = [item placeholder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_data) {
        [_data setValue:textField.text forKey:@"_detail"];
    }
    [textField resignFirstResponder];
    return YES;
}

-(void) textFieldEditChanged
{
    if (_data) {
        [_data setValue:inputTextField.text forKey:@"_detail"];
    }
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) setReadOnly:(BOOL)readOnly
{
    [super setReadOnly:readOnly];
    inputTextField.enabled = !readOnly;
}
@end
