//
//  MyEventHistoryItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/7.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventHistoryItem.h"
#import "AttachmentItem.h"
#import "UploadAttachmentModel.h"

@implementation MyEventHistoryItem

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"detailId" :@"id",
             @"disposeDescription" :@"disposeDescription",
             @"addTime" :@"addTime",
             @"creatorName" :@"creatorName",
             @"fileList" :@"fileList",
             @"disposeBy" :@"disposeBy",
             };
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[AttachmentItem class] forKey:@"fileList"];
    return dict;
}


-(instancetype)init
{
    if (self = [super init]) {
        _attachment = [[UploadAttachmentModel alloc] init];
    }
    return self;
}

-(NSString *)title
{
    return _disposeDescription;
}
-(NSString *)date
{
    return _addTime;
}
-(NSString *)finder
{
    return _creatorName;
}
-(NSString *)place
{
    return _disposeBy;
}

-(NSArray *)images
{
    return _attachment.images;
}

-(NSString *)video
{
    return [_attachment.videoURL path];
}
@end
