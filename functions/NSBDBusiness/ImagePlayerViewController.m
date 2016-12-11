//
//  ImagePlayerViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ImagePlayerViewController.h"

@interface ImagePlayerViewController ()

@property (nonatomic,strong) NSArray *imageList; //UIImage
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation ImagePlayerViewController

-(void) removeSubviews
{
    for (UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
}

-(void) setImageList:(NSArray *)imageList
{
    _imageList = imageList;
    [self removeSubviews];
    NSUInteger offset = 0;
    _scrollView.contentSize = CGSizeMake(imageList.count * _scrollView.bounds.size.width ,_scrollView.bounds.size.height);
    for (UIImage *img in imageList) {
        CGRect frame = _scrollView.bounds;
        frame.origin.x = offset * _scrollView.frame.size.width;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = img;
        [_scrollView addSubview:imgView];
        offset++;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = self.view.frame.size;
    [self.view addSubview:_scrollView];
    
    
}


@end
