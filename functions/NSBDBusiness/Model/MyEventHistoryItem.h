//
//  MyEventHistoryItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/7.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEventHistoryItem : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *finder;
@property (nonatomic,strong) NSString *place;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSString *video;
@end
