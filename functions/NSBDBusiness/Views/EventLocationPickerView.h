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

/**
 *  initWithFrame
 *
 *  @param frame
 *  @param callback callback for locate in map
 *
 *  @return instance type
 */
-(instancetype) initWithFrame:(CGRect)frame
                     readOnly:(BOOL)readOnly
                     callBack:(ActionCallback)callback;

@property (nonatomic,assign) CGPoint location;
@end
