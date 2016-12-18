//
//  DepthCalloutView.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DepthCalloutViewCallback)(UIImage *image);
@interface DepthCalloutView : UIView
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *lbLine1;

@property (nonatomic,copy) DepthCalloutViewCallback imageTapped;
@end
