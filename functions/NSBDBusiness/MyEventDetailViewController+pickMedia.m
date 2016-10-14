//
//  MyEventDetailViewController+pickMedia.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/6.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventDetailViewController+pickMedia.h"
#import "FeedbackModel.h"

@implementation MyEventDetailViewController (pickMedia)

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

-(void) setupPickerManager
{
    @weakify(self);
    mPickerManager = [[MediaPickerManager alloc] initWithViewController:self ImagePickBlock:^(NSArray *imageList) {
        @strongify(self)
        [self.feedbackModel.images addObjectsFromArray:imageList];
        [self.mPicker setImages:self.feedbackModel.images];
        
        dispatch_main_async_safe(^{
            
            [self.mPicker relayout];
        });
        
    } VideoPickBlock:^(NSURL *videoURL) {
        self.feedbackModel.video = videoURL;
        [self.mPicker setVideo:self.feedbackModel.video];
        
        dispatch_main_async_safe(^{
            
            [self.mPicker relayout];
        });
    }];
}


-(void)openPicMenu
{
    mPickerManager.pickImage = YES;
    //在这里呼出下方菜单按钮项
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        
        myActionSheetPic = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:mPickerManager
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    }else
    {
        myActionSheetPic = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:mPickerManager
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles: @"从手机相册获取",nil];
    }
    
    [myActionSheetPic showInView:self.view];
    
}

-(void)openVideoMenu
{
    //在这里呼出下方菜单按钮项
    mPickerManager.pickImage = NO;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
    
        myActionSheetVideo = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:mPickerManager
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    }else
    {
        myActionSheetVideo = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:mPickerManager
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles: @"从手机相册获取",nil];
    }
    
    [myActionSheetVideo showInView:self.view];
    
}

-(void) mediaRemove:(NSNotification *)noti
{
    BOOL isImage = [noti.userInfo[@"itemType"] isEqualToString:@"image"];
    NSNumber *index = noti.userInfo[@"index"];
    if (isImage) {
        [self.feedbackModel.images removeObjectAtIndex:index.intValue];
    }else
    {
        self.feedbackModel.video = nil;
    }
}
@end
