//
//  MediaPathManager.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModelPathManager : NSObject

+(void) addEventModelWithPath:(NSString *)path;
+(NSArray *) getEventModels;
+(NSString *) lastestEventPath;
@end
