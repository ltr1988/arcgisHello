//
//  UITableView+EmptyView.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyView)

-(void) setEmptyView;
-(void) setEmptyView:(UIView*) emptyView;
-(void) removeEmptyView;
@end
