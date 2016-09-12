//
//  VideoPlayController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "VideoPlayViewController.h"

@interface VideoPlayViewController()
{
    MPMoviePlayerViewController *_mvPlayer;
    NSURL *videoUrl;
}
@end

@implementation VideoPlayViewController
-(instancetype) initWithURL:(NSURL *)url
{
    if (self = [super init]) {
        videoUrl = url;
    }
    return self;
}
-(void) viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, 100, 30)];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"play" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    //NSURL *videoUrl = [NSURL URLWithString:@"http://7xawdc.com2.z0.glb.qiniucdn.com/o_19p6vdmi9148s16fs1ptehbm1vd59.mp4"];
    if (videoUrl) {
        
        _mvPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:videoUrl];
    }
    
}


-(void) play
{
    if (videoUrl) {
        [self presentMoviePlayerViewControllerAnimated:_mvPlayer];
        [_mvPlayer.moviePlayer play];
    }
}

@end
