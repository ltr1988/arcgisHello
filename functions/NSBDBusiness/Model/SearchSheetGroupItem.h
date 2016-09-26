//
//  SearchSheetGroupItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchSheetInfoItem.h"

@interface SearchSheetGroupItem : NSObject
@property (nonatomic,strong) NSArray *items; //list of SearchSheetInfoItem
@property (nonatomic,copy) NSString *groupName;


-(instancetype) initWithDict:(NSDictionary *)dict;
@end
