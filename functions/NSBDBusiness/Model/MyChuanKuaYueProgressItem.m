//
//  MyChuanKuaYueProgressItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueProgressItem.h"
#import "AttachmentItem.h"

@implementation MyChuanKuaYueProgressItem
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{
             @"content":@"CONTENT",
             @"departName" :@"DEPARTNAME",
             @"btime" :@"BTIME",
             @"creator" :@"CREATOR",
             @"fileList":@"FILELIST",
             };
    
}

+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[AttachmentItem class] forKey:@"fileList"];
    return dict;
}
@end
