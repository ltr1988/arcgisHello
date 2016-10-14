//
//  SearchDetailSheetViewController+pickMedia.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchDetailSheetViewController+pickMedia.h"

#import "EventMediaPickerView.h"

@implementation SearchDetailSheetViewController (pickMedia)
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

-(void)openMenu
{
    UIActionSheet *myActionSheet;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        
        myActionSheet = [[UIActionSheet alloc]
                         initWithTitle:nil
                         delegate:mPickerManager
                         cancelButtonTitle:@"取消"
                         destructiveButtonTitle:nil
                         otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    }else
    {
        myActionSheet = [[UIActionSheet alloc]
                         initWithTitle:nil
                         delegate:mPickerManager
                         cancelButtonTitle:@"取消"
                         destructiveButtonTitle:nil
                         otherButtonTitles: @"从手机相册获取",nil];
    }
    
    [myActionSheet showInView:self.view];
}

-(void)openPicMenu
{
    mPickerManager.pickImage = YES;
    //在这里呼出下方菜单按钮项
    [self openMenu];
    
}

-(void)openVideoMenu
{
    //在这里呼出下方菜单按钮项
    mPickerManager.pickImage = NO;
    [self openMenu];
    
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
