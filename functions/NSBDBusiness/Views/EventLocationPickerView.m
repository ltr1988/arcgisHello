//
//  EventLocationPickerCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/26.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventLocationPickerView.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "MapViewManager.h"
#import "NSString+Location.h"

@interface EventLocationPickerView()
{
    UILabel *title;
    UIButton * myLocationBtn;
    UIButton * locateInMapBtn;
}
@property (nonatomic,copy) ActionCallback callback;
@end


@implementation EventLocationPickerView


-(instancetype) initWithFrame:(CGRect)frame callBack:(ActionCallback)callback
{
    self = [super initWithFrame:frame];
    if (self) {
        self.location = CGPointMake(0, 0);
        self.callback = callback;
        [self setupSubViews];
    }
    return self;
}

-(void) setupSubViews
{
    __weak __typeof(self) weakSelf = self;
    
    title = [UILabel new];
    myLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locateInMapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [self addSubview:title];
    [self addSubview:myLocationBtn];
    [self addSubview:locateInMapBtn];
    
    
    title.font = UI_FONT(16);
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).with.offset(10);
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(weakSelf.mas_left).with.offset(16);
        make.width.mas_equalTo(myLocationBtn.mas_width);
    }];
    
    [myLocationBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [myLocationBtn setTitle:@"我的位置" forState:UIControlStateNormal];
    [myLocationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myLocationBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [myLocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).with.offset(10);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(title.mas_left);
        make.width.mas_equalTo(120);
    }];
    
    [locateInMapBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [locateInMapBtn setTitle:@"地图选点" forState:UIControlStateNormal];
    [locateInMapBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [locateInMapBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [locateInMapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(-16);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(60);
    }];
    
    
    [myLocationBtn addTarget:self action:@selector(actionMyLocation) forControlEvents:UIControlEventTouchUpInside];
    
    [locateInMapBtn addTarget:self action:@selector(actionLocate) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) actionMyLocation
{
    AGSLocation *location = [MapViewManager sharedMapView].locationDisplay.location;
    if (location) {
        title.text = [NSString stringWithLocationAGSPoint:location.point];
        [title sizeToFit];
    }else
    {
        title.text = [NSString stringWithLatitude:116. Lontitude:40.];
        [title sizeToFit];

    }
}

-(void) actionLocate
{
    SafelyDoBlock(_callback);
}

-(void) setLocation:(CGPoint) location
{
    _location = location;
    title.text = [NSString stringWithLocationPoint:location];
    [title sizeToFit];
}
@end
