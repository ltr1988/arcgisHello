//
//  HttpManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#define QRSwitchViewTag 0x100000


#import "CenterSwitchView.h"

@implementation CenterSwitchView
- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andDelegate:(id<CenterSwitchActionDelegate>)aDelegate andSelectIndex:(NSInteger)index{
    if (self=[super initWithFrame:frame]) {
        
        self.selectIndex = index;
        self.delegate = aDelegate;

        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = CenetrSwitchHeight/2.0f;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = NormalColor.CGColor;
        self.layer.borderWidth = 1.0f;
        
        self.slideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CenetrSwitchWidth/2*index, 0, CenetrSwitchWidth/2, CenetrSwitchHeight)];
        self.slideImageView.backgroundColor = NormalColor;
        self.slideImageView.layer.cornerRadius = CenetrSwitchHeight/2.0f;
        self.slideImageView.layer.masksToBounds = YES;
        self.slideImageView.userInteractionEnabled = NO;
        [self addSubview:self.slideImageView];

        for (NSUInteger i=0; i<2; i++) {
            UILabel * label = [[UILabel alloc] init];
            label.frame = CGRectMake(CenetrSwitchWidth/2*i, 0, CenetrSwitchWidth/2, CenetrSwitchHeight);
            label.text = titleArray[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.userInteractionEnabled = YES;
            if (i == index) {
                label.textColor = SelectColor;
            }else{
                label.textColor = NormalColor;
            }
//            label.font = [UIFont systemFontOfSize:30];
            label.font = [UIFont systemFontOfSize:14];
            label.tag = QRSwitchViewTag+i;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [label addGestureRecognizer:tap];
            [self addSubview:label];
        }
        
        self.leftLabel = (UILabel *)[self viewWithTag:QRSwitchViewTag];
        
        self.rightLabel = (UILabel *)[self viewWithTag:QRSwitchViewTag+1];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollValueChanged:) name:Key_Notification_ScrollValueChanged object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    NSUInteger index = tap.view.tag - QRSwitchViewTag;

    self.selectIndex = index;
    if ([self.delegate respondsToSelector:@selector(centerSwitchToIndex:)]) {
        [self.delegate centerSwitchToIndex:self.selectIndex];
    }
    
}
- (void)scrollValueChanged:(NSNotification *)noti{
  
    if (![self.delegate isEqual:noti.object]) {
        return;
    }
    NSDictionary * userInfoDict = noti.userInfo;
    CGFloat rate = [userInfoDict[@"rate"] floatValue];
    
    CGFloat sr = 204,sg = 230,sb = 255;//白色
    CGFloat er = 89,eg = 134,eb = 191;//蓝色
    CGFloat rValue1 = 0,gValue1 = 0,bValue1 = 0,rValue2 = 0,gValue2 = 0,bValue2 = 0;
    
    rValue1 = sr+(er-sr)*rate;
    gValue1 = sg+(eg-sg)*rate;
    bValue1 = sb+(eb-sb)*rate;
    
    rValue2 = er+(sr-er)*rate;
    gValue2 = eg+(sg-eg)*rate;
    bValue2 = eb+(sb-eb)*rate;
    
    _slideImageView.frame = CGRectMake(CenetrSwitchWidth/2*rate, 0, CenetrSwitchWidth/2, CenetrSwitchHeight);
    
    _leftLabel.textColor = UIColorFromRBG(rValue2, gValue2, bValue2, 1);
    _rightLabel.textColor = UIColorFromRBG(rValue1, gValue1, bValue1, 1);

    
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}


@end
