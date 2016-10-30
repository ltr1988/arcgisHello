//
//  AttachmentItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "AttachmentItem.h"
#import "EventHttpManager.h"
#import "NSString+LVPath.h"

@implementation AttachmentItem
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"fid" :@"id",
             @"file_type" :@"file_type",
             @"url" :@"url",
             };
    
}


-(void) downloadWithCompletionBlock:(DownloadCallback) completeBlock
{
    if (_fid && _file_type && _url) {
        NSString *extension = [_url pathExtension];
        NSString *cachePath = [[NSString cachesPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",_fid,extension]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            if (completeBlock) {
                completeBlock(cachePath,_file_type);
            }
            return;
        }
        
        [[EventHttpManager sharedManager] requestDownloadAttachmentWithId:_fid qxyjFlag:self.isqxyj successCallback:^(NSURLSessionDataTask *task, id data) {
            
            NSData *recData = data;
            if (recData.length) {
                [recData writeToFile:cachePath atomically:YES];
                //save to file cachePath
                if (completeBlock) {
                    completeBlock(cachePath,_file_type);
                }
            }
            
        } failCallback:nil];
    }
}
@end
