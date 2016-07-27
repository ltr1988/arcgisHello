//
//  CheckableImageView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/27.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefine.h"

@interface CheckableImageView : UIView

-(instancetype) initWithFrame:(CGRect)frame callBack:(ActionCallback) callback;
-(void) setBackgroundImageURL:(NSURL *)imageURL;

@end
