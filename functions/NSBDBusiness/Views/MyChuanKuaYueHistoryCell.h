//
//  MyChuanKuaYueHistoryCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyChuanKuaYueHistoryCellModel<NSObject>
-(NSString *)cellTitle;
-(NSString *)cellDate;
-(NSString *)cellFinder;
-(NSString *)cellDepartment;
-(NSArray *)images;
-(NSString *)video;
@end

@interface MyChuanKuaYueHistoryCell : UITableViewCell
-(void) setData:(id<MyChuanKuaYueHistoryCellModel>) data;
+(CGFloat) heightForData:(id<MyChuanKuaYueHistoryCellModel>) data;
@end
