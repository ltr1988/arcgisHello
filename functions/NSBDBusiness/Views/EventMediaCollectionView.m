//
//  EventMediaCollectionView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventMediaCollectionView.h"
#import "UIImage+VideoThumb.h"
#import "UIImageView+AFNetworking.h"
#import "ImageContentViewController.h"
#import "UIView+ViewController.h"
#import "VideoPlayViewController.h"

@implementation EventMediaCollectionView

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        picArray = [NSMutableArray array];
        videoArray = [NSMutableArray array];
        _readonly = NO;
    }
    return self;
}

-(void) setReadonly:(BOOL)readonly
{
    _readonly = readonly;
    [self relayout];
}

-(void) setPics:(NSArray *)imageList
{
    picArray = [imageList mutableCopy];
    [self relayout];
}

-(void) setVideo:(NSURL *)videoPath
{
    videoArray = [NSMutableArray arrayWithObject:videoPath];
    [self relayout];
}

-(void) removeImageAtIndex:(NSInteger) index
{
    NSDictionary *userInfo = @{@"itemType":@"image",@"index":@(index)};
    [[NSNotificationCenter defaultCenter] postNotificationName:ItemRemovedNotification object:nil userInfo:userInfo];
    [picArray removeObjectAtIndex:index];
    [self relayout];
}

-(void) removeVideoAtIndex:(NSInteger) index
{
    NSDictionary *userInfo = @{@"itemType":@"video",@"index":@(index)};
    [[NSNotificationCenter defaultCenter] postNotificationName:ItemRemovedNotification object:nil userInfo:userInfo];
    [videoArray removeAllObjects];
    [self relayout];
}

-(void) relayout
{
    [self clean];
    int row=0,column=0;
    float space = (self.frame.size.width - 4*70)/5.f;
    
    int tag = 1000;
    //set image
    for (id obj in picArray) {
        
        
        CheckableImageView * view = [[CheckableImageView alloc] initWithFrame:CGRectMake(space+(70+space)*(column%4),10 +(80)*row ,  70, 70)];
        view.readonly = _readonly;
        
        if ([obj isKindOfClass:[UIImage class]]) {
            UIImage *img =obj;
            [view setImage:img];
        }else if([obj isKindOfClass:[NSString class]])
        {
            NSURL *url = [NSURL URLWithString:obj];
            [view setImageWithURL:url];
            view.contentURL = url;
        }else if([obj isKindOfClass:[NSURL class]])
        {
            NSURL *url = obj;
            [view setImageWithURL:url];
            view.contentURL = url;
        }
        view.delegate = self;
        view.tag = tag++;
        [self addSubview:view];
        
        column = (1+ column)%4;
        if (column == 0) {
            row++;
        }
    }
    
    //set video
    for (NSURL *videoStr in videoArray)
    {
        UIImage *img = [UIImage getThumbImageWithVideoURL:videoStr];
        if (img) {
            CheckableImageView * view = [[CheckableImageView alloc] initWithFrame:CGRectMake( space+(70+space)*(column%4),10 +(80)*row , 70, 70)];
            [view setImage:img];
            view.tag = tag++;
            [view setContentURL:videoStr];
            [view setIsVideo:YES];
            view.delegate = self;
            [self addSubview:view];
        }
    }
    
    
    if (picArray.count == 0 && videoArray.count ==0) {
        _height = 0;
    }else
        _height = 10 +(80)*(row+1);
    self.bounds = CGRectMake(0, 0, kScreenWidth, _height);
}

- (void)clean
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

-(void) itemTapped:(id)sender
{
    CheckableImageView *view = (CheckableImageView *)sender;
    if (view.isVideo) {
        VideoPlayViewController *vc = [[VideoPlayViewController alloc] initWithURL:view.contentURL];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }else
    {
        ImageContentViewController *vc = [ImageContentViewController new];
        [vc setImage:view.image];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
}

-(void) itemChecked:(id)sender
{
    CheckableImageView *view = (CheckableImageView *)sender;
    NSInteger index = view.tag - 1000;
    if (index>=picArray.count) {
        [self removeVideoAtIndex:index - picArray.count];
    }else
        [self removeImageAtIndex:index];
    if (_callBack) {
        _callBack();
    }
}

-(CGFloat) height
{
    return _height;
}

+(CGFloat) heightForItemCount:(NSInteger) count
{
    if (count==0) {
        return 0;
    }
    NSInteger row = count/4;
    return 10 +(80)*(row+1);
}
@end
