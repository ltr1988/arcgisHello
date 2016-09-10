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

-(void) itemCalled:(_Nonnull id) sender;

@end

/**
 可删除的ImageView
 
 - callback 响应事件
 */
@interface CheckableImageView : UIImageView

@property (nonatomic, weak, nullable) id <ItemCallBackDelegate> delegate;
-(void) setVideo:(BOOL) isVideo;

@property (nonatomic,assign) BOOL readonly;
@end
