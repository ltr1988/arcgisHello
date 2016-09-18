//
//  ThreeColumnView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/16.
//  Copyright © 2016年 fifila. All rights reserved.
//
@protocol ThreeColumnViewDelegate <NSObject>

@optional
-(NSString *) firstColumnText;
-(NSString *) secondColumnText;
-(NSString *) thirdColumnText;

-(UIColor *) firstColumnColor;
-(UIColor *) secondColumnColor;
-(UIColor *) thirdColumnColor;
@end

#import <UIKit/UIKit.h>



@interface ThreeColumnView : UIView

-(void) setData:(id<ThreeColumnViewDelegate>) data;

@end
