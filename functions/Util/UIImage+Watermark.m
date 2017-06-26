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
    int w = self.size.width;
    int h = self.size.height;
    
    UIGraphicsBeginImageContext(self.size);
    [[UIColor redColor] set];
    [self drawInRect:CGRectMake(0, 0, w, h)];
    
    CGFloat fontSize = round(w/2/text.length);
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName,[UIColor redColor] ,NSForegroundColorAttributeName,nil];
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dic context:nil].size;
    
    [text drawInRect:CGRectMake(w-size.width - fontSize, h-size.height - fontSize, size.width,size.height) withAttributes:dic];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
}
@end
