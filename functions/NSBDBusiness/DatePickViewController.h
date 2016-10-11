//
//  DatePickViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"
#import "UIViewController+BackButtonHandler.h"
@class TitleDateItem;

@interface DatePickViewController : SupportRotationSelectBaseViewController
-(instancetype) initWithDate:(NSDate *)initDate;

-(instancetype) initWithData:(TitleDateItem *)data;
-(instancetype) initWithData:(TitleDateItem *)data readOnly:(BOOL) readOnly;
@end
