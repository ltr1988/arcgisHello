//
//  ItemCallOutView.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ItemCallOutView.h"
#import "CommonDefine.h"

@interface ItemCallOutView()
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
    self.bounds = CGRectMake(0, 0, 100, 70);
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
            }
    self.bounds = CGRectMake(0, 0, 100, 70);
    return self;
}

-(void) setupSubViews
{
    CGFloat height = 30,y = 0;
    
    self. backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [UILabel new];
    _titleLabel.frame = CGRectMake(10, y, 90, height);
    _titleLabel.font = [UIFont systemFontOfSize:13];

    _detailLabel = [UILabel new];
    _detailLabel.frame = CGRectMake(10+90, y, 90, height);
    _detailLabel.font = [UIFont systemFontOfSize:10];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, height)];
    imgView.backgroundColor = [UIColor redColor];
    
    UIView *lineVertical,*line;
    line = [[UIView alloc] initWithFrame:CGRectMake(10, height +10, kScreenWidth - 10, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    lineVertical = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2, height +20,  0.5, height)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    
    _infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _webSiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _infoButton.frame = CGRectMake(10, 33, 30, 30);
    _infoButton.backgroundColor = [UIColor clearColor];
    [_infoButton setTitle:@"基本信息" forState:UIControlStateNormal];
    
    _webSiteButton.frame = CGRectMake(60, 33, 30, 30);
    _webSiteButton.backgroundColor = [UIColor clearColor];
    [_webSiteButton setTitle:@"三维模型" forState:UIControlStateNormal];
    
    
    
    [self addSubview:imgView];
    [self addSubview:_infoButton];
    [self addSubview:_titleLabel];
    
    [self addSubview:_detailLabel];
    [self addSubview:_webSiteButton];

    [_infoButton addTarget:self action:@selector(actionMoreInfo) forControlEvents:UIControlEventTouchUpInside];
    [_webSiteButton addTarget:self action:@selector(actionGotoWebsite) forControlEvents:UIControlEventTouchUpInside];
}

-(void) setModel:(id<ItemCallOutViewModel>)model
{
    _model = model;
    _titleLabel.text = [model title];
    _detailLabel.text = [model detail];
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
@end
