//
//  EventMediaPickerCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/26.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventMediaPickerView.h"
#import "CommonDefine.h"
#import "Masonry.h"

@interface EventMediaPickerView()
{
    UIButton * pickImageBtn;
    UIButton * pickVideoBtn;
}
@property (nonatomic,copy) ActionCallback callback;
@end

@implementation EventMediaPickerView

-(instancetype) initWithFrame:(CGRect)frame callBack:(ActionCallback)callback{
    self = [super initWithFrame:frame];
    if (self) {
        self.callback = callback;
    }
    return self;
}
@end
