//
//  Search3DResultCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Search3DResultViewModel <NSObject>
@required
-(NSString *) title;
-(NSString *) mane;

@end


@interface Search3DResultCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *maneLabel;

-(void) setDataModel:(id<Search3DResultViewModel>) model;
+(CGFloat) heightForCell;
@end
