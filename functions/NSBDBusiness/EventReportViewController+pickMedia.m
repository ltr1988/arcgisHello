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
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
        [mediaList addObject:image];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相簿
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//如果是录制视频
        NSLog(@"video...");
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        NSString *urlStr=[url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
        }
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
