//
//  UIImage+Watermark.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/17.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "UIImage+Watermark.h"

@implementation UIImage (Watermark)

- (UIImage *) imageWithWaterMarkText:(NSString *)text
{
    //get image width and height
    
    int w = self.size.width;
    int h = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
    char* text1 = (char *)[text cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 0, 0, 1);
    CGContextShowTextAtPoint(context, w/2-strlen(text1)*5, h/2, text1, strlen(text1));
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}
@end
