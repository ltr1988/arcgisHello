//
//  EventMediaCollectionView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckableImageView.h"
#import "CommonDefine.h"

@interface EventMediaCollectionView : UIView<ItemCallBackDelegate>
{
    NSMutableArray *picArray; //image content
    NSMutableArray *videoArray; //string content
    CGFloat _height;
}

@property (nonatomic,copy) ActionCallback callBack;
-(CGFloat) height;

-(void) setPics:(NSArray *)imageList;
-(void) setVideo:(NSString *)videoPath;

@end
