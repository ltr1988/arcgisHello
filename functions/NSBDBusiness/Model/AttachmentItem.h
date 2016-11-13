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
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* label;
@property (nonatomic,assign) BOOL isqxyj; //是否是抢险应急附件

-(instancetype) initWithArray:(NSArray *)metaList isQxyj:(BOOL) isQxyj;
-(void) downloadWithCompletionBlock:(DownloadCallback) completeBlock;
@end
