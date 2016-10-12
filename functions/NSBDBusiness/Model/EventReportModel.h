//
//  EventReportModel.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CheckableTitleItem;
@class TitleDetailItem;
@class TitleDateItem;
@class TitleItem;
@class TitleDetailTextItem;
@class CommitedEventHistoryItem;

@interface EventReportModel : NSObject<NSCoding>
@property (nonatomic,strong) TitleDetailItem *eventName;
@property (nonatomic,strong) TitleDetailItem *eventType;
@property (nonatomic,strong) TitleDetailItem *eventXingzhi;
@property (nonatomic,strong) TitleDateItem *eventDate;
@property (nonatomic,strong) TitleDetailItem *level;
@property (nonatomic,strong) TitleDetailItem *reason;
@property (nonatomic,strong) TitleDetailItem *place;
@property (nonatomic,strong) TitleDetailItem *department;
@property (nonatomic,strong) TitleDetailItem *reporter;
@property (nonatomic,assign) CGPoint location;
@property (nonatomic,strong) TitleDetailTextItem *eventStatus;
@property (nonatomic,strong) TitleDetailTextItem *eventPreprocess;

@property (nonatomic,strong) NSMutableArray  *eventPic; //uiimages
@property (nonatomic,strong) NSURL *eventVideo;
@property (nonatomic,assign) NSInteger reviewState; //0 未审核 1 通过 2 未通过

@property (nonatomic,strong) NSString *uuid;

-(instancetype) initWithMyEventHistoryItem:(CommitedEventHistoryItem *)item;
@end
