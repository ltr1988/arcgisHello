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
                        [self.attachment.images addObject:image];
                }];
            }else
            {
                [item downloadWithCompletionBlock:^(NSString *fileUrl, NSString *type) {
                    @strongify(self)
                    NSURL *url = [NSURL fileURLWithPath:fileUrl];
                    self.attachment.videoURL = url;
                }];
            }
        }
    }
    
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
