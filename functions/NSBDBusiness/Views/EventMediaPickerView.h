//
//  EventMediaPickerCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/26.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefine.h"

@interface EventMediaPickerView : UIView

-(instancetype) initWithFrame:(CGRect)frame picCallback:(ActionCallback)picCallback videoCallback:(ActionCallback)videoCallback relayoutCallback:(ActionCallback)relayoutCallback;

-(void) addImages:(NSArray *)data;
-(void) setImages:(NSArray *)data;
-(void) setVideo:(NSString *)data;
-(void) relayout;
@end
