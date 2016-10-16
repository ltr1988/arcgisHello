//
//  SearchDetailSheetViewController+pickMedia.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchDetailSheetViewController+pickMedia.h"
#import "UploadAttachmentModel.h"
#import "NSBDBaseUIItem.h"
#import "EventMediaPickerView.h"

@implementation SearchDetailSheetViewController (pickMedia)
-(void) setupPickerManager
{
    @weakify(self);
    mPickerManager = [[MediaPickerManager alloc] initWithViewController:self ImagePickBlock:^(NSArray *imageList) {
        @strongify(self)
        [self.uiItem.attachModel.images addObjectsFromArray:imageList];
        [self.mPicker setImages:self.uiItem.attachModel.images];
        
        dispatch_main_async_safe(^{
            
            [self.mPicker relayout];
        });
        
    } VideoPickBlock:^(NSURL *videoURL) {
        
        self.uiItem.attachModel.videoURL = videoURL;
        [self.mPicker setVideo:self.uiItem.attachModel.videoURL];
        
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
        [self.uiItem.attachModel.images removeObjectAtIndex:index.intValue];
    }else
    {
        self.uiItem.attachModel.videoURL = nil;
    }
}

@end
