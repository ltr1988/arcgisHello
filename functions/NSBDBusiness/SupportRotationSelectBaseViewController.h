//
//  NoRotationBaseViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ToastView.h"
@protocol CustomNaviBack <NSObject>

-(BOOL) customBackAction;

@end

@interface SupportRotationSelectBaseViewController : UIViewController


-(BOOL) hideNavBar;
-(BOOL) supportRotation;
@end
