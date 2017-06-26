//
//  ItemCallOutView.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ItemCallOutView.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "UIColor+ThemeColor.h"

@interface ItemCallOutView()
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIButton *goHereView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIButton *infoButton;
@property (nonatomic,strong) UIButton *webSiteButton;
@end

@implementation ItemCallOutView

-(instancetype) init
{
    self = [super init];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

-(void) setupSubViews
{
    self.backgroundColor = [UIColor clearColor];
    
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.left.right.bottom.offset(0);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:20];

    _detailLabel = [UILabel new];
    _detailLabel.font = [UIFont systemFontOfSize:12];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location"]];
    imgView.backgroundColor = [UIColor clearColor];
    
    UIView *lineVertical,*line;
    line = [[UIView alloc] init];
    line.backgroundColor = [UIColor borderColor];
    
    lineVertical = [[UIView alloc] init];
    lineVertical.backgroundColor = [UIColor lightGrayColor];
    
    
    _infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _webSiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_infoButton setImage:[UIImage imageNamed:@"icon_jbxx"] forState:UIControlStateNormal];
    [_infoButton setImage:[UIImage imageNamed:@"icon_jbxx_disable"] forState:UIControlStateDisabled];
    _infoButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _infoButton.backgroundColor = [UIColor clearColor];
    _infoButton.titleLabel.font = UI_FONT(16);
    [_infoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_infoButton setTitle:@"基本信息" forState:UIControlStateNormal];
    
    [_webSiteButton setImage:[UIImage imageNamed:@"icon_swxx"] forState:UIControlStateNormal];
    [_webSiteButton setImage:[UIImage imageNamed:@"icon_swxx_disable"] forState:UIControlStateDisabled];
    _webSiteButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_webSiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _webSiteButton.titleLabel.font = UI_FONT(16);
    _webSiteButton.backgroundColor = [UIColor clearColor];
    [_webSiteButton setTitle:@"三维模型" forState:UIControlStateNormal];
    
    
    _goHereView = [[UIButton alloc] init];
    _goHereView.backgroundColor = [UIColor themeBlueColor];
    [_goHereView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _goHereView.titleLabel.font = UI_FONT(16);
    [_goHereView setTitle:@"去这里" forState:UIControlStateNormal];
    _goHereView.clipsToBounds = YES;
    _goHereView.layer.cornerRadius = 30;
    [self addSubview:_goHereView];
    [_goHereView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.offset(-16);
        make.width.height.mas_equalTo(60);
    }];
    
    
    
    [self.contentView addSubview:imgView];
    [self.contentView addSubview:_infoButton];
    [self.contentView addSubview:_titleLabel];
    
    [self.contentView addSubview:_detailLabel];
    [self.contentView addSubview:_webSiteButton];
    
    [self.contentView addSubview:lineVertical];
    [self.contentView addSubview:line];

    [_infoButton addTarget:self action:@selector(actionMoreInfo) forControlEvents:UIControlEventTouchUpInside];
    [_webSiteButton addTarget:self action:@selector(actionGotoWebsite) forControlEvents:UIControlEventTouchUpInside];
    [_goHereView addTarget:self action:@selector(actionGoHere) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //layout
    __weak UIView* weakSelf = self.contentView;
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(16);
        make.centerY.mas_equalTo(_detailLabel.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgView.mas_right).offset(8);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(weakSelf.mas_top).offset(8);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(8);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(weakSelf.mas_top).offset(8);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(16);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-16);
        make.height.mas_equalTo(.5f);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(8);
    }];
    
    [lineVertical mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-8);
        make.top.mas_equalTo(line.mas_bottom).offset(8);
    }];
    
    [_infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(lineVertical.mas_left);
        make.centerY.mas_equalTo(lineVertical.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
    [_webSiteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right);
        make.left.mas_equalTo(lineVertical.mas_right);
        make.centerY.mas_equalTo(lineVertical.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
}



-(void) setModel:(id<ItemCallOutViewModel>)model
{
    _model = model;
    _titleLabel.text = [model title];
    _detailLabel.text = [model detail];
    [_titleLabel sizeToFit];
    [_detailLabel sizeToFit];
    if ([model moreInfo] == nil) {
        _infoButton.enabled = NO;
    }
    if ([model webSiteInfo] == nil) {
        _webSiteButton.enabled = NO;
    }
}

-(void) actionMoreInfo
{
    if (_moreInfoCallback) {
        _moreInfoCallback([_model moreInfo]);
    }
}

-(void) actionGotoWebsite
{
    if (_webSiteCallback) {
        _webSiteCallback([_model webSiteInfo]);
    }
}

-(void) actionGoHere
{
    if (_goHereCallback) {
        _goHereCallback(_model);
    }
}
@end
