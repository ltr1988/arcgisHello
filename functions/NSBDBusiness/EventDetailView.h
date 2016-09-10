//
//  EventDetailView.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EventDetailViewDelegate <NSObject>

@required

-(NSString *) eventDetailViewTitle;
-(NSString *) eventDetailViewDate;
-(NSString *) eventDetailViewPlace;
-(NSString *) eventDetailViewFinder;
@end


@interface EventDetailView : UIView
+(CGFloat) heightForView;
-(void) setViewData:(id<EventDetailViewDelegate>) data;
@end
