//
//  EventReportViewController+pickMedia.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventReportViewController+pickMedia.h"

@implementation EventReportViewController (pickMedia)



-(void) play:(NSURL *)videoUrl
{
    if (videoUrl) {
        _mvPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:videoUrl];
        [self presentMoviePlayerViewControllerAnimated:_mvPlayer];
        [_mvPlayer.moviePlayer play];
    }
}



-(void) setupPickerManager
{
    @weakify(self);
    mPickerManager = [[MediaPickerManager alloc] initWithViewController:self ImagePickBlock:^(NSArray *imageList) {
        @strongify(self)
        [self.model.eventPic addObjectsFromArray:imageList];
        [self.mPicker setImages:self.model.eventPic];
        
        dispatch_main_async_safe(^{
            
            [self.mPicker relayout];
        });
        
    } VideoPickBlock:^(NSURL *videoURL) {
        
        self.model.eventVideo = videoURL;
        [self.mPicker setVideo:self.model.eventVideo];
        
        dispatch_main_async_safe(^{
            
            [self.mPicker relayout];
        });
    }];
}

-(void)openPicMenu
{
    //在这里呼出下方菜单按钮项
    mPickerManager.pickImage = YES;
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
    mPickerManager.pickImage = NO;
    //在这里呼出下方菜单按钮项
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
        [self.model.eventPic removeObjectAtIndex:index.intValue];
    }else
    {
        self.model.eventVideo = nil;
    }
}


@end
