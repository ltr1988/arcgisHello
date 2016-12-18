//
//  ImageContentViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ImageContentViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ImageContentViewController()<UIScrollViewDelegate>
{
    UIImageView *imgView;
    UIScrollView *scrollView;
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.maximumZoomScale = 2.0;
    scrollView.minimumZoomScale = 0.5;
    
    imgView = [[UIImageView alloc] init];
    [self.view addSubview:imgView];
}

-(void) setImage:(UIImage *) image
{
    [imgView setImage:image];
    imgView.frame = scrollView.bounds;
    imgView.contentMode = UIViewContentModeScaleAspectFit;

    scrollView.contentSize = scrollView.bounds.size;
}

#pragma mark - scroll delegate
-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgView;
}
@end
