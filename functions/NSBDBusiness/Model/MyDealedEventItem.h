//
//  MyDealedEventItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDealedEventItemCell.h"

@interface MyDealedEventItem : NSObject<MyDealedEventItemCellModel>
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSString *departmentName;
@property (nonatomic,strong) NSString *executorName;
@property (nonatomic,strong) NSString *eid;
@property (nonatomic,strong) NSString *makeTime;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *title;
@end
