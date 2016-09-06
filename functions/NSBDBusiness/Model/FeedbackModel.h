//
//  FeedbackModel.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/6.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TitleDetailItem;
@class TitleDetailTextItem;

@interface FeedbackModel : NSObject<NSCoding>
@property (nonatomic,strong) TitleDetailItem *date;
@property (nonatomic,strong) TitleDetailTextItem* detail;

@property (nonatomic,strong) NSMutableArray  *images;
@property (nonatomic,strong) NSURL *video;
@end
