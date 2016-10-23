//
//  AttachmentItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DownloadCallback)(NSString *fileUrl,NSString* type);

@interface AttachmentItem : NSObject
@property (nonatomic,strong) NSString* fid;
@property (nonatomic,strong) NSString* file_type;
@property (nonatomic,strong) NSString* url;

-(void) downloadWithCompletionBlock:(DownloadCallback) completeBlock;
@end
