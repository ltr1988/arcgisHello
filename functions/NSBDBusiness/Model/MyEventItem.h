//
//  MyEventItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyEventItemCell.h"

@interface MyEventItem : NSObject<MyEventItemCellModel>
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
@property (nonatomic,strong) NSString *addTime;
@end
