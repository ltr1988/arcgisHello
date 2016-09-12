//
//  ImageContentViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ImageContentViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ImageContentViewController()
{
    UIImageView *imgView;
}
@end

@implementation ImageContentViewController
-(instancetype) init{
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}


-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor blackColor];
    
    imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
}

-(void) setImage:(UIImage *) image
{
    [imgView setImage:image];
}

-(void) setImageURL:(NSURL *) url
{
    [imgView setImageWithURL:url];
}
@end
