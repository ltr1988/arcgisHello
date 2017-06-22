//
//  NSDateFormatterHelper.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/17.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatterHelper : NSObject
+(instancetype) sharedInstance;
-(NSDateFormatter *) formatterWithFormat:(NSString *)format;
@end
