//
//  MediaPickerManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MediaPickerManager.h"
#import "NSString+LVPath.h"
#import <AVFoundation/AVAssetExportSession.h>
#import "UIImage+Watermark.h"

@implementation MediaPickerManager

-(instancetype) initWithViewController:(UIViewController *)vc ImagePickBlock:(ImagePickBlock) iblock VideoPickBlock:(VideoPickBlock) vblock
{
    if (self = [super init]) {
        self.weakVC = vc;
        self.imagePickBlock = iblock;
        self.videoPickBlock = vblock;
    }
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
        return;
    }
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"打开照相机"])
    {
        [self takePhoto:_pickImage];
    }
    else
    {
        [self LocalPhoto:_pickImage];
    }
    
}

-(void)openMenuInView:(UIView *)view
{
    UIActionSheet *myActionSheet;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        
        myActionSheet = [[UIActionSheet alloc]
                         initWithTitle:nil
                         delegate:self
                         cancelButtonTitle:@"取消"
                         destructiveButtonTitle:nil
                         otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    }else
    {
        myActionSheet = [[UIActionSheet alloc]
                         initWithTitle:nil
                         delegate:self
                         cancelButtonTitle:@"取消"
                         destructiveButtonTitle:nil
                         otherButtonTitles: @"从手机相册获取",nil];
    }
    
    [myActionSheet showInView:view];
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
    
    [_weakVC presentViewController:picker animated:YES completion:nil];
    
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
        elcPicker.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *) kUTTypeMPEG4]; //Supports image and movie types
    }
    
    [_weakVC presentViewController:elcPicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (_imagePickBlock) {
            _imagePickBlock(@[image]);
        }
    }
    else if ([mediaType isEqualToString:@"public.movie"]){
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        
        [MediaPickerManager movContertToMp4:videoURL completeBlock:^(NSURL *vURL) {
            UISaveVideoAtPathToSavedPhotosAlbum([vURL path], self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {
    
    NSLog(@"%@",videoPath);
    
    NSLog(@"%@",error);
    if (_videoPickBlock)
    {
        _videoPickBlock([NSURL fileURLWithPath:videoPath]);
    }
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_weakVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [_weakVC dismissViewControllerAnimated:YES completion:nil];
    
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];

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
            NSURL *url=[dict objectForKey:UIImagePickerControllerReferenceURL];//视频路径
            [MediaPickerManager movContertToMp4:url completeBlock:^(NSURL *videoURL) {
                
                NSURL *urlStr = videoURL;
                if (urlStr) {
                    if (_videoPickBlock) {
                        _videoPickBlock(urlStr);
                    }
                }
            }];
            
        }
    }
    
    if (images.count>0) {
        if (_imagePickBlock) {
            _imagePickBlock(images);
        }
    }
    
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [_weakVC dismissViewControllerAnimated:YES completion:nil];
}


+(void) movContertToMp4:(NSURL *)sourceUrl completeBlock:(VideoPickBlock) block
{
    NSString* fileNameWithExtension = sourceUrl.lastPathComponent;
    NSString* fileName = [fileNameWithExtension stringByDeletingPathExtension];
    
    NSString * resultPath = [[NSString documentsPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",fileName]];
    
    //exist file 
    if ([[NSFileManager defaultManager] fileExistsAtPath:resultPath])
    {
        if (block) {
            block([NSURL fileURLWithPath:resultPath]);
        }
        return;
    }
    
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:sourceUrl options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    NSLog(@"%@",compatiblePresets);
    
    
    
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetLowQuality];
    
    NSLog(@"resultPath = %@",resultPath);
    
    exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
    
    exportSession.outputFileType = AVFileTypeMPEG4;
    
    exportSession.shouldOptimizeForNetworkUse = YES;
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         
         switch (exportSession.status) {
                 
             case AVAssetExportSessionStatusUnknown:
                 
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 
                 break;
                 
             case AVAssetExportSessionStatusWaiting:
                 
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 
                 break;
                 
             case AVAssetExportSessionStatusExporting:
                 
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 
                 break;
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 
                 break;
             case AVAssetExportSessionStatusCompleted:
                 if (block) {
                     block(exportSession.outputURL);
                 }
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 
                 break;
                 
             case AVAssetExportSessionStatusFailed:
                 if (block) {
                     block(nil);
                 }
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 
                 break;
                 
         }
         
     }];
}

@end
