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

-(void) setFileList:(NSArray *)fileList
{
    _fileList = fileList;
    if (fileList && fileList.count>0) {
        if (!_attachment) {
            _attachment = [[UploadAttachmentModel alloc] init];
        }
        @weakify(self)
        for (AttachmentItem *item in fileList) {
            item.isqxyj = YES;
            if ([item.file_type isEqualToString:@"image"]) {
                
                [item downloadWithCompletionBlock:^(NSString *fileUrl, NSString *type) {
                    @strongify(self)
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:fileUrl]];
                    if (nil != image)
                    {
                        [self.attachment.images addObject:image];
                        [self postDownloadCompleteNotification];
                    }
                }];
            }else
            {
                [item downloadWithCompletionBlock:^(NSString *fileUrl, NSString *type) {
                    @strongify(self)
                    NSURL *url = [NSURL fileURLWithPath:fileUrl];
                    self.attachment.videoURL = url;
                    [self postDownloadCompleteNotification];
                }];
            }
        }
    }
    
}

-(void) postDownloadCompleteNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"attachmentComplete" object:nil];
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


