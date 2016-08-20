//
//  TitleOnlyInputCell.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleOnlyCellViewModel <NSObject>

-(NSString *) title;

@end


@interface BaseTitleCell : UITableViewCell
{
    UILabel *label;
    id _data;
}

@property (nonatomic,strong) id data;

-(void) setupSubViews;
-(void) setData:(id)data;
-(void) bindData:(id) data;

@end
