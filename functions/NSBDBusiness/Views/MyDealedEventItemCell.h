//
//  MyDealedEventItemCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDealedEventItemCellModel <NSObject>

- (NSString *) title;
- (NSString *) name;
- (NSString *) date;

- (NSString *) executor;

@end

@interface MyDealedEventItemCell : UITableViewCell
{
    UILabel *lbTitle;
    UILabel *lbDate;
    
    UILabel *lbName;
    UILabel *lbEexecutor;
    
}

-(void) setData:(id<MyDealedEventItemCellModel> ) data;
+(CGFloat) heightForCell;

@end
