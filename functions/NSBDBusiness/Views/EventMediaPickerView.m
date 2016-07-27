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
#import "UIKit+AFNetworking.h"

@interface EventMediaPickerView()
{
    UIButton * pickImageBtn;
    UIButton * pickVideoBtn;
    
    UIView * picContentView;
    
    
    NSArray *imageViews;
    
}

@property (nonatomic,copy) ActionCallback picCallback;
@property (nonatomic,copy) ActionCallback videoCallback;
@end

@implementation EventMediaPickerView

-(instancetype) initWithFrame:(CGRect)frame picCallback:(ActionCallback)picCallback videoCallback:(ActionCallback)videoCallback {
    self = [super initWithFrame:frame];
    if (self) {
        self.picCallback = picCallback;
        self.videoCallback = videoCallback;
        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews
{
    pickImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pickVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    picContentView = [UIView new];
    UIView *vLine,*hLine;
    vLine = [UIView new];
    hLine = [UIView new];
    
    [pickImageBtn setImage:[UIImage imageNamed:@"RedPushpin"] forState:UIControlStateNormal];
    [pickImageBtn setTitle:@"照片上传" forState:UIControlStateNormal];
    
    [pickVideoBtn setImage:[UIImage imageNamed:@"RedPushpin"] forState:UIControlStateNormal];
    [pickVideoBtn setTitle:@"视频上传" forState:UIControlStateNormal];
    
    vLine.backgroundColor = [UIColor lightGrayColor];

    hLine.backgroundColor = [UIColor lightGrayColor];
    
    picContentView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:pickImageBtn];
    [self addSubview:pickVideoBtn];
    [self addSubview:picContentView];
    [self addSubview:vLine];
    [self addSubview:hLine];
    
    
    //layout
    __weak __typeof(self) weakSelf = self;
    [pickImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(vLine.mas_left);
        make.bottom.mas_equalTo(30);
    }];
    
    [pickVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.left.mas_equalTo(vLine.mas_right);
        make.bottom.mas_equalTo(30);
    }];
    
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(8);
        make.bottom.mas_equalTo(pickVideoBtn.mas_bottom).offset(-8);
        make.width.mas_equalTo(0.5);
        make.left.mas_equalTo(weakSelf.mas_centerX);
    }];
    
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pickVideoBtn.mas_bottom);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-8);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(weakSelf.mas_left).offset(8);
    }];
    
    [picContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLine.mas_bottom);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
}

-(void) setData:(NSArray *)data
{
    
}
@end
