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
    self. backgroundColor = [UIColor clearColor];
    _titleLabel = [UILabel new];
    _infoButton = [UIButton new];
    _webSiteButton = [UIButton new];
    
    _titleLabel.frame = CGRectMake(10, 10, 90, 13);
    _titleLabel.font = [UIFont systemFontOfSize:13];
    
    _infoButton.frame = CGRectMake(10, 33, 30, 30);
    _infoButton.backgroundColor = [UIColor redColor];
    _infoButton.layer.cornerRadius = 15;
    [_infoButton setTitle:@"i" forState:UIControlStateNormal];
    
    _webSiteButton.frame = CGRectMake(60, 33, 30, 30);
    _webSiteButton.backgroundColor = [UIColor blueColor];
    _webSiteButton.layer.cornerRadius = 15;
    [_webSiteButton setTitle:@"w" forState:UIControlStateNormal];
    
    
    [self addSubview:_infoButton];
    [self addSubview:_titleLabel];
    [self addSubview:_webSiteButton];

    [_infoButton addTarget:self action:@selector(actionMoreInfo) forControlEvents:UIControlEventTouchUpInside];
    [_webSiteButton addTarget:self action:@selector(actionGotoWebsite) forControlEvents:UIControlEventTouchUpInside];
}

-(void) setModel:(id<ItemCallOutViewModel>)model
{
    _model = model;
    _titleLabel.text = [model title];
    
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
