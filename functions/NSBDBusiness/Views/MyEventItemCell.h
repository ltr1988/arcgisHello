//
//  MyEventItemCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MyEventItemCellModel <NSObject>

- (NSString *) title;
- (NSString *) date;
- (NSString *) place;

- (NSString *) finder;
- (NSString *) xingzhi;
- (NSString *) level;

@end

@interface MyEventItemCell : UITableViewCell
{
    UILabel *lbTitle;
    UILabel *lbDate;
    
    UILabel *lbPlace;
    UILabel *lbFinder;
    
    UILabel *lbXingzhiContent;
    UILabel *lbLevelContent;
    
    UIImageView *nextIcon;
    UIImageView *placeIcon;
}

-(void) setData:(id<MyEventItemCellModel> ) data;
+(CGFloat) heightForCell;

@end
