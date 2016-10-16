//
//  EventReportViewController+pickMedia.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventReportViewController+pickMedia.h"
#import "UploadAttachmentModel.h"

@implementation EventReportViewController (pickMedia)

-(void) setupPickerManager
{
    @weakify(self);
    mPickerManager = [[MediaPickerManager alloc] initWithViewController:self ImagePickBlock:^(NSArray *imageList) {
        @strongify(self)
        [self.model.attachmentModel.images addObjectsFromArray:imageList];
        [self.mPicker setImages:self.model.attachmentModel.images];
        
        dispatch_main_async_safe(^{
            
            [self.mPicker relayout];
        });
        
    } VideoPickBlock:^(NSURL *videoURL) {
        
        self.model.attachmentModel.videoURL = videoURL;
        [self.mPicker setVideo:self.model.attachmentModel.videoURL];
        
        dispatch_main_async_safe(^{
            
            [self.mPicker relayout];
        });
    }];
}


-(void)openPicMenu
{
    mPickerManager.pickImage = YES;
    //在这里呼出下方菜单按钮项
    [mPickerManager openMenuInView:self.view];
    
}

-(void)openVideoMenu
{
    //在这里呼出下方菜单按钮项
    mPickerManager.pickImage = NO;
    [mPickerManager openMenuInView:self.view];
    
}

-(void) mediaRemove:(NSNotification *)noti
{
    BOOL isImage = [noti.userInfo[@"itemType"] isEqualToString:@"image"];
    NSNumber *index = noti.userInfo[@"index"];
    if (isImage) {
        [self.model.attachmentModel.images removeObjectAtIndex:index.intValue];
    }else
    {
        self.model.attachmentModel.videoURL = nil;
    }
}


@end
