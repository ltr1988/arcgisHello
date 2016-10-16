//
//  MyEventDetailProgressModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventDetailProgressModel.h"
#import "MyEventHistoryItem.h"

@implementation MyEventDetailProgressModel
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{@"datalist" :@"data",
             };
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[MyEventHistoryItem class] forKey:@"datalist"];
    return dict;
}
@end
