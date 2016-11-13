//
//  AttachmentModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "AttachmentModel.h"
#import "AttachmentItem.h"

@implementation AttachmentModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"datalist" :@"data.fileList",
             };
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[AttachmentItem class] forKey:@"datalist"];
    return dict;
}

@end
