//
//  VideoPlayController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "VideoPlayViewController.h"
#import "MapViewManager.h"

@interface VideoPlayViewController()
{
    MPMoviePlayerViewController *_mvPlayer;
}
@property (weak, nonatomic) AGSMapView *mapView;
@end

@implementation VideoPlayViewController

-(void) viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, 100, 30)];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"play" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    NSURL *videoUrl = [NSURL URLWithString:@"http://7xawdc.com2.z0.glb.qiniucdn.com/o_19p6vdmi9148s16fs1ptehbm1vd59.mp4"];
    _mvPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:videoUrl];
    
    [self test];
}


-(void) play
{
    [self presentMoviePlayerViewControllerAnimated:_mvPlayer];
    [_mvPlayer.moviePlayer play];
}


-(void)test
{
    self.mapView = [MapViewManager sharedMapView];
    self.mapView.frame = self.view.bounds;
    [self.view addSubview:self.mapView];
}
@end
