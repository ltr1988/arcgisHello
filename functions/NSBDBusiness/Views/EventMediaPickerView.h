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
@property (nonatomic,strong) NSArray * data;
-(instancetype) initWithFrame:(CGRect)frame picCallback:(ActionCallback)picCallback videoCallback:(ActionCallback)videoCallback ;
@end
