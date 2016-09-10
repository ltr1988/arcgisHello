//
//  MyLocalEventCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventReportModel;
@class EventDetailView;

@interface MyLocalEventCell : UITableViewCell
{
    EventDetailView * eventDetailView;
    
    UIButton *btnDelete;
    UIButton *btnReport;
}

-(void) setData:(EventReportModel *) data;
+(CGFloat) heightForCell;
@end
