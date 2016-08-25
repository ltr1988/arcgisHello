//
//  RouteSearchResultCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteSearchResultCell : UITableViewCell

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *leftIcon;

-(void) setTitle:(NSString *) text;
@end
