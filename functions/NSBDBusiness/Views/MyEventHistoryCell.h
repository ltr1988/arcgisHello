//
//  MyEventHistoryCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/7.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyEventHistoryItem;

@protocol MyEventHistoryCellModel<NSObject>
-(NSString *)title;
-(NSString *)date;
-(NSString *)finder;
-(NSString *)place;
-(NSArray *)images;
-(NSString *)video;
@end

@interface MyEventHistoryCell : UITableViewCell
-(void) setData:(id<MyEventHistoryCellModel>) data;
+(CGFloat) heightForData:(id<MyEventHistoryCellModel>) data;
@end
