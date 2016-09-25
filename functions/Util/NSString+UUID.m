//
//  NSString+UUID.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/24.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSString+UUID.h"

@implementation NSString (UUID)
+ (NSString *)stringWithUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    return uuidString;
}
@end
