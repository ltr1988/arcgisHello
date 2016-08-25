//
//  RouteSearchHistoryItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RouteSearchResultItem : NSObject<NSCoding>
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) CGPoint location;
@end
