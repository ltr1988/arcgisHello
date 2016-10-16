//
//  UploadAttachmentModel.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadAttachmentModel : NSObject<NSCoding>
@property (nonatomic,strong) NSMutableArray *images;

@property (nonatomic,strong) NSURL *videoURL;

-(BOOL) hasData;
@end
