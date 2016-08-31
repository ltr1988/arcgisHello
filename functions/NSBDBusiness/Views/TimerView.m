//
//  TimerView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/26.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TimerView.h"
#import "CommonDefine.h"

@implementation TimerView


-(instancetype) initWithStartTime:(NSInteger) time frame:(CGRect) frame
{
    if (self = [super initWithFrame:frame]) {
        showTime = time;
        [self setupSubviews];
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect) frame
{
    if (self = [super initWithFrame:frame]) {
        showTime = 0;
        [self setupSubviews];
    }
    return self;
}

-(instancetype) init
{
    if (self = [super init]) {
        showTime = 0;
        [self setupSubviews];
    }
    return self;
}

-(void) setupSubviews
{
    self.backgroundColor = [UIColor orangeColor];
    
    _timeLabel = [[UILabel alloc] initWithFrame:self.bounds];;
    _timeLabel.font =UI_FONT(16);
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLabel];
    
}

-(void) setFont:(UIFont *)font
{
    _timeLabel.font = font;
}

-(void) setShowTime:(NSInteger) time
{
    showTime = time;
    _timeLabel.text = [self timeText];
}

-(void) pauseTiming
{
    _pause = YES;
    [timer invalidate];
    timer = nil;
    _timeLabel.text = [self timeText];
    
}

-(void) continueTiming
{
    _pause = NO;
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    _timeLabel.text = [self timeText];
    timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(actionTimer) userInfo:nil repeats:YES];
}

-(void) actionTimer
{
    showTime++;
    _timeLabel.text = [self timeText];
}

-(NSString *) timeText
{
    NSInteger h,m,s;
    h = showTime/3600;
    m = (showTime/60) %60;
    s = showTime % 60;
    return [NSString stringWithFormat:@"%ld:%02ld:%02ld%@",(long)h,(long)m,(long)s,_pause?@" (暂停)":@""];
}
@end