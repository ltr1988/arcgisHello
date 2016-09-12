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
#import "UIButton+UIButtonSetEdgeInsets.h"
#import "LocationManager.h"
#import "SVProgressHUD.h"

@interface EventLocationPickerView()
{
    UILabel *title;
    UIButton * myLocationBtn;
    UIButton * locateInMapBtn;
    LocationManager* manager;
}
@property (nonatomic,copy) ActionCallback callback;
@property (nonatomic,assign) BOOL readOnly;
@end


@implementation EventLocationPickerView


-(instancetype) initWithFrame:(CGRect)frame readOnly:(BOOL)readOnly callBack:(ActionCallback)callback
{
    self = [super initWithFrame:frame];
    if (self) {
        self.readOnly = readOnly;
        self.location = CGPointMake(0, 0);
        self.callback = callback;
        [self setupSubViews];
        [self setupMembers];
        [self actionMyLocation];
    }
    return self;
}

-(void) setupMembers
{
    manager = [[LocationManager alloc] initWthCallback:^(NSDictionary *dict) {
        if (dict[@"error"] == nil) {
            NSString *place = dict[@"place"];
            if (place) {
                title.text = place;
            }else
            {
                CLLocation * location = dict[@"location"];
                if (location) {
                    self.location = CGPointMake(location.coordinate.latitude, location.coordinate.longitude);
                }else
                {
                    self.location = CGPointMake(40.,116.);
                }
                title.text = [NSString stringWithLocationPoint:self.location];
            }
        }else
        {
            self.location = CGPointMake(40.,116.);
            title.text = [NSString stringWithLocationPoint:self.location];
        }
        
        if ([SVProgressHUD isVisible])
        {
            [SVProgressHUD dismiss];
        }
    }];
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
    title.textAlignment = NSTextAlignmentLeft;
    title.lineBreakMode = NSLineBreakByTruncatingMiddle;
    title.textColor = [UIColor blackColor];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).with.offset(10);
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(weakSelf.mas_left).with.offset(16);
        make.right.mas_equalTo(locateInMapBtn.mas_left).offset(-16);
    }];
    
    
    UIColor *gray = UI_COLOR(130, 131, 131);
    [myLocationBtn setImage:[UIImage imageNamed:@"icon_map_searchpoint"] forState:UIControlStateNormal];
    [myLocationBtn setTitle:@"我的位置" forState:UIControlStateNormal];
    [myLocationBtn setTitleColor:gray forState:UIControlStateNormal];
    [myLocationBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    myLocationBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [myLocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).with.offset(10);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(title.mas_left);
        make.width.mas_equalTo(120);
    }];
    
    UIColor *blue = UI_COLOR(20, 141, 217);
    
    [locateInMapBtn setImage:[UIImage imageNamed:@"mappoint"] forState:UIControlStateNormal];
    [locateInMapBtn setTitle:@"地图选点" forState:UIControlStateNormal];
    [locateInMapBtn setTitleColor:blue forState:UIControlStateNormal];
    [locateInMapBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    locateInMapBtn.layer.borderColor = blue.CGColor;
    locateInMapBtn.layer.borderWidth = 1.5;
    locateInMapBtn.layer.cornerRadius = 5;
    
    [locateInMapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(-16);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
    [locateInMapBtn verticalCenterImageAndTitle];
    [myLocationBtn addTarget:self action:@selector(actionMyLocation) forControlEvents:UIControlEventTouchUpInside];
    
    [locateInMapBtn addTarget:self action:@selector(actionLocate) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) actionMyLocation
{
    if (!_readOnly) {
        [manager startLocating];
    }
    
    
}


-(void) actionLocate
{
    if (!_readOnly) {
        SafelyDoBlock(_callback);
    }
}

-(void) setLocation:(CGPoint) location
{
    _location = location;
    title.text = [NSString stringWithLocationPoint:location];
}
@end
