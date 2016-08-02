//
//  UIImage+VideoThumb.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/29.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "UIImage+VideoThumb.h"

#import "AVFoundation/AVFoundation.h"

@implementation UIImage (VideoThumb)

+(UIImage *)getThumbImageWithVideoURL:(NSURL *)url
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
    
}


@end
