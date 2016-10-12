//
//  MediaPathManager.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EventReportModel;
@interface EventModelManager : NSObject

+(void) addCacheForEventModel:(EventReportModel *)model;
+(void) removeCacheForEventModel:(EventReportModel *)model;
+(NSArray *) getEventModels;
+(EventReportModel *) lastestEventModel;
@end
