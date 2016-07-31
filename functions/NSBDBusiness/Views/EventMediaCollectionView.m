//
//  EventMediaCollectionView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventMediaCollectionView.h"
#import "UIImage+VideoThumb.h"

@implementation EventMediaCollectionView

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        picArray = [NSMutableArray array];
        videoArray = [NSMutableArray array];
    }
    return self;
}

-(void) setPics:(NSArray *)imageList
{
    picArray = [imageList mutableCopy];
    [self relayout];
}

-(void) setVideo:(NSString *)videoPath
{
    videoArray = [NSMutableArray arrayWithObject:videoPath];
    [self relayout];
}

-(void) removeImageAtIndex:(NSInteger) index
{
    [picArray removeObjectAtIndex:index];
    [self relayout];
}

-(void) removeVideoAtIndex:(NSInteger) index
{
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
    for (UIImage *img in picArray) {
        CheckableImageView * view = [[CheckableImageView alloc] initWithFrame:CGRectMake(space+(70+space)*(column%4),10 +(80)*row ,  70, 70)];
        [view setImage:img];
        view.delegate = self;
        view.tag = tag++;
        [self addSubview:view];
        
        column = (1+ column)%4;
        if (column == 0) {
            row++;
        }
    }
    
    //set video
    for (NSString *videoStr in videoArray)
    {
        UIImage *img = [UIImage getThumbImageWithVideoURL:videoStr];
        if (img) {
            CheckableImageView * view = [[CheckableImageView alloc] initWithFrame:CGRectMake( space+(70+space)*(column%4),10 +(80)*row , 70, 70)];
            [view setImage:img];
            view.tag = tag++;
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

-(void) itemCalled:(id)sender
{
    CheckableImageView *view = (CheckableImageView *)sender;
    [self removeImageAtIndex:view.tag - 1000];
    if (_callBack) {
        _callBack();
    }
}

-(CGFloat) height
{
    return _height;
}
@end
