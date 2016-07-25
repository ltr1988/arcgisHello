//
//  QRSeparatorCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 15/12/1.
//  Copyright © 2015年 _tencent_. All rights reserved.
//



#import <Foundation/Foundation.h>





@interface QRSeparatorView : UIView

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) BOOL topBorder;
@property (nonatomic, assign) BOOL bottomBorder;
-(void) customizeStyle: (UIColor *) bgColor borderColor:(UIColor *) borderColor;
-(void) customizeStyle: (UIColor *) bgColor borderColor:(UIColor *) borderColor needTopBorder:(BOOL)needTopBorder needBottomBorder:(BOOL)needBottomBorder;
@end


@interface QRSeparatorCell : UITableViewCell
-(void) customizeStyle: (UIColor *) bgColor borderColor:(UIColor *) borderColor;
-(void) customizeStyle: (UIColor *) bgColor borderColor:(UIColor *) borderColor needTopBorder:(BOOL)needTopBorder needBottomBorder:(BOOL)needBottomBorder;
@end
