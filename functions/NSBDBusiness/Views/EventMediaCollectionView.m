//
//  EventMediaCollectionView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventMediaCollectionView.h"
#import "CheckableImageView.h"

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
    
}

-(void) setVideo:(NSString *)videoPath
{
    
}

-(void) removeImageAtIndex:(NSInteger) index
{
    
}
-(void) removeVideoAtIndex:(NSInteger) index
{
    
}
@end
