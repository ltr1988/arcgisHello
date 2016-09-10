//
//  MyEventItemCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyEventItem;
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

-(void) setData:(MyEventItem *) data;
+(CGFloat) heightForCell;

@end
