//
//  MyDealedEventDetailItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyDealedEventDetailItem.h"
#import "AttachmentItem.h"
#import "UploadAttachmentModel.h"

@implementation MyDealedEventDetailItem
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"eid":@"id",
             @"title" :@"title",
             @"creator" :@"creator",
             @"departmentName" :@"departmentName",
             @"executorName" :@"executorName",
             @"alarmPersonContacts" :@"alarmPersonContacts",
             @"makeTime" :@"makeTime",
             @"name" :@"name",
             @"status" :@"status",
             @"content":@"content",
             @"fileList":@"fileList",
             };
    
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

+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[AttachmentItem class] forKey:@"fileList"];
    return dict;
}
@end
