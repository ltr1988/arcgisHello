//
//  MyLocalEventCell.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefine.h"
@class EventReportModel;
@class EventDetailView;

typedef void (^EventCellCallback)(EventReportModel *model);

@interface MyLocalEventCell : UITableViewCell
{
    EventDetailView * eventDetailView;
    
    UIButton *btnDelete;
    UIButton *btnReport;
}

@property (nonatomic,strong) EventReportModel *data;
@property (nonatomic,copy) EventCellCallback deleteCallback;
@property (nonatomic,copy) EventCellCallback reportCallback;
+(CGFloat) heightForCell;
@end
