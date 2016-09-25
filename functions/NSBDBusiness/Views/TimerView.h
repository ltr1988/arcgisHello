//
//  TimerView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/26.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerView : UIView
{
    NSTimer *timer;
    NSInteger showTime;
}

@property (nonatomic,strong,readonly) UILabel *timeLabel;

@property (nonatomic,assign) BOOL pause;


+(instancetype) timerViewWithStartTime:(NSInteger) time frame:(CGRect) frame smallStyle:(BOOL) smallStyle;
-(instancetype) initWithStartTime:(NSInteger) time frame:(CGRect) frame;

-(void) setFont:(UIFont *)font;
-(void) setShowTime:(NSInteger) time;

-(void) pauseTiming;
-(void) continueTiming;
@end
