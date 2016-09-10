//
//  EventReportModel.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckableTitleItem.h"
#import "TitleDetailItem.h"
#import "TitleDateItem.h"
#import "TitleItem.h"

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
@property (nonatomic,strong) TitleDetailItem *eventStatus;
@property (nonatomic,strong) TitleDetailItem *eventPreprocess;

@property (nonatomic,strong) NSMutableArray  *eventPic;
@property (nonatomic,strong) NSURL *eventVideo;
@property (nonatomic,assign) NSInteger reviewState; //0 未审核 1 通过 2 未通过
@end
