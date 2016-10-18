//
//  MyDealedEventHistoryItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyDealedEventHistoryItem.h"

#import "AttachmentItem.h"
#import "UploadAttachmentModel.h"
@implementation MyDealedEventHistoryItem

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"detailId" :@"id",
             @"disposeComment" :@"disposeComment",
             @"addTime" :@"addTime",
             @"creatorName" :@"creator",
             @"fileList" :@"fileList",
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
    return _disposeComment;
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
    return @"";
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
