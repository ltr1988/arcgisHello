//
//  CheckableImageView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/27.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefine.h"


@protocol ItemCallBackDelegate <NSObject>

-(void) itemChecked:(_Nonnull id) sender;
-(void) itemTapped:(_Nonnull id) sender;

@end

/**
 可删除的ImageView
 
 - callback 响应事件
 */
@interface CheckableImageView : UIImageView

@property (nonatomic, weak, nullable) id <ItemCallBackDelegate> delegate;

@property (nullable, nonatomic,strong) NSURL *contentURL;
@property (nonatomic,assign) BOOL isVideo;
@property (nonatomic,assign) BOOL readonly;
@end
