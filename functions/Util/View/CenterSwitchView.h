//
//  HttpManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRBG(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#define CenetrSwitchWidth 170
#define CenetrSwitchLabelWidth 85
#define CenetrSwitchHeight 27

@protocol CenterSwitchActionDelegate <NSObject>

@optional
- (void)centerSwitchToIndex:(NSUInteger)index;

@end

@interface CenterSwitchView : UIView

@property (nonatomic,weak) id<CenterSwitchActionDelegate> delegate;
@property (nonatomic,retain) UIImageView *slideImageView;
@property (nonatomic,retain) UILabel *leftLabel;
@property (nonatomic,retain) UILabel *rightLabel;
@property (nonatomic,assign) NSUInteger selectIndex;

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andDelegate:(id<CenterSwitchActionDelegate>)aDelegate andSelectIndex:(NSInteger)index;

@end

