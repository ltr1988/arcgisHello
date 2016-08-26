//
//  SearchSessionItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchSessionItem : NSObject<NSCoding,NSCopying>
@property (nonatomic,copy) NSString *sessionId;
@property (nonatomic,assign) NSInteger sessionTime; //单位 秒，已经记录的时间 暂停一次记录一次
@property (nonatomic,assign) double sessionStartTime; //since 1970，起算时间 暂停一次记一次
@property (nonatomic,assign) BOOL pauseState;

//总时间 ＝ sessionTime ＋ （now － sessionStartTime）
-(NSInteger) totalTime;
-(void) resetTime:(BOOL)willPause;
@end
