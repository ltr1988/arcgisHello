//
//  MyChuanKuaYueProgressItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueProgressItem.h"
#import "AttachmentItem.h"
#import "UploadAttachmentModel.h"

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

-(UploadAttachmentModel *)attachment
{
    if (!_attachment) {
        _attachment = [[UploadAttachmentModel alloc] init];
    }
    return _attachment;
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
            item.isqxyj = NO;
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

-(NSString *)cellTitle
{
    return _content;
}
-(NSString *)cellDate
{
    return _btime;
}
-(NSString *)cellFinder
{
    return _creator;
}
-(NSString *)cellDepartment
{
    return _departName;
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
