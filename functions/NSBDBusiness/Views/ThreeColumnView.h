//
//  ThreeColumnView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThreeColumnViewDelegate <NSObject>

@optional
-(NSString *) firstColumnText;
-(NSString *) secondColumnText;
-(NSString *) thirdColumnText;

-(UIColor *) firstColumnColor;
-(UIColor *) secondColumnColor;
-(UIColor *) thirdColumnColor;
@end

@interface ThreeColumnView : UIView

-(void) setData:(id<ThreeColumnViewDelegate>) data;

@end
