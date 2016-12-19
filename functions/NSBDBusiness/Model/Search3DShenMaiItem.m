//
//  Search3DShenMaiItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Search3DShenMaiItem.h"
#import "CommonDefine.h"

@implementation Search3DShenMaiItem
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"duanmian" :@"duanmian",
             @"milesum":@"milesum",
             @"depth":@"depth",
             };
    
}

-(NSString *)imageUrl
{
    if (_duanmian) {
//        NSString *url =  [NSString stringWithFormat:@"http://%@:87/images/duanmian/%@.jpg",HOSTIP_3D,_duanmian];
        
        NSString *url = [NSString stringWithFormat:@"http://%@:85/images/duanmian/%@.jpg",HOSTIP_3D,_duanmian];
        return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return nil;
}
@end
