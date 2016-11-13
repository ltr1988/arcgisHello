//
//  MyChuanKuaYueListItemCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyChuanKuaYueItem;
@protocol MyChuanKuaYueListItemCellModel <NSObject>

- (NSString *) cellTitle;
- (NSString *) cellUnit;
- (NSString *) cellLocation;

@end

@protocol MyChuanKuaYueListItemCellCallbackDelegate <NSObject>
-(void) mapLocationWithInfo:(MyChuanKuaYueItem*) info;
-(void) feedbackWithInfo:(MyChuanKuaYueItem*) info;
-(void) changeStatusWithInfo:(MyChuanKuaYueItem*) info;
@end

@interface MyChuanKuaYueListItemCell : UITableViewCell
{
    UILabel *lbTitle;
    UILabel *lbUnit;
    UILabel *lbPlace;

    
    UIButton *btnLocation;
    UIButton *btnFeedback;
    UIButton *btnChangeStatus;
}

+(CGFloat) heightForCell;
+(CGFloat) heightForHistoryCell;
-(instancetype) initHistoryWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
;
@property (nonatomic,weak) id<MyChuanKuaYueListItemCellCallbackDelegate> delegate;
@property (nonatomic,strong) MyChuanKuaYueItem* data;
@end
