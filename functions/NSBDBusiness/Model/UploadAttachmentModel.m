//
//  UploadAttachmentModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "UploadAttachmentModel.h"

@implementation UploadAttachmentModel

-(instancetype) init
{
    self = [super init];
    if (self) {
        _images = [NSMutableArray arrayWithCapacity:6];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_images forKey:@"images"];
    [aCoder encodeObject:_videoURL forKey:@"videoURL"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        _images = [aDecoder decodeObjectForKey:@"images"];
        _videoURL = [aDecoder decodeObjectForKey:@"videoURL"];
    }
    
    return self;
}


-(BOOL) hasData
{
    if (_images && _images.count>0) {
        return YES;
    }
    if (_videoURL != nil) {
        return YES;
    }
    return NO;
}
@end
