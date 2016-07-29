//
//  EventMediaCollectionView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckableImageView.h"


@interface EventMediaCollectionView : UIView<ItemCallBackDelegate>
{
    NSMutableArray *picArray; //image content
    NSMutableArray *videoArray; //string content
}
-(void) setImages:(NSArray *)imageList;
-(void) setVideo:(NSString *)videoPath;

@end
