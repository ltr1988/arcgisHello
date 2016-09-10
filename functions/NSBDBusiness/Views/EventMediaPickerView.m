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
#import "UIColor+ThemeColor.h"
#import "EventMediaCollectionView.h"

@interface EventMediaPickerView()
{
    UIButton * pickImageBtn;
    UIButton * pickVideoBtn;
    UIView *vLine,*hLine;
    EventMediaCollectionView * picContentView;
    
}

@property (nonatomic,copy) ActionCallback picCallback;
@property (nonatomic,copy) ActionCallback videoCallback;
@property (nonatomic,copy) ActionCallback relayoutCallback;

@end

@implementation EventMediaPickerView

-(instancetype) initWithFrame:(CGRect)frame picCallback:(ActionCallback)picCallback videoCallback:(ActionCallback)videoCallback relayoutCallback:(ActionCallback)relayoutCallback{
    self = [super initWithFrame:frame];
    if (self) {
        self.picCallback = picCallback;
        self.videoCallback = videoCallback;
        self.relayoutCallback = relayoutCallback;
        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews
{
    pickImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pickVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    pickImageBtn.frame = CGRectMake(0, 0, kScreenWidth, 60);
    
    pickVideoBtn.frame = CGRectMake(0, 0, kScreenWidth, 60);
    
    picContentView = [[EventMediaCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    vLine = [UIView new];
    hLine = [UIView new];
    
    [pickImageBtn setImage:[UIImage imageNamed:@"icon_photo"] forState:UIControlStateNormal];
    [pickImageBtn setTitle:@"照片上传" forState:UIControlStateNormal];
    pickImageBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [pickImageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pickImageBtn addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
    [pickImageBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    
    [pickVideoBtn setImage:[UIImage imageNamed:@"icon_movie"] forState:UIControlStateNormal];
    [pickVideoBtn setTitle:@"视频上传" forState:UIControlStateNormal];
    pickVideoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [pickVideoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pickVideoBtn addTarget:self action:@selector(pickVideo) forControlEvents:UIControlEventTouchUpInside];
    [pickVideoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    
    vLine.backgroundColor = [UIColor borderColor];

    hLine.backgroundColor = [UIColor borderColor];
    
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
        make.height.mas_equalTo(60);
    }];
    
    [pickVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.left.mas_equalTo(vLine.mas_right);
        make.height.mas_equalTo(60);
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
    }];
    
    picContentView.callBack = ^{
        [weakSelf relayout];
    };
    [self adjustFrame];
}

-(void) adjustFrame
{
    CGRect frame = self.frame;
    frame.size.height = pickVideoBtn.frame.size.height + picContentView.frame.size.height;
    self.frame =frame;
}

-(void) pickImage
{
    SafelyDoBlock(_picCallback);
}

-(void) pickVideo
{
    SafelyDoBlock(_videoCallback);
}

-(void) relayout
{
    
    CGFloat height = [picContentView height];
    __weak __typeof(self) weakSelf = self;
    [picContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hLine.mas_bottom);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(height);
    }];
    
    [self adjustFrame];
    SafelyDoBlock(self.relayoutCallback);
}

-(void) setImages:(NSArray *)data
{
    if (nil == data)
        return;
    //set picContentView.frame for data counts
    [picContentView setPics:data];

}

-(void) setVideo:(NSURL *)data
{
    //set picContentView.frame for data counts
    if (nil == data)
        return;
    [picContentView setVideo:data];
}

@end
