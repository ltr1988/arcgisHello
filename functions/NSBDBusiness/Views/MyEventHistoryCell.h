//
//  MyEventHistoryCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/7.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyEventHistoryItem;

@interface MyEventHistoryCell : UITableViewCell
-(void) setData:(MyEventHistoryItem *) data;
+(CGFloat) heightForData:(MyEventHistoryItem *) data;
@end
