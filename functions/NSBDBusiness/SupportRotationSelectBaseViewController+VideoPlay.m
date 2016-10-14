//
//  SupportRotationSelectBaseViewController+VideoPlay.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController+VideoPlay.h"

@implementation SupportRotationSelectBaseViewController (VideoPlay)
-(void) play:(NSURL *)videoUrl
{
    if (videoUrl) {
        MPMoviePlayerViewController *_mvPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:videoUrl];
        [_mvPlayer.moviePlayer prepareToPlay];
        [self presentMoviePlayerViewControllerAnimated:_mvPlayer];
        [[NSNotificationCenter defaultCenter] addObserver:self
         
                                                 selector:@selector(movieFinishedCallback:)
         
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
         
                                                   object:_mvPlayer.moviePlayer];
    }
}

-(void)movieFinishedCallback:(NSNotification*)notify{
    
    // 视频播放完或者在presentMoviePlayerViewControllerAnimated下的Done按钮被点击响应的通知。
    
    MPMoviePlayerController* theMovie = [notify object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
     
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
     
                                                  object:theMovie];
    
    [self dismissMoviePlayerViewControllerAnimated];
    
}
@end
