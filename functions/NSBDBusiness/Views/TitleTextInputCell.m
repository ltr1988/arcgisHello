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
    __weak UIView *weakView = self.contentView;
    
    textField = [UITextField new];
    textField.textAlignment = NSTextAlignmentRight;
    textField.font = UI_FONT(13);
    textField.placeholder = @"";
    textField.textColor = [UIColor blackColor];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top);
        make.bottom.mas_equalTo(weakView.mas_bottom);
        make.right.mas_equalTo(weakView.mas_right).with.offset(-16);
        make.left.mas_equalTo(label.mas_right).with.offset(16);
    }];
    
    [weakView addSubview:textField];
}

-(NSString *) textForInput
{
    return textField.text;
}

-(void)bindData:(id<TitleOnlyCellViewModel>)data
{
    
}
@end
