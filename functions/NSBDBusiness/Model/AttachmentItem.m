//
//  AttachmentItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "AttachmentItem.h"

@implementation AttachmentItem
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"fid" :@"id",
             @"file_type" :@"file_type",
             @"url" :@"url",
             };
    
}
@end
