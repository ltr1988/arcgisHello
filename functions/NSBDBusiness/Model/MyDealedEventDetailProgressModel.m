//
//  MyDealedEventDetailProgressModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyDealedEventDetailProgressModel.h"

#import "MyDealedEventHistoryItem.h"


@implementation MyDealedEventDetailProgressModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"datalist" :@"data",
             };
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[MyDealedEventHistoryItem class] forKey:@"datalist"];
    return dict;
}
@end
