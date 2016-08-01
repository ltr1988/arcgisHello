//
//  EventReportViewController+pickMedia.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventReportViewController+pickMedia.h"

@implementation EventReportViewController (pickMedia)


-(void)openPicMenu
{
    //在这里呼出下方菜单按钮项
    myActionSheetPic = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheetPic showInView:self.view];
    
}

-(void)openVideoMenu
{
    //在这里呼出下方菜单按钮项
    myActionSheetVideo = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheetVideo showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL pickImage = (actionSheet == myActionSheetPic);
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto:pickImage];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto:pickImage];
            break;
    }

    
    
    
}

//开始拍照
-(void)takePhoto:(BOOL) isImage
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    picker.allowsEditing = NO;
    
    
    
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;//设置image picker的来源，这里设置为摄像头
    picker.cameraDevice=UIImagePickerControllerCameraDeviceRear;//设置使用哪个摄像头，这里设置为后置摄像头
    
    if (!isImage) {
        picker.mediaTypes=@[(NSString *)kUTTypeMovie];
        picker.videoQuality=UIImagePickerControllerQualityTypeMedium;
        picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;//设置摄像头模式（拍照，录制视频）
        
    }else{
        picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
    }

    [self presentViewController:picker animated:YES completion:nil];
    
}

//打开本地相册
-(void)LocalPhoto:(BOOL) isImage
{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.imagePickerDelegate = self;
    if (isImage) {
        
        elcPicker.maximumImagesCount = 6; //Set the maximum number of images to select to 100
        elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
        elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
        elcPicker.onOrder = NO; //For multiple image selection, display and return order of selected images
        elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //Supports image and movie types
        
    }else
    {
        elcPicker.maximumImagesCount = 1; //Set the maximum number of images to select to 100
        elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
        elcPicker.returnsImage = NO; //Return UIimage if YES. If NO, only return asset location information
        elcPicker.onOrder = NO; //For multiple image selection, display and return order of selected images
        elcPicker.mediaTypes = @[(NSString *)kUTTypeMovie]; //Supports image and movie types
    }
    
    [self presentViewController:elcPicker animated:YES completion:nil];
    
}


#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    NSString *urlStr = nil;
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }
        else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo)
        {
            NSURL *url=[dict objectForKey:UIImagePickerControllerMediaURL];//视频路径
            urlStr=[url path];
        }
    }
    
    if (images.count>0) {
        [model.eventPic addObjectsFromArray:images];
        [mPicker setImages:model.eventPic];
    }
    if (urlStr && urlStr.length>0) {
        model.eventVideo = urlStr;
        [mPicker setVideo:model.eventVideo];
    }
    
    [mPicker relayout];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) mediaRemove:(NSNotification *)noti
{
    BOOL isImage = [noti.userInfo[@"itemType"] isEqualToString:@"image"];
    NSNumber *index = noti.userInfo[@"index"];
    if (isImage) {
        [model.eventPic removeObjectAtIndex:index.intValue];
    }else
    {
        model.eventVideo = nil;
    }
}
@end
