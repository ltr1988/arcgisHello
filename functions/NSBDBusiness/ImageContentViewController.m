//
//  ImageContentViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ImageContentViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Masonry.h"

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
    scrollView.contentSize = self.view.frame.size;
    scrollView.maximumZoomScale = 2.0;
    scrollView.minimumZoomScale = 0.5;
    
    imgView = [[UIImageView alloc] init];
    [scrollView addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

-(void) setImage:(UIImage *) image
{
    [imgView setImage:image];
    imgView.frame = CGRectMake(0, 0, image.size.width, image.size.height);

}

#pragma mark - scroll delegate
-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgView;
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)ascrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the
    // imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible,
    // the size of the rect grows.
    zoomRect.size.height = ascrollView.frame.size.height / scale;
    zoomRect.size.width  = ascrollView.frame.size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}
@end
