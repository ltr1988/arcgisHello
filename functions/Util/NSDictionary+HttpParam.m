//
//  NSDictionary+HttpParam.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/24.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSDictionary+HttpParam.h"

@implementation NSDictionary (HttpParam)
-(NSString *) httpParamString
{
    if (self.count == 0) {
        return @"";
    }
    NSMutableString *paramStr = [NSMutableString stringWithString: @"?"];
    for (NSString *key in self.allKeys) {
        [paramStr appendString:[NSString stringWithFormat:@"%@=%@&",key,self[key]]];
    }
    [paramStr deleteCharactersInRange:NSMakeRange(paramStr.length-1, 1)];
    
    return [paramStr copy];
}

@end
