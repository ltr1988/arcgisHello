//
//  EventMediaCollectionView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventMediaCollectionView : UIView
{
    NSMutableArray *picArray;
    NSMutableArray *videoArray;
}
-(void) setImages:(NSArray *)imageList;
-(void) setVideo:(NSString *)videoPath;

@end
