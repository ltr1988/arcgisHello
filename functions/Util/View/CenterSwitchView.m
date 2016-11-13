//
//  HttpManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#define QRSwitchViewTag 0x100000


#import "CenterSwitchView.h"
#import "UIColor+ThemeColor.h"

#define SelectColor [UIColor whiteColor]
#define NormalColor [UIColor themeBlueColor]
@implementation CenterSwitchView
{
    NSInteger titleCount;
}
- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andDelegate:(id<CenterSwitchActionDelegate>)aDelegate andSelectIndex:(NSInteger)index{
    if (self=[super initWithFrame:frame]) {
        titleCount = titleArray.count;
        self.selectIndex = index;
        self.delegate = aDelegate;

        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = CenetrSwitchHeight/2.0f;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = NormalColor.CGColor;
        self.layer.borderWidth = 1.0f;
        
        self.slideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CenetrSwitchLabelWidth*index, 0, CenetrSwitchLabelWidth, CenetrSwitchHeight)];
        self.slideImageView.backgroundColor = NormalColor;
        self.slideImageView.layer.cornerRadius = CenetrSwitchHeight/2.0f;
       // self.slideImageView.layer.masksToBounds = YES;
        self.slideImageView.userInteractionEnabled = NO;
        [self addSubview:self.slideImageView];

        for (NSUInteger i=0; i<titleArray.count; i++) {
            UILabel * label = [[UILabel alloc] init];
            label.frame = CGRectMake(CenetrSwitchLabelWidth*i, 0, CenetrSwitchLabelWidth, CenetrSwitchHeight);
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
    
    _slideImageView.frame = CGRectMake(CenetrSwitchLabelWidth*index, 0, CenetrSwitchLabelWidth, CenetrSwitchHeight);
    
    for (int i=0; i<titleCount; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:QRSwitchViewTag+i];
        label.textColor = (index!=i ? NormalColor: SelectColor);
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}


@end
