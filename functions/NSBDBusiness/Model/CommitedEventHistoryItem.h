//
//  CommitedEventHistoryItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CommitedEventHistoryItem : NSObject
@property (nonatomic,strong) NSString *eid;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *category;
@property (nonatomic,strong) NSString *responseLevel;
@property (nonatomic,strong) NSString *alarmPerson;

@property (nonatomic,strong) NSString *alarmPersonContacts;
@property (nonatomic,strong) NSString *occurLocation;
@property (nonatomic,strong) NSString *spacePosition_x;
@property (nonatomic,strong) NSString *spacePosition_y;

@property (nonatomic,strong) NSString *departName;
@property (nonatomic,strong) NSString *creatorName;
@property (nonatomic,strong) NSString *status;
@end
