//
//  MyEventDetailViewController+pickMedia.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/6.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventDetailViewController+pickMedia.h"
#import "FeedbackModel.h"

#import "EventMediaPickerView.h"

@implementation MyEventDetailViewController (pickMedia)

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
        [self.feedbackModel.images removeObjectAtIndex:index.intValue];
    }else
    {
        self.feedbackModel.video = nil;
    }
}
@end
