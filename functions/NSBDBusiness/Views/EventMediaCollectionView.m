//
//  EventMediaCollectionView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventMediaCollectionView.h"

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

-(void) setImages:(NSArray *)imageList
{
    picArray = [imageList mutableCopy];
}

-(void) setVideo:(NSString *)videoPath
{
    videoArray = [NSMutableArray arrayWithObject:videoPath];
}

-(void) removeImageAtIndex:(NSInteger) index
{
    
}
-(void) removeVideoAtIndex:(NSInteger) index
{
    
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    [self relayout];
}

-(void) relayout
{
    [self clean];
    int row=0,column=0;
    float space = (self.frame.size.width - 4*70)/5.f;
    for (UIImage *img in picArray) {
        CheckableImageView * view = [[CheckableImageView alloc] initWithFrame:CGRectMake(10 +(80)*row , space+(70+space)*(column%4), 70, 70)];
        [view setImage:img];
        [self addSubview:view];
        
        column = (1+ column)%4;
        if (column == 0) {
            row++;
        }
        
        
    }
    
    //set video
    
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
    
}


@end
