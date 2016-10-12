//
//  MediaPathManager.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EventReportModel;
@interface EventModelPathManager : NSObject

+(void) addEventMode:(EventReportModel *)model;
+(void) removeEventMode:(EventReportModel *)model;
+(NSArray *) getEventModels;
+(EventReportModel *) lastestEventModel;
@end
