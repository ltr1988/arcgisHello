//
//  ThreeColumnCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThreeColumnViewDelegate;

@interface ThreeColumnCell : UITableViewCell

@property (nonatomic,strong) id<ThreeColumnViewDelegate> data;
@end
