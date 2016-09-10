//
//  MyUploadEventCell.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyUploadedEventCell.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "UIColor+ThemeColor.h"
#import "EventDetailView.h"
#import "EventReportModel.h"

@implementation MyUploadedEventCell
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

-(void) setupSubViews
{
    __weak UIView *weakView = self.contentView;
    CGFloat smallSize = 14;
    
    eventDetailView = [[EventDetailView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, [EventDetailView heightForView])];
    eventDetailView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [weakView addSubview:eventDetailView];
    
    lbReviewState = [UILabel new];
    lbReviewState.font = UI_FONT(smallSize);
    lbReviewState.textColor = [UIColor blackColor];
    lbReviewState.backgroundColor = [UIColor clearColor];
    lbReviewState.textAlignment = NSTextAlignmentRight;
    [weakView addSubview:lbReviewState];
    
    CGFloat padding = 8;
    
    [lbReviewState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(eventDetailView.mas_bottom).offset(padding);
        make.height.mas_equalTo(smallSize);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
    
    [lbReviewState sizeToFit];
}


-(void) setData:(EventReportModel *) data
{
    [eventDetailView setViewData:(id<EventDetailViewDelegate>)data];
    switch (data.reviewState) {
        case 0:
            lbReviewState.text = @"未审核";
            lbReviewState.textColor = [UIColor orangeColor];
            break;
        case 1:
            lbReviewState.text = @"通过";
            lbReviewState.textColor = [UIColor greenColor];
            break;
        case 2:
            lbReviewState.text = @"未通过";
            lbReviewState.textColor = [UIColor redColor];
            break;
    }
    [lbReviewState sizeToFit];
}

+(CGFloat) heightForCell
{
    CGFloat smallSize = 14,padding = 8;
    CGFloat height = [EventDetailView heightForView] + padding*2 +smallSize;
    return height;
}

@end
