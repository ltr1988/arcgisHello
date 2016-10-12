//
//  SearchHistoryHomeTableViewCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchHistoryItem;

@interface SearchHistoryHomeTableViewCell : UITableViewCell
{
    UILabel *lbName;
    UILabel *lbStartDate;
    UILabel *lbEndDate;
}

@property (nonatomic,strong) SearchHistoryItem *data;
+(CGFloat) heightForCell;
@end
