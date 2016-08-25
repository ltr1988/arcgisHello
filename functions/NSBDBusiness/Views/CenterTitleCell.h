//
//  CenterTitleCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/8/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterTitleCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLabel;

-(void) setTitle:(NSString *)title;
@end
