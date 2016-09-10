//
//  MyUploadEventCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventReportModel;
@class EventDetailView;

@interface MyUploadedEventCell : UITableViewCell
{
    EventDetailView * eventDetailView;
    
    UILabel *lbReviewState;
}

-(void) setData:(EventReportModel *) data;
+(CGFloat) heightForCell;
@end
