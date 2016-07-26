//
//  EventLocationPickerCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/26.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefine.h"


@interface EventLocationPickerView : UIView

-(instancetype) initWithFrame:(CGRect)frame callBack:(ActionCallback)callback;

@property (nonatomic,assign) CGPoint location;

@end
