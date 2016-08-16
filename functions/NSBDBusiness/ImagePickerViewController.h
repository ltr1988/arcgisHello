//
//  ImagePickerViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ELCImagePickerController.h"

@interface ImagePickerViewController :SupportRotationSelectBaseViewController<UIActionSheetDelegate,ELCImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end
